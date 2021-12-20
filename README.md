# Polycon
Polycon es una herramienta desarrollada para gestionar la agenda de turnos de un policonsultorio, organizando los turnos de cada profesional con sus respectivos pacientes La herramienta fue implementada como proyecto para el taller de tecnologías de producción de software, Opción Ruby, de la Universidad Nacional De La Plata

# Instalación de dependencias
Para descargar las dependencias se usa bundle y se usa de esta manera 
$ bundle install

# Pasos para utilizar la aplicacion
Instalar rails, puede hacerse con el siguiente comando:
$ gem install rails

Actualizar las dependencias, esto se hace mediante bundle install
$ bundle install

Ejecutar las migraciones, esto generara la estructura de la base de datos que necesitara la pagina. Puede hacerse mediante el comando
$ rails db:migrate


# Decisiones de diseño de la tercer entrega
Para la autenticacion, manejo de permisos y de sesiones de los usuarios se utilizo la gema bcrypt, esta gema ya viene en el gemfile de la app rails pero comentada. 

Para el manejo de permisos se opto por verificar que los usuarios posean el rol permitido a la hora de ejecutar ciertas acciones, (como una baja o una edicion). Además, se definieron un par de helpers para el determinar que botones se muestran en el html segun el rol del usuario.

En cuanto a las validaciones de turnos:

Los turnos se organizan dentro del rango de 9 a 19:30hs y cada turno dura media hora por lo tanto solo se registraran turnos con estos minutos 0 o 30. 

En el campo de telefono de un turno solo deben ingresarse numeros.
Además, no pueden haber 2 turnos para un mismo profesional a la misma hora.

Para los profesionales, no se añadió ninguna validacion a la hora de crearlos, ya que al poseer solo el nombre y el hecho de que un nombre no suele ser unico, se permitió la carga de profesionales con mismo nombre. Sin embargo, si se presenta una validacion a la hora de eliminarlos, ya que en caso de tener turnos asignados no podrá ser eliminado.

Los usuarios de la aplicacion tienen un nombre de usuario unico y su contraseña debe ser de al menos 6 caracteres.

En exportar las planillas de turnos de los profesionales se utilizaron las mismas gemas que en la entrega pasada, siendo estas prawn y prawn-table. 

Para la base de datos de la aplicacion se utilizo SQLite, principalmente por recomendaciond de la catedra.
