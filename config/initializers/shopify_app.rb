ShopifyAPI::Context.setup(
  api_key: ENV['SHOPIFY_API_KEY'],
  api_secret_key: ENV['SHOPIFY_API_SECRET'],
  host: ENV['HOST'],
  scope: 'write_products,read_products',
  is_embedded: true,
  api_version: '2023-04',
  is_private: true
)
