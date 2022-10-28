# frozen_string_literal: true

require 'test_helper'

class MovieTimeTest < ActiveSupport::TestCase
  
  def teardown
    MovieTime.destroy_all
    Movie.destroy_all
  end

  test 'Programar película en sala ya ocupada' do
    movie = Movie.create(title: 'Movie')
    movie_time = MovieTime.create(room: 5, date_start: Date.new(2022, 10, 10),
                     date_end: Date.new(2022, 10, 12),
                     time: 'TANDA', movie_id: movie.id)
    new_movie_time = MovieTime.create(room: 5, date_start: Date.new(2022, 10, 11),
                         date_end: Date.new(2022, 10, 12),
                         time: 'TANDA', movie_id: movie.id)
    assert_equal(false, new_movie_time.valid?)
  end

  test 'Fecha de inicio tiene que ser igual o previa a fecha de término' do
    movie = Movie.create(title: 'Movie')
    new_movie_time = MovieTime.create(room: 6, date_start: Date.new(2022, 10, 11),
                         date_end: Date.new(2022, 10, 10),
                         time: 'TANDA', movie_id: movie.id)
    assert_equal(false, new_movie_time.valid?)
  end

end
