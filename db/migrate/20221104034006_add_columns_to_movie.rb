# frozen_string_literal: true

class AddColumnsToMovie < ActiveRecord::Migration[7.0]
  def change
    change_table :movies, bulk: true do |t|
      t.integer :movies, :age
      t.string :movies, :sucursal
      t.string :movies, :languaje
    end
  end
end
