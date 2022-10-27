# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :price, numericality: { only_integer: true }
  validates :category, presence: true
  validates :size, inclusion: { in: %w[Bebestible Comestible Souvenir],
                                message: '%<value>s is not a valid category' }
  validates :weight_volume, numericality: { only_integer: true }
end
