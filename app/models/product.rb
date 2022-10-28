# frozen_string_literal: true

#  Model for product
class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :price, numericality: { only_integer: true }
  validates :category, presence: true
  validates :category, inclusion: { in: %w[Bebestible Comestible Souvenir],
                                    message: '%<value>s is not a valid category' }

  validate :category_weight_volume

  def category_weight_volume
    unless category == 'Souvenir'
      user_num = begin
        Integer(:weight_volume)
      rescue StandardError
        false
      end
      errors.add(:weight_volume, 'has to be an integer') if user_num
      if weight_volume.blank?
        errors.add(:weight_volume, "can't be blank if category is not Souvenir")
        return false
      end
    end
    true
  end
end
