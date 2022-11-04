# frozen_string_literal: true

class Movie < ApplicationRecord
  has_one_attached :image
  has_many :movie_times, dependent: :destroy

  validates :title, presence: { message: 'El titulo no puede estar vacio' }, length: {
    maximum: 128, message: 'El titulo tiene que ser de menos de 128 caracteres'
  }
  validates :age, presence:{message: 'Debes ingresar una edad'}, numericality: { only_integer: true, greater_than: 0 }
  validates :sucursal, presence:{message: 'Debes seleccionar una sucursal'}
  validates :languaje, presence:{message: 'Debes seleccionar un idioma'}
end
