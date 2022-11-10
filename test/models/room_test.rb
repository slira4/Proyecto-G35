# frozen_string_literal: true

require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  def teardown
    Room.destroy_all
  end

  test 'Habitación creada con parametros validos' do
    room = Room.create(number: 11)
    assert_equal(true, room.valid?)
  end
end
