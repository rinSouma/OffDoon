#OffDoon APIリファレンス

---

## アクセスキーの取得

右側メニューのアイコンを押すとアクセスキー発行画面へ遷移

キーを生成ボタンでアクセスキーを生成する

---

## Event取得API

> GET /api/v1/event

#### HEAD

|項目|設定値|
|:--|:--|
|token|取得したアクセスキー|

#### パラメタ

|項目|設定値|
|:--|:--|
|id|イベントID|
|title|タイトル（部分一致）|
|id_from|イベントID（最小値）|
|id_to|イベントID（最大値）|
|update_from|更新日時（最小値）yyyy-mm-dd hh:mm:dd|
|update_to|更新日時（最大値）yyyy-mm-dd hh:mm:dd|
|limit|取得最大件数（最大20 / デフォルト10）|
