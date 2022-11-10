# frozen_string_literal: true

class AddColumnsToMovie < ActiveRecord::Migration[7.0]
  def change
    change_table :movies, bulk: true do |t|
      t.column :movies, :age, :integer
      t.column :movies, :sucursal, :string
      t.column :movies, :languaje, :string
    end
  end
end
