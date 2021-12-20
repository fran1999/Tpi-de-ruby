module Export

    require 'prawn' #gema necesaria para la crear pdf


    Horario =["9:00","9:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00","19:30"]

    def self.crear_pdf(turnos)
        #turnos contiene una hash con los turnos de cada dia 
        pdf = Prawn::Document.new
        data = [["Hora/Dia", *turnos.keys]] #header, tiene los o el dia a mostrar
        data += self.generar_tabla(pdf,turnos) #cargo la informacion del resto de filas de la tabla
        pdf.table(data, :header => true ,:row_colors => ["F0F0F0", "FFFFCC"], :cell_style => { :size => 9})
        pdf.render
    end

    def self.generar_tabla(pdf, turnos)
        #En este metodo genero un arreglo con filas que van a ir a la tabla con la infoamcionde cada bloque de horarios
        Horario.inject([]) do |data, hora| #por cada horario
            data+= [
                self.fila(pdf,turnos,hora) #genero una fila
                ]
        end
    end

    def self.fila(pdf,turnos,hora)
        #esta funcion genera una fila con la informacion de cada dia
        turnos.keys.inject(["#{hora}"]) do |row,key| 
            if turnos[key].select { |appointment| appointment.date.strftime("%Y-%m-%d_%H:%M") == "#{key}_#{hora}" }.empty? #
                row.push("")    #genero celda vacia 
            else 
                row.push(self.make_subtable(pdf,turnos,key,hora)) #genero una celda con la informacion del horario
            end
        end
    end

    def self.make_subtable(pdf,turnos,key,hora)
        #ingreso la informacionde cada horario
        pdf.make_table((turnos[key].select { |appointment| appointment.date.strftime("%Y-%m-%d_%H:%M") == "#{key}_#{hora}" })
                .map{ |appointment| [appointment.schedule_format]}, :cell_style => {:size => 9 , :width => 70})
    end

end