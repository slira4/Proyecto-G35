# frozen_string_literal: true

class FixTypo < ActiveRecord::Migration[6.1]
  def change
    rename_column :movie_times, :date_enf, :date_end
  end
end
