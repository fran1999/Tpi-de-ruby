module Polycon
    class Appointments

        attr_accessor :date, :prof, :name , :surname, :phone, :notes
        def initialize(date, prof, name, surname, phone, notes=nil)
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

        def create_file(turno)
            File.open( turno, "w") do |file|
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
                turno="#{Dir.home}/.polycon/#{professional}/#{name_file}.paf"
                create_file(turno)
                message = "se creo el turno exitosamente"
            end
            return message
        end

    end
end