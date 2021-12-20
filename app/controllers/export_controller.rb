class ExportController < ApplicationController
  before_action :check_auth
  before_action :set_professional, only:[:export_professional]

  def export_all
    if params.include?(:export) && !params[:export][:date].blank?

      date = params[:export][:date].to_date()
      week = params[:export][:week].to_i
      datetime = Time.zone.local(date.year,date.month,date.day)


      if week == 1
        #se ingresa aca si si quiere un listado por semana
        week_start = datetime.beginning_of_week
        week_end = datetime.end_of_week
        appointments = Appointment.where("date BETWEEN ? AND ?", week_start.beginning_of_day, week_end.end_of_day).all.order('date ASC') #busco en la bd los dias de esa semana
        

        week = appointments_week(week_start,week_end)#se genera un diccionario con a valores vacios
      else
        appointments = Appointment.where("date BETWEEN ? AND ?", datetime.beginning_of_day, datetime.end_of_day).all.order('date ASC') #busco en la bd los turnos de ese dia 
        week = { datetime.to_date.to_s => [] }
      end

      #genero un diccionario con esos dias pero vacio
      appointments_day(week,appointments)
      send_data Export.crear_pdf(week), filename:'schedule_professional.pdf', type: "application/pdf", disposition: :attachment
    else
      render 'export_all'
    end
  end


  def export_professional
    

    if params.include?(:export) && !params[:export][:date].blank?

      date = params[:export][:date].to_date()
      week = params[:export][:week].to_i
      datetime = Time.zone.local(date.year,date.month,date.day)


      if week == 1
        week_start = datetime.beginning_of_week
        week_end = datetime.end_of_week
        appointments = Appointment.where("professional_id = ?", @professional.id).where("date BETWEEN ? AND ?", week_start.beginning_of_day, week_end.end_of_day).all.order('date ASC') #busco en la bd los dias de esa semana
        week = appointments_week(week_start,week_end)#se genera un diccionario con a valores vacios
      else
        appointments = Appointment.where("professional_id = ?", @professional.id).where("date BETWEEN ? AND ?", datetime.beginning_of_day, datetime.end_of_day).all.order('date ASC') #busco en la bd los turnos de ese dia
        week = { datetime.to_date.to_s => [] }
      end

      #genero un diccionario con esos dias pero vacio
      appointments_day(week, appointments)
      send_data Export.crear_pdf(week), filename:'schedule_professional.pdf', type: "application/pdf", disposition: :attachment
    else
      render 'export_professional'
    end
  end

  def appointments_week(beginning, final)
    semana = Hash[(beginning.to_date..final.to_date)
        .map { |fecha| fecha.to_s}
        .collect{ |elemento| [elemento, []] }]
   end

  def appointments_day(semana, turnos)
      turnos.each do |turno|
          turno_y_fecha = turno.date.to_date.to_s
          if semana.key?(turno_y_fecha)
            semana[turno_y_fecha].append(turno)
          end
      end
  end

  private
    def set_professional
      @professional = Professional.find(params[:professional_id])
    end

    def check_auth
      if session[:user_id].nil?
        flash[:alert] = "You must be logged in to enter this page!!"
        redirect_to login_path
      end
    end

end
