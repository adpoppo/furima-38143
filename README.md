# テーブル設計

## users テーブル

|Column            |Type  |Options    |
|------------------|------|-----------|
|nickname          |string|null: false|
|email             |string|null: false|
|encrypted_password|string|null: false|
|last_name         |string|null: false|
|first_name        |string|null: false|
|last_name_kana    |string|null: false|
|first_name_kana   |string|null: false|
|birth_year        |string|null: false|
|birth_month       |string|null: false|
|birth_day         |string|null: false|

### Association

- has_many :items
- has_many :purchase_records

## items テーブル

|Column          |Type  |Options    |
|----------------|------|-----------|
|image           |      |null: false|
|item_name       |string|null: false|
|item_description|text  |null: false|
|category        |string|null: false|
|condition       |string|null: false|
|freight         |string|null: false|
|ship_address    |string|null: false|
|ship_day        |string|null: false|
|price           |string|null: false|
|user_id         |string|null: false|

### Association

- belongs_to :user
- has_one :purchase_record

## purchase_records テーブル

|Column |Type  |Options    |
|-------|------|-----------|
|user_id|string|null: false|

### Association

- belongs_to :user
- belongs_to item
- has_one :customer_address

## customer_addresses テーブル

|Column      |Type   |Options    |
|------------|-------|-----------|
|postal_code |integer|null: false|
|region      |string |null: false|
|city        |string |null: false|
|block       |string |null: false|
|building    |string |null: false|
|phone_number|integer|null: false|

### Association

-belongs_to :purchase_record