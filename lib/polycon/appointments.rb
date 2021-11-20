module Polycon
    class Appointment

        attr_accessor :date, :prof, :name , :surname, :phone, :notes
        def initialize(date="", prof="", name="", surname="", phone="", notes=nil)
            @date=date
            @prof=prof
            @name=name
            @surname=surname
            @phone=phone
            @notes=notes
        end

        def exist? (date, professional)
            File.exist?"#{Dir.home}/.polycon/#{professional}/#{date}.paf"
        end

        def create_file(turn)
            File.open( turn, "w") do |file|
                file.write( "#{@surname} \n")
                file.write( "#{@name} \n")
                file.write( "#{@phone} \n")
                file.write( "#{@notes} \n")
            end

        end

        def create(professional, date)
            if not Professional.new.exist?(professional) #reviso que el profesional no exista
                message = "ERROR: No se encontró el profesional ingresado"
            elsif exist?(date,professional) #reviso que el turno para ese profesional no exista
                message = "ERROR: Ya existe el turno para el profesional #{professional} el dia #{date}"
            else
                name_file=date.gsub(" ","_")
                turn="#{Dir.home}/.polycon/#{professional}/#{name_file}.paf"
                create_file(turn)
                message = "se creo el turno exitosamente"
            end
            return message
        end

        def list_turn(profesional)
            if Dir.children("#{Dir.home}/.polycon/#{profesional}").empty?
                warn "El profesional #{profesional} no tiene turnos "
            else
                turn=Dir.chdir(Dir.home + "/.polycon/#{profesional}")
                professional = Dir.glob('*').select {|f| File.file? f}
                professional.each {|pro| p pro}
            end
        end

        def read(route)
            File.open(route,'r').each do |line| puts line end 
        end

        def show_turn(professional, date)
            if not Professional.new.exist?(professional) #reviso que el profesional no exista
                message = "ERROR: No se encontró el profesional ingresado"
            elsif not exist?(date,professional) #reviso que el turno para ese profesional no exista
                message = "ERROR: No existe el turno para el profesional #{professional} el dia #{date}"
            else
                file = date.gsub(" ","_")
                turn = "#{Dir.home}/.polycon/#{professional}/#{file}.paf"
                return read(turn)

            end
        end

        def cancel(professional, date)
            if not Professional.new.exist?(professional) 
                message = "ERROR: El profesional \"#{professional}\" no se encuentra registrado en el sistema"
            elsif not exist?(date,professional)
                message = "ERROR: El profesional \"#{professional}\" no posee una cita en la fecha #{date}"
            else
                File.delete( "#{Dir.home}/.polycon/#{professional}/#{date}.paf")
                message = "se cancelo con exito"
            end
            return message
        end

        def cancel_all(professional)
          if not Professional.new.exist?(professional)
            message = "ERROR: El profesional no existe "

          elsif Dir.children("#{Dir.home}/.polycon/#{professional}").empty?
            message = "El profesional #{professional} no tiene turnos "

          else
            Dir.children("#{Dir.home}/.polycon/#{professional}").each {|file| File.delete("#{Dir.home}/.polycon/#{professional}/#{file}")}
            message = "se cancelaron todos los tuenos del #{professional}"

          end
          return message
        end

        def rename(new_date,old_date,professional)
          if not Professional.new.exist?(professional) #reviso si existe el profesional
            message= "ERROR: El profesional #{professional} no existe en el sistema o no fue especificado"
          elsif not exist?(old_date,professional) #reviso que si existe el turno para el profesional
            message = "ERROR: El turno del dia #{old_date} del profesional #{professional} no existe en el sistema"
          elsif exist?(new_date,professional) #reviso que el nuevo turno para ese profesional no exista
            message = "ERROR: Ya existe el turno para el profesional #{professional} el dia #{new_date}"
          else
            File.rename("#{Dir.home}/.polycon/#{professional}/#{old_date}.paf","#{Dir.home}/.polycon/#{professional}/#{prof}/#{new_date}.paf")
            message = "El turno se combio con exito"
          end
        end

        def oldTurn(turn)
            File.open( turn, "r") do |file|
                @surname = file.gets.chomp
                @name = file.gets.chomp
                @phone = file.gets.chomp
                @notes = file.gets.chomp
            end
        end

        def edit (professional, date, options)
            puts options
            if not Professional.new.exist?(professional) #verifico si el directorio existe
                message = "ERROR: El profesional \"#{professional}\" no se encuentra registrado en el sistema"
            elsif not exist?(date, professional) #verifico si la fecha existe
                message = "ERROR: El profesional \"#{professional}\" no posee una cita en la fecha #{date}"
            else

                turn="#{Dir.home}/.polycon/#{professional}/#{date}.paf"  
                p (turn)
                self.oldTurn(turn)
                appo = Appointment.new()
                if options.has_key?(:surname)
                    appo.surname = options[:surname]
                else
                    puts @surname
                    appo.surname = @surname
                end
                if options.has_key?(:name)
                    appo.name = options[:name]
                else
                    appo.name = @name
                end
                if options.has_key?(:phone)
                    appo.phone=options[:phone]
                else
                    appo.phone = @phone
                end
                if options.has_key?(:notes)
                    appo.notes = options[:notes]
                else
                    appo.notes = @notes
                end
                appo.create_file(turn)
                message= "Modificado con exito"
            end
            return message

        end

        def get_appointment(date, professional)
            name=File.open("#{Dir.home}/.polycon/#{professional}/#{date}.paf","r").first 
            new(date, professional,name)
        end 
        def list_day(professional, date)
            if professional #caso donde recibo un profesional
                Professionals.new.list_day_professional(professional,date)#genero un arreglo con los turnos del profesional
            else 
                Professionals.list.inject([]) do |turnos,prof| #recorro todos los profesionales
                    pr = Professionals.new(prof)
                    turnos.concat(pr.list_appointments(date)) #guardo los turnos del profesional en un arreglo
                end
            end
        end
    end
    """ef self.list_all(date,professional)
                #metodo que genera un arreglo con todos los turnos del sistema en una fecha especifica, opcionalmente filtrados por un profesional, sera un arreglo vacio si no hay turnos
                if professional #caso donde recibo un profesional
                    prof = Professionals.new(professional)
                    prof.list_appointments(date) #genero un arreglo con los turnos del profesional
                else 
                    Professionals.list_professionals.inject([]) do |turnos,prof| #recorro todos los profesionales
                        pr = Professionals.new(prof)
                        turnos.concat(pr.list_appointments(date)) #guardo los turnos del profesional en un arreglo
                    end
                end
            end"""
end