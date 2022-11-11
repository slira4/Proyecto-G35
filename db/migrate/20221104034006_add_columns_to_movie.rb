# frozen_string_literal: true

class AddColumnsToMovie < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :age, :integer
    add_column :movies, :sucursal, :string
    add_column :movies, :languaje, :string
  end
end
