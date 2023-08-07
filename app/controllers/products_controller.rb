class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :create_session, only: %i[create update destroy search]

  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @shopify_product = ShopifyAPI::Product.new(session: @session)
    assign_product_attributes(product_params)
    @local_product = Product.new(product_params)

    if @shopify_product.save!
      @local_product.shopify_id = @shopify_product.id
      @local_product.save!
      redirect_to products_path, notice: 'Product was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @shopify_product = ShopifyAPI::Product.find(session: @session, id: @product.shopify_id)
    assign_product_attributes(product_params)
    if @shopify_product.save! && @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @shopify_product = ShopifyAPI::Product.find(session: @session, id: @product.shopify_id)
    return unless @product.destroy && @shopify_product.delete

    redirect_to products_path, notice: 'The product was successfully destroyed.'
  end

  def search
    url = URI.parse('https://rubylab2.myshopify.com/admin/api/2023-04/graphql.json')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
  
    request = Net::HTTP::Post.new(url.path)
    request['Content-Type'] = 'application/json'
    request['X-Shopify-Access-Token'] = cookies[:shopify_app_session]
  
    request.body = {
      query: <<~GRAPHQL,
        query($searchTerm: String) {
          products(first: 10, query: $searchTerm) {
            edges {
              node {
                id
                title
              }
            }
          }
        }
      GRAPHQL
      variables: { "searchTerm" => params[:query] }
    }.to_json
  
    response = http.request(request)
    result = JSON.parse(response.body)
    render json: result
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :body_html, :status, :vendor)
  end

  def assign_product_attributes(product_params)
    @shopify_product.title = product_params[:title]
    @shopify_product.body_html = product_params[:body_html]
    @shopify_product.status = product_params[:status]
    @shopify_product.vendor = product_params[:vendor]
  end

  def create_session
    @session = ShopifyAPI::Auth::Session.new(shop: ENV['SHOP'], access_token: cookies[:shopify_app_session])
  end
end
