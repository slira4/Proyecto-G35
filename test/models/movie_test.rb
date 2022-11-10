# frozen_string_literal: true

require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  def teardown
    Movie.destroy_all
  end

  test 'Movie con párametros válidos' do
    movie = Movie.create(title: 'Matrix', age: 18, sucursal: 'Santiago', languaje: 'Español')
    assert_equal(true, movie.valid?)
  end
end
