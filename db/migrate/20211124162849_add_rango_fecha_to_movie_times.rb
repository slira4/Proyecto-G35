# frozen_string_literal: true

class AddRangoFechaToMovieTimes < ActiveRecord::Migration[6.1]
  def change
    change_table :movie_times, bulk: true do |t|
      t.date :date_start, null: false
      t.date :date_enf, null: false
    end
  end
end
