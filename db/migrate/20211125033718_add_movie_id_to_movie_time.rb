# frozen_string_literal: true

class AddMovieIdToMovieTime < ActiveRecord::Migration[6.1]
  def change
    remove_column :movie_times, :movie, :string
    add_reference :movie_times, :movie, null: false, foreign_key: true
  end
end
