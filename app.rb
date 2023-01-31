require_relative 'router'

require_relative 'app/repositories/patient_repository'
require_relative 'app/controllers/patients_controller'

require_relative 'app/repositories/room_repository'
require_relative 'app/controllers/rooms_controller'

require_relative 'app/repositories/doctor_repository'
require_relative 'app/repositories/appointment_repository'
require_relative 'app/controllers/appointments_controller'

room_repository = RoomRepository.new('data/rooms.csv')
doctor_repository = DoctorRepository.new('data/doctors.csv')
patient_repository = PatientRepository.new('data/patients.csv', room_repository)
appointment_repository = AppointmentRepository.new('data/appointments.csv', patient_repository, doctor_repository)

rooms_controller = RoomsController.new(room_repository)
patients_controller = PatientsController.new(patient_repository, room_repository)
appointments_controller = AppointmentsController.new(appointment_repository, patient_repository, doctor_repository)

app = Router.new(patients_controller, rooms_controller, appointments_controller)
app.run