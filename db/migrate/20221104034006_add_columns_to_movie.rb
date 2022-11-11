# frozen_string_literal: true

class AddColumnsToMovie < ActiveRecord::Migration[7.0]
  def change
    change_table :movies, bulk: true do |t|
      t.integer :age
      t.string :sucursal
      t.string :languaje
    end
  end
end
