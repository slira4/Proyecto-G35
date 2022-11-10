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

  # NOT WORKING

  test 'should post a new movie' do
    assert_difference('Movie.count') do
      post "/movie/new", params: { title: 'Batman', image: nil, age: 18, sucursal: 'Santiago', languaje: 'Español' }
    end
      
    assert_redirected_to movie_new_url
  end

  test 'should not post a new movie' do
    post create_movie_url,
         params: { movie: { title: '', image: ''  } }
    assert_redirected_to '/movie/new'
  end

  # ESTE PARA ASIGNAR HORARIOS

  test 'should not assign a movie time' do
    post new_movie_time_url,
         params: { movie_time:
           { movie_time: 'TANDA', movie_id: '1', time: nil,
             date_start: nil, date_end: nil, room: nil } }
  end

  test 'should assign a movie time' do
    movie = Movie.create(title: 'Matrix', age: 18, sucursal: 'Santiago', languaje: 'Español')
    post new_movie_time_url, params: { movie_time: { movie_id: movie.id, time: 'TANDA', date_start: Date.new(2022, 10, 11), date_end: Date.new(2022, 10, 12), room: 5}}
    assert_redirected_to '/movie/new'
  end
  # ESTE PARA FILTRAR POR FECHA

  test 'should filter by date' do
    get movies_by_date_url,
        params: { date: '2000-11-12' }
    assert_response :success
  end

  test 'should filter by languaje' do
    get movies_by_date_url, params: { languaje: 'Español' }
    assert_response :success
  end

  test 'should filter by sucursal' do
    get movies_by_date_url, params: { sucursal: 'Santiago' }
    assert_response :success
  end
end
