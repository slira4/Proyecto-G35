# frozen_string_literal: true

require 'test_helper'

class MovieControllerTest < ActionDispatch::IntegrationTest
  def setup; end

  def teardown
    MovieTime.destroy_all
    Movie.destroy_all
  end

  test 'should get new' do
    get movie_new_url
    assert_response :success
  end
end
