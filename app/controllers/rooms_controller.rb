require_relative '../views/rooms_view'

class RoomsController
  def initialize(room_repository)
    @room_repository = room_repository
    @view = RoomsView.new
  end

  # Cria um paciente no CSV
  def create
    number = @view.ask_for("number").to_i
    capacity = @view.ask_for("capacity").to_i
    room = Room.new(number: number, capacity: capacity)
    @room_repository.add(room)
  end

  # Lista todos os pacientes atuais
  def list
    rooms = @room_repository.all
    @view.list(rooms)
  end
end