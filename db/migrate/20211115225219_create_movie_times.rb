# frozen_string_literal: true

class CreateMovieTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_times do |t|
      t.string :movie
      t.integer :room
      t.string :time

      t.timestamps
    end
  end
end
