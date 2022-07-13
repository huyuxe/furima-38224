# テーブル設計
## users テーブル
| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false,unique: true |
| email              | string | null: false,unique: true |
| password           | string | null: false,unique: true |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | date   | null: false |

### Association
- has_many :items
- has_many :orders

## items テーブル
| Column             | Type       | Options     |
| ------------------ | ------     | ----------- |
| user               | references | null: false,foreign_key: true |
| name               | string     | null: false |
| description        | text       | null: false |
| category           | integer    | null: false |
| item_status        | integer    | null: false |
| shipping_cost      | integer    | null: false |
| prefecture         | integer    | null: false |
| shipping_days      | integer    | null: false |
| price              | integer    | null: false |

### Association
- belongs_to :user
- has_one :order

## orders テーブル
| Column             | Type       | Options     |
| ------------------ | ------     | ----------- |
| user               | references | null: false,foreign_key: true |
| item               | string     | null: false,foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :payment


##  paymentsテーブル
| Column             | Type       | Options     |
| ------------------ | ------     | ----------- |
| orders             | references | null: false,foreign_key: true |
| postcode           | string     | null: false |
| prefecture         | integer    | null: false |
| city               | string     | null: false |
| block              | string     | null: false |
| building           | string     |             |
| phone_number       | string     | null: false |

### Association
- belongs_to :order