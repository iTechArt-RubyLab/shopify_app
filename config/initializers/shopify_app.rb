ShopifyAPI::Context.setup(
  api_key: ENV['SHOPIFY_API_KEY'],
  api_secret_key: ENV['SHOPIFY_API_SECRET'],
  host: ENV['HOST'],
  scope: 'write_products,read_products,read_customers',
  is_embedded: false,
  api_version: '2023-04',
  is_private: false
)
