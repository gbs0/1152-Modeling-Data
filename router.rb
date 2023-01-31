class Router
  def initialize(patients_controller, rooms_controller, appointments_controller)
    @patients_controller = patients_controller
    @rooms_controller = rooms_controller
    @appointments_controller = appointments_controller
    @running = true
  end

  def run
    while @running
      print_menu
      action = gets.chomp.to_i
      dispatch_action(action)
    end
  end

  private

  def dispatch_action(action)
    case action
      when 1 then @patients_controller.create
      when 2 then @patients_controller.list
      when 3 then @rooms_controller.create
      when 4 then @rooms_controller.list
      when 5 then @appointments_controller.create
      when 6 then @appointments_controller.list
      when 7 then quit!
    end
  end

  def print_menu
    print "\n"
    puts ('-' * 12) + "> Patients Section"
    puts "1. Create a new Patient"
    puts "2. List all Patients"
    puts ('-' * 12) + "> Rooms Section"
    puts "3. Create new Room"
    puts "4. List all Rooms"
    puts ('-' * 12) + "> Appointements Section"
    puts "5. Create new Appointment"
    puts "6. List all Appointments"
    puts "7. Quit"
  end

  def quit!
    @running = false
  end
end