# frozen_string_literal: true

# The model that represents a reservation of a seat in a room
class Reserva < ApplicationRecord
  validates :sala, presence: true, inclusion: { in: [1, 2, 3, 4, 5, 6, 7, 8],
                                                message: '%<value>s no es una sala existente' },
                   uniqueness: { scope: %i[fecha asiento horario] }
  validates :fecha, presence: true
  validates :asiento, presence: true,
                      numericality: { only_integer: true, greater_than: 0, less_than: 49 }
  validates :horario, presence: true, inclusion: { in: %w[MATINÉ TANDA NOCHE],
                                                   message: '%<value>s no es un horario valido' }
  validates :name, presence: true
  validate :validate_movie_time_exist

  def validate_movie_time_exist
    query = MovieTime.where(['(? <= date_end and ? >= date_start) and time = ? and room = ?',
                             fecha, fecha, horario, sala])
    # rubocop:disable Style/GuardClause
    if query.length.zero?
      errors.add(:none_existing,
                 'No existe una pelicula en esta sala, horario y fecha')
    end
    # rubocop:enable Style/GuardClause
  end
end
