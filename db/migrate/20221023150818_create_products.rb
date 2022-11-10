# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :category
      t.integer :weight_volume

      t.timestamps
    end
  end
end
