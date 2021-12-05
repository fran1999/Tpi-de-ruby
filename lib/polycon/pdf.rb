module Polycon
    module Pdf
        require 'prawn'

        def self.create_pdf(professional,appointments,*date)
            Prawn::Document.generate(self.nombrePdf(date,professional)) do |pdf|
                data = [["Hora/Dia", *date]] #se guarda el o los dias a mostrar
                data += self.generate_table(pdf,appointments) #se carga la informacion del resto de filas de la tabla
                pdf.table(data, :header => true ,:row_colors => ["F0F0F0", "FFFFCC"], :cell_style => { :size => 11})# se crea la tabla con su color
            end
        end

        def self.nombrePdf(date,professional)
            #en este metodo crea el archivo con el nombre y la rura donde se guarda en este caso se guarda en horarios
            professional ||= "all"
            if ! Dir.exist?(Dir.home << "/.horarios") then
                Dir.mkdir(Dir.home << "/.horarios")
            dir = Dir.home << "/.horarios"
            p dir 
            if date.length > 1 then
                "#{dir}/turnos-semanal-_#{date.first}-#{professional}.pdf"
            else
                "#{dir}/turnos_#{date.first}-#{professional}.pdf"
            end
        end

        def self.generate_table(pdf, appointments)
            #en este metodo que genera una lista con las filas de la tabla con la informacion de los turnos de cada bloque horario 
            schedule = ["9-00","9-30","10-00","10-30","11-00","11-30","12-00","12-30","13-00","13-30","14-00","14-30","15-00","15-30","16-00","16-30","17-00","17-30","18-00","18-30","19-00","19-30"]
            schedule.inject([]) do |data, hour| #por cada bloque de tiempo
                data+= [
                    self.make_row(pdf,appointments,hour) #llamo al metodo para generar filas
                    ]
            end
        end
        def self.make_row(pdf,appointments,hour)
            #en este metodo se genera una fila con la informacion de los turnos 
            appointments.keys.inject(["#{hour}"]) do |row,key| # se genera una celda por cada dia 
                if appointments[key].select { |appointment| appointment.date == "#{key}_#{hour}" }.empty? #se genera una celda vacia dia y hora si no hay un turno
                    row.push("")
                else #se genera una celda con la info de cada turno
                    row.push(self.make_subtable(pdf,appointments,key,hour)) #se genera una celda con informacion de cada turno 
                end
            end
        end
        def self.make_subtable(pdf,appointments,key,hour)
            #en este metodo que genera una celda con la informacion de cada turno en ese dia y bloque horario
            pdf.make_table((appointments[key].select { |appointment| appointment.date == "#{key}_#{hour}" })
                    .map{ |appointment| [appointment.schedule_format]}, :cell_style => {:size => 9 , :width => 70})
        end

    end
end
