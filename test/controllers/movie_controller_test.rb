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

  #NOT WORKING 

  test 'should post a new movie' do
    post create_movie_url,
         params: { movie: { title: 'Batman', image: 'string'} }
    assert_redirected_to '/movie/new'
  end
   

  test 'should not post a new movie' do
      post create_movie_url,
      params: { movie: { title: '', image: ''} }
      assert_redirected_to '/movie/new'
  end

  #ESTE PARA ASIGNAR HORARIOS

  test 'should assign a movie time' do
    post new_movie_time_url,
         params: { movie_time:
           { movie_time:'TANDA', movie_id: '1', time: nil ,
             date_start: nil , date_end: nil, room: nil } }
  end

  #ESTE PARA FILTRAR POR FECHA

  test 'should filter by date' do 
    get movies_by_date_url, 
    params: { date: '2000-11-12' }
    assert_response :success
  end
end
