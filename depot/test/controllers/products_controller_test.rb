  require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
    @update = {
      title: 'Lorem Ipsum',
      description: 'Wibbles are fun!',
      image_url:  'lorem.jpg',
      price:      19.95
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: @update
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: @update
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end

  test "should list product details" do
    get :index
    assert_response :success

    assert_select "td", minimum: 3
    assert_select "td img", minimum: 1
    assert_select ".list_description", minimum: 1
    assert_select ".list_actions a", minimum: 3
  end

  test "list actions should not contain empty links" do
    get :index
    assert_response :success

    assert_select ".list_actions a" do
      assert_select "[href=?]", /.+/
    end
  end
end
