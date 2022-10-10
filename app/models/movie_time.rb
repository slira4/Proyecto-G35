# frozen_string_literal: true

# Model that represents a movie assign to a room on a specific time and date range
class MovieTime < ApplicationRecord
  belongs_to :movie
  validates :room, presence: { message: 'Falta la sala' },
                   numericality: { only_integer: true, greater_than: 0,
                                   less_than_or_equal_to: 8, message: 'La sala no existe' }
  validates :time, presence: { message: 'Falta el horario' },
                   inclusion: { in: %w[MATINÉ TANDA NOCHE],
                                message: '%<value>s no es un horario valido' }
  validates :date_start, presence: { message: 'Falta la fecha inicial' }
  validates :date_end, presence: { message: 'Falta la fecha final' }
  validates :movie_id, presence: { message: 'Falta elegir una pelicula' }
  validate :validate_date

  def validate_date
    return if date_start.nil? || date_end.nil?

    if date_start > date_end
      errors.add(:date_start,
                 'El día de inicio tiene que ser antes o igual al día de termino')
    end
    # rubocop:disable Layout/LineLength
    query_text = '((? <= date_end and ? >= date_start) or (? <= date_end and ? >= date_start)) and time = ? and room = ?'
    # rubocop:enable Layout/LineLength
    query = MovieTime.where([query_text, date_start, date_start, date_end, date_end, time, room])
    # rubocop:disable Style/GuardClause
    if query.length.positive?
      errors.add(
        :room, "La sala esta ocupada entre #{query[0].date_start} y el #{query[0].date_end}"
      )
    end
    # rubocop:enable Style/GuardClause
  end
end
