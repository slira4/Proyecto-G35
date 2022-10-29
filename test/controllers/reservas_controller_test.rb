# frozen_string_literal: true

require 'test_helper'

class ReservasControllerTest < ActionDispatch::IntegrationTest
  def setup
    movie = Movie.create(title: 'Matrix')
    MovieTime.create(room: 5, date_start: Date.new(2000, 11, 10),
                     date_end: Date.new(2000, 11, 12), time: 'TANDA',
                     movie_id: movie.id)
  end

  def teardown
    Reserva.destroy_all
    MovieTime.destroy_all
    Movie.destroy_all
  end

  test 'should make a new reservation' do
    get new_reserva_url(5, '2000-11-12', 'TANDA'),
        params: { reservation_seats: 'C-3', name: 'Diego' }
    assert_response :success
  end

  test 'Posting a new reserva' do
    assert_difference 'Reserva.count' do
      post new_reserva_url(5, '2000-11-12', 'TANDA'),
           params: { reservation_seats: 'C-3', name: 'Diego' }
    end
  end

  test 'should not validate reservation without name' do
    post new_reserva_url(5, '2000-11-12', 'TANDA'),
         params: { reservation_seats: 'C-3', name: '' }
  end

  test 'should not validate reservation for occupied seat' do
    post new_reserva_url(5, '2000-11-12', 'TANDA'),
         params: { reservation_seats: 'C-3', name: 'Sebastian' }

    post new_reserva_url(5, '2000-11-12', 'TANDA'),
         params: { reservation_seats: 'C-3', name: 'Diego' }
  end

  test 'should not create without selecting seat' do
    post new_reserva_url(5, '2000-11-12', 'TANDA'),
         params: { reservation_seats: '', name: 'Sebastian' }
  end

  test 'should make a new reservationas for a 4 letter seat' do
    assert_difference 'Reserva.count' do
      post new_reserva_url(5, '2000-11-12', 'TANDA'),
           params: { reservation_seats: 'A-12', name: 'Diego' }
    end
  end
end
