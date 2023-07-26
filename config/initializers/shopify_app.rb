ShopifyAPI::Context.setup(
  api_key: ENV['SHOPIFY_API_KEY'],
  api_secret_key: ENV['SHOPIFY_API_SECRET'],
  host: ENV['HOST'],
  scope: ENV.fetch('SCOPES', 'write_products').gsub(/\n/, ''),
  is_embedded: false,
  api_version: '2023-04',
  is_private: false
)
