class CreateAffiliates < ActiveRecord::Migration[5.1]
  def change
    create_table :affiliates do |t|
      t.string :itemName        #商品名
      t.string :catchcopy       #キャッチコピー
      t.string :itemCode        #商品コード
      t.string :itemPrice       #商品価格
      t.string :itemCaption     #商品説明文
      t.string :itemUrl         #商品URL
      t.string :affiliateUrl    #アフィリエイトURL
      t.string :smallImageUrls  #商品画像64x64URL
      t.string :mediumImageUrls #商品画像128x128URL
      t.string :taxFlag         #消費税フラグ
      
      t.timestamps
    end
  end
end
