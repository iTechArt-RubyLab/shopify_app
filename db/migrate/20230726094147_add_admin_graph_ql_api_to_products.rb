class AddAdminGraphQlApiToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :admin_graphql_api_id, :string
  end
end
