module Polycon
    class Professional

        attr_accessor :name 

        def initialize(name="")
            @name=name
        end

        def exist?(name) 
            Dir.exist?(("#{Dir.home}/.polycon/"+"#{name}"))
        end
        
        def create()
            if ! Dir.exist?(Dir.home + "/.polycon/"+ name)
                Dir.mkdir(File.join(Dir.home,"/.polycon/" + name), 0700)
                message="el profesional #{name} fue agregado con exito"
            else
                message="ya exite el profesional #{name}"
            end

            return message
        end
            

        def rename(oldname, newname)
            if Dir.exist?(Dir.home + "/.polycon/" + oldname)
                if !Dir.exist?(Dir.home + "/.polycon/" + newname)
                    File.rename(Dir.home+"/.polycon/"+ oldname, Dir.home + "/.polycon/" + newname)
                    message="El profesional #{oldname} fue renombrado a #{newname} con éxito!"
                else
                    message="El profesional #{oldname} no fue renombrado a #{newname}, ya que ya existe un profesional nombrado así"
                end
            else
                message="No existe un profesional cuyo nombre sea #{oldname}"
            end
            return message 
        end

        def list
            Dir.chdir(Dir.home + "/.polycon/")
            professional = Dir.glob('*').select {|f| File.directory? f}
            professional.each {|pro| p pro}
        end

        def delete(name)
            if Dir.exist?(Dir.home + "/.polycon/" +name)
                FileUtils.remove_dir(Dir.home + "/.polycon/" +name)
                message="El profesional #{name} fue borrado con exito"
            else
                message="El profesional #{name} no existe por lo tanto no puede ser borrado"
            end
        end
        def list_day_professional(professional,date)
            turn = []
            Dir.children("Dir.home"+/.polycon/+"#{professional}").each { |appointment|
                if ((appointment.split("_")[0] == date) || date.nil?)
                    turn << Appointments.get_appointment(appointment.delete(".paf"),professional)
                end
                }
            turn
        end
        def list_appointments(date)
            #Muestra en pantalla todos los turnos del profesional, opcionalmente filtrados por fecha, si no tiene turnos lo informa en pantalla
            turnos = []
            Dir.children(Dir.home+"/.polycon/"+"#{@name}").each { |appointment|
                

                if ((appointment.split("_")[0] == date) || date.nil?)
                    
                    nuevo = Appointment.new.get_appointment(appointment.delete(".paf"),@name) 
                    turnos.push(nuevo)
                end
                }
            turnos

        end
    end
end