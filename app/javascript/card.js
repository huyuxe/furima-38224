const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); // PAY.JPテスト公開鍵
  
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);
    //ブラウザ上に表示されているフォームの情報を取得

    const card = {
      number: formData.get("order_form[number]"),
      exp_month: formData.get("order_form[exp_month]"),
      exp_year: `20${formData.get("order_form[exp_year]")}`,
      cvc: formData.get("order_form[cvc]"),
    };
    //生成したFormDataオブジェクトから、クレジットカードに関する情報を取得し、変数cardに代入するオブジェクトとして定義

    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        //createTokenメソッドの第一引数には、10〜15行目で定義したクレジットカード情報が入る
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} type="hidden" name='token'>`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
        //HTMLのinput要素にトークンの値を埋め込み、フォームに追加
      }

      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      //クレジットカード情報を取り除く

      document.getElementById("charge-form").submit();
      //フォームの情報をサーバーサイドに送信
    });
    

  });
};

window.addEventListener("load", pay);