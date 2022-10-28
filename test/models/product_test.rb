# frozen_string_literal: true

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  def teardown
    Product.destroy_all
  end

  test 'Crear Producto válido' do
    product = Product.create(name: 'Coke', price:1000, category:'Bebestible', weight_volume:500)
    assert_equal(true, product.valid?)
  end

  test 'Crear Bebestible sin volumen' do
    product = Product.create(name: 'Coke', price:1000, category:'Bebestible', weight_volume: nil)
    assert_equal(false, product.valid?)
  end

  test 'Crear Comestible sin peso' do
    product = Product.create(name: 'Popcorn', price:1000, category:'Comestible', weight_volume: nil)
    assert_equal(false, product.valid?)
  end

  test 'Crear Souvenir sin peso ni volumen' do
    product = Product.create(name: 'Magnet', price:1000, category:'Souvenir', weight_volume: nil)
    assert_equal(true, product.valid?)
  end
end
