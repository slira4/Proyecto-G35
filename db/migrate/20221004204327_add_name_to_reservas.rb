# frozen_string_literal: true

class AddNameToReservas < ActiveRecord::Migration[7.0]
  def change
    add_column :reservas, :name, :string
  end
end
