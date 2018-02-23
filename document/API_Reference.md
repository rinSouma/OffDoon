# OffDoon APIリファレンス

---

## アクセスキーの取得

右側メニューのアイコンを押すとアクセスキー発行画面へ遷移

キーを生成ボタンでアクセスキーを生成する

---

## Event取得API

> GET /api/v1/events

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

全て省略可

#### レイアウト

|項目|値|
|:--|:--|
|id|ユニークキー|
|title|タイトル|
|detail|内容|
|place|場所|
|url|URL|
|date|開催日|
|limit|参加上限|
|uid|作成者ユーザID|
|view|公開区分（0:全体公開、1:ログインユーザにのみ公開、2:同インスタンスのユーザにのみ公開）|
|created_at|作成日時|
|updated_at|更新日時|
|close_time|回答期限|
|members:id|参加者ユニークキー|
|members:uid|参加者ユーザID|
|members:event_id|イベントID|
|members:kbn|参加区分（1:参加希望、2:検討中、3:不参加）|
|members:created_at|参加者作成日時|
|members:updated_at|参加者更新日時|
|comments:id|コメントユニークキー|
|comments:event_id|イベントID|
|comments:comment|コメント|
|comments:uid|コメントユーザID|
|comments:created_at|コメント作成日時|
|comments:updated_at|コメント更新日時|


