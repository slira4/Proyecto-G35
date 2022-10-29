# frozen_string_literal: true

# Controlador para manejar lo relacionado a la creacion de reservas
class ReservasController < ApplicationController
  def new
    @asientos = Array.new(12 * 4, false)
    reservas = Reserva.where(sala: params[:sala], fecha: params[:fecha], horario: params[:horario])
    reservas.each { |x| @asientos[x.asiento - 1] = true }
  end

  def create
    reservas = params[:reservation_seats].split(', ', -1)
    instancias_reservas = []
    reservas.each do |item|
      asiento = get_asiento_value(item)
      reserva = Reserva.new
      reserva.assign_attributes(sala: params[:sala], fecha: params[:fecha], name: params[:name],
                                horario: params[:horario], asiento:)
      instancias_reservas.push(reserva)
    end
    reservas_validation(instancias_reservas)
  end
end

def reservas_validation(instancias_reservas)
  if instancias_reservas.all?(&:valid?)
    reservas_creation(instancias_reservas)
  elsif params[:name].blank?
    redirect_to new_reserva_path(params[:sala], params[:fecha], params[:horario]),
                notice: 'No se ingreso nombre para la reserva'
  else
    redirect_to new_reserva_path(params[:sala], params[:fecha], params[:horario]),
                notice: 'No se pudo completar la reserva ya que uno de los asientos estaba
                               ocupado '
  end
end

def reservas_creation(instancias_reservas)
  if instancias_reservas.empty?
    redirect_to new_reserva_path(params[:sala], params[:fecha], params[:horario]),
                notice: 'Selecciona uno de los asientos para crear una reserva'
  else
    instancias_reservas.each(&:save)
    redirect_to new_reserva_path(params[:sala], params[:fecha], params[:horario], success: true),
                notice: 'Reserva ingresada correctamente'
  end
end

def get_asiento_value(item)
  if item.length == 3
    ((item[0].ord - 65) * 12) + item[-1].to_i
  else
    ((item[0].ord - 65) * 12) + item[2, 4].to_i
  end
end
