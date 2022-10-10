# frozen_string_literal: true

class CreateReservas < ActiveRecord::Migration[6.1]
  def change
    create_table :reservas do |t|
      t.integer :sala
      t.date :fecha
      t.integer :asiento # un numero que representa cada asiento A1=1 B1=13=8*1+1
      t.string :horario

      t.timestamps
    end
    add_index(:reservas, %i[sala fecha asiento horario], unique: true)
  end
end
