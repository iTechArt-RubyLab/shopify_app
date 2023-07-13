class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :shopify_id
      t.text :body_html
      t.string :handle
      t.string :product_type
      t.datetime :published_at
      t.string :published_scope
      t.string :status
      t.string :tags
      t.string :template_suffix
      t.string :vendor

      t.timestamps
    end
  end
end
