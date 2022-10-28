# frozen_string_literal: true

require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @product = products(:one)
  end

  test 'should get index' do
    get products_url
    assert_response :success
  end

  test 'should get new' do
    get new_product_url
    assert_response :success
  end

  test 'should create product' do
    assert_difference('Product.count') do
      post products_url,
           params: { product: { name: 'Coke', price: 1000, category: 'Bebestible', weight_volume: 500 } }
    end

    assert_redirected_to products_url
  end

  test 'should show product' do
    get product_url(@product)
    assert_response :success
  end

  test 'should get edit' do
    get edit_product_url(@product)
    assert_response :success
  end

  test 'should update product' do
    new_product = Product.create(name: 'Coke', price: 1000, category: 'Bebestible', weight_volume: 500)
    patch product_url(new_product.id),
           params: { product: { name: 'Coke', price: 1500, category: 'Bebestible', weight_volume: 500 } }
    assert_redirected_to product_url(new_product.id)
  end

  test 'should destroy product' do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
