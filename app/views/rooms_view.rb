class RoomsView
  def ask_for(parameter) # "name"
    puts "What's the room #{parameter}?"
    gets.chomp
  end
  
  def list(rooms)
    rooms.each do |room|
      puts "- ID: #{room.id} | Number: #{room.number} | Capacity: #{room.capacity} "
    end
  end
end