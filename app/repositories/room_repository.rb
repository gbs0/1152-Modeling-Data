require 'csv'
require_relative '../models/room'

class RoomRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @rooms = []
    load_csv if File.exist?(@csv_file)
    @next_id = @rooms.empty? ? 1 : @rooms.last.id + 1
  end

  def add(room)
    room.id = @next_id
    @rooms.push(room)
    save_csv
    @next_id += 1
  end

  def all
    @rooms
  end

  def find(id)
    @rooms.select { |room| room.id == id }.first
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row) do |row|
      @rooms << Room.new(id: row["id"].to_i, number: row["number"].to_i, capacity: row["capacity"].to_i)
    end
  end

  def save_csv
    CSV.open(@csv_file, 'wb', headers: :first_row) do |file|
      file << ['id', 'number', 'capacity']
      @rooms.each do |room|
        file << [room.id, room.number, room.capacity]
      end
    end
  end

end