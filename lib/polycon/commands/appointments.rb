module Polycon
  module Commands
    module Appointments
      class Create < Dry::CLI::Command
        desc 'Create an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'
        option :name, required: true, desc: "Patient's name"
        option :surname, required: true, desc: "Patient's surname"
        option :phone, required: true, desc: "Patient's phone number"
        option :notes, required: false, desc: "Additional notes for appointment"

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" --name=Carlos --surname=Carlosi --phone=2213334567'
        ]

        def call(date:, professional:, name:, surname:, phone:, notes: nil)
          require 'date'
          def validate_date(date)
            DateTime.strptime(date,"%Y-%m-%d_%H-%M")
            rescue
                false
            else
                true
          end
          warn "TODO: Implementar creación de un turno con fecha '#{date}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          
          if not validate_date(date)
            puts "la fecha esta mal escrita"
          else
            newAppointment = Polycon::Appointment.new(date, professional, name, surname, phone, notes)
            puts newAppointment.create(professional, date)
          end

        end
      end

      class Show < Dry::CLI::Command
        require 'date'
          def validate_date(date)
            DateTime.strptime(date,"%Y-%m-%d_%H-%M")
            rescue
                false
            else
                true
          end
        desc 'Show details for an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" # Shows information for the appointment with Alma Estevez on the specified date and time'
        ]

        def call(date:, professional:)
          warn "TODO: Implementar detalles de un turno con fecha '#{date}' y profesional '#{professional}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          require 'date'
          def validate_date(date)
            DateTime.strptime(date,"%Y-%m-%d_%H-%M")
            rescue
                false
            else
                true
          end
          if not validate_date(date)
            puts "la fecha esta mal escrita"
          else
            Appointment.new.show_turn(professional, date)
          end

        end
      end

      class Cancel < Dry::CLI::Command
        desc 'Cancel an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" # Cancels the appointment with Alma Estevez on the specified date and time'
        ]

        def call(date:, professional:)
          require 'date'
          def validate_date(date)
            DateTime.strptime(date,"%Y-%m-%d_%H-%M")
            rescue
                false
            else
                true
          end
          warn "TODO: Implementar borrado de un turno con fecha '#{date}' y profesional '#{professional}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          if not validate_date(date) #validate the date
            puts "la fecha esta mal escrita"
          else
            puts Appointment.new.cancel(professional, date)
          end
        end
      end

      class CancelAll < Dry::CLI::Command
        desc 'Cancel all appointments for a professional'

        argument :professional, required: true, desc: 'Full name of the professional'

        example [
          '"Alma Estevez" # Cancels all appointments for professional Alma Estevez',
        ]

        def call(professional:)
          warn "TODO: Implementar borrado de todos los turnos de la o el profesional '#{professional}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          
          puts Appointment.new.cancel_all(professional)
        end
      end

      class List < Dry::CLI::Command
        desc 'List appointments for a professional, optionally filtered by a date'

        argument :professional, required: true, desc: 'Full name of the professional'
        option :date, required: false, desc: 'Date to filter appointments by (should be the day)'

        example [
          '"Alma Estevez" # Lists all appointments for Alma Estevez',
          '"Alma Estevez" --date="2021-09-16" # Lists appointments for Alma Estevez on the specified date'
        ]

        def call(professional:)
          warn "TODO: Implementar listado de turnos de la o el profesional '#{professional}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          Appointment.new.list_turn(professional)

        end
      end

      class Reschedule < Dry::CLI::Command
        desc 'Reschedule an appointment'

        argument :old_date, required: true, desc: 'Current date of the appointment'
        argument :new_date, required: true, desc: 'New date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-09-16 13:00" "2021-09-16 14:00" --professional="Alma Estevez" # Reschedules appointment on the first date for professional Alma Estevez to be now on the second date provided'
        ]

        def call(old_date:, new_date:, professional:)
          require 'date'
          def validate_date(date)
            DateTime.strptime(date,"%Y-%m-%d_%H-%M")
            rescue
                false
            else
                true
          end
          warn "TODO: Implementar cambio de fecha de turno con fecha '#{old_date}' para que pase a ser '#{new_date}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          if not validate_date(new_date) #reviso si la fecha recibida es un formato valido
            puts "la fecha esta mal escrita"
          else #se puede intentar eliminar el turno
            puts Appointment.new.rename(new_date,old_date,professional)
          end
        end
      end

      class Edit < Dry::CLI::Command
        desc 'Edit information for an appointments'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'
        option :name, required: false, desc: "Patient's name"
        option :surname, required: false, desc: "Patient's surname"
        option :phone, required: false, desc: "Patient's phone number"
        option :notes, required: false, desc: "Additional notes for appointment"

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" --name="New name" # Only changes the patient\'s name for the specified appointment. The rest of the information remains unchanged.',
          '"2021-09-16 13:00" --professional="Alma Estevez" --name="New name" --surname="New surname" # Changes the patient\'s name and surname for the specified appointment. The rest of the information remains unchanged.',
          '"2021-09-16 13:00" --professional="Alma Estevez" --notes="Some notes for the appointment" # Only changes the notes for the specified appointment. The rest of the information remains unchanged.',
        ]

        def call(date:, professional:, **options)
          require 'date'
          def validate_date(date)
            DateTime.strptime(date,"%Y-%m-%d_%H-%M")
            rescue
                false
            else
                true
          end
          warn "TODO: Implementar modificación de un turno de la o el profesional '#{professional}' con fecha '#{date}', para cambiarle la siguiente información: #{options}.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          if not validate_date(date) #validate the date in the case that enter an incorrect date fomat
            warn "ERROR: la fechas ingresadas no es una fecha valida"

          else
            puts options
            puts Appointment.new.edit(professional, date, options)
          end
        end
      end
      class ListDay < Dry::CLI::Command
        desc 'Cancel an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" # Cancels the appointment with Alma Estevez on the specified date and time'
        ]

        def call(date:, professional:nil)
          require 'date'
          def validate_date(date)
            DateTime.strptime(date,"%Y-%m-%d")
            rescue
                false
            else
                true
          end
          
          if not validate_date(date) #validate the date
            puts "la fecha esta mal escrita"
          else
            puts "#{Dir.home}/.polycon/"
            a = Appointment.new.list_day(date, professional)
            Pdf.create_pdf(professional,{date => a},date)

          end
        end
      end
      class ListWeek < Dry::CLI::Command
        desc 'Cancel an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" # Cancels the appointment with Alma Estevez on the specified date and time'
        ]

        def call(date:, professional:nil)
          require 'date'
          def validate_date(date)
            DateTime.strptime(date,"%Y-%m-%d")
            rescue
                false
            else
                true
          end
          def semana(date)
            #devuelve un arreglo con los 7 dias de la semana de la fecha recibida por paremtro, cada elemento esta en formato string
            date_object = Date.strptime(date,"%Y-%m-%d")
            date_object = date_object - (date_object.wday - 1)%7 #obtengo el primer dia de la semana
            (date_object..date_object+6).map{ |date| date.to_s.strip}
          end
          
          if not validate_date(date) #validate the date
            puts "la fecha esta mal escrita"
          else
            puts "#{Dir.home}/.polycon/"
            p semana(date)
            a = Appointment.new.list_all_week(semana(date), professional)
            Pdf.create_pdf(professional,a, *semana(date))

          end
        end
      end
    end
  end
end
