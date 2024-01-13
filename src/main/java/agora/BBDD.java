package agora; //Esto declara que la clase BBDD pertenece al paquete llamado "agora". 

//Los paquetes son utilizados para organizar y estructurar el código en Java, 
//y permiten evitar conflictos de nombres entre clases.

import java.sql.Connection; //Importa la clase Connection del paquete java.sql. 
							//La clase Connection se utiliza para establecer una conexión con una base de datos.
import java.sql.DriverManager; //En este caso, se usa para cargar el controlador de MySQL.
import java.sql.ResultSet; // Importa la clase ResultSet del paquete java.sql. ResultSet representa el conjunto 
							//de resultados de una consulta SQL y proporciona métodos para acceder a los datos.
import java.sql.SQLException; //Es una excepción específica para manejar errores relacionados con SQL.
import java.sql.Statement; //Se utiliza para ejecutar declaraciones SQL y devolver resultados.

public class BBDD {	
	

	// CONEXIÓN BBDD
	private static Statement connectBBDD() { 
		try {
			// Esta línea informa a Java sobre la existencia del controlador JDBC que se
			// utilizará para conectarse a una base de datos MySQL.
			// La clase forName se utiliza para cargar dinámicamente una clase en tiempo de
			// ejecución.
			Class.forName("com.mysql.jdbc.Driver");
			// Establecer la conexión con la base de datos 'agora' en localhost, puerto
			// 3306, usuario 'root', sin contraseña
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/agora", "root", "");
			// Crear un OBJETO Statement para ejecutar consultas SQL
			Statement statement = connection.createStatement();
			// Ejecutar la consulta SQL y devolver el resultado como un conjunto de
			// resultados (ResultSet)
			return statement;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}

	}

	// Método privado que ejecuta una consulta SQL y devuelve el ResultSet
	private static ResultSet execQuery(String query) { 

		try {

			Statement statement = connectBBDD();

			return statement.executeQuery(query);

		} catch (Exception e) {
			// En caso de error, imprimir la traza del error
			e.printStackTrace();

		}
		// En caso de error, devolver null
		return null;
	}

	//Ejecuta una consulta (insert o update) y devuelve el primer elemento (primary key, el id) del evento creado, eliminado o editado
	private static String executeInsertUpdateAndGetGeneratedKey(String query) { 
		try {

			Statement statement = connectBBDD();

			int result = statement.executeUpdate(query, Statement.RETURN_GENERATED_KEYS);
			if (result > 0) {
				ResultSet rs = statement.getGeneratedKeys();
				if (rs.next()) {
					return rs.getString(1);
				}
			}
			return "";

		} catch (Exception e) {

			e.printStackTrace();

		}

		return null;
	}
	

	// Método público que verifica si un usuario es válido basándose en el nombre de usuario y la contraseña 
	public static boolean isValidUser(String username, String password) { 
		// Creamos la consulta SQL para verificar la validez del usuario
		String query = "Select * FROM user WHERE name ='" + username + "' AND password ='" + password + "';";
		// Ejecutar la consulta (execQuery) y obtener el resultado y lo guardamos en un
		// ResulSet
		ResultSet result = execQuery(query);
		try {
			// Verificar si hay al menos una fila en el resultado, lo que indica que el usuario es válido
			if (result.next()) {
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			// En caso de error al procesar el resultado, imprimir la traza del error
			e.printStackTrace();
		}
		// En caso de no encontrar un usuario válido, devolver false
		return false;
	}

	// Método público que devuelve un conjunto de resultados con todos los eventos de la base de datos
	public static ResultSet getEvents() { 
		// Construir la consulta SQL para obtener todos los eventos
		String query = "SELECT event.idEvent, event.name AS nameEvent, event.dateTime, location.name AS nameLocation, event.description FROM event INNER JOIN location ON event.idLocation = location.idLocation ORDER BY event.dateTime ASC;";
		// Ejecutar la consulta y devolver el resultado
		return execQuery(query);

	}

	// Devuelve los datos de un evento por su ID
	public static ResultSet getEventById(String idEvent) { 

		String query = "SELECT event.idEvent, event.name AS nameEvent, event.dateTime, location.name AS nameLocation, event.description FROM event INNER JOIN location ON event.idLocation = location.idLocation WHERE idevent = "
				+ idEvent + " ORDER BY event.dateTime ASC;";
		return execQuery(query);

	}
		
	// Método público que devuelve un conjunto de resultados con todos las localizaciones de la base de datos
	public static ResultSet getLocations() { 
		// Construir la consulta SQL para obtener todos las localizaciones
		String query = "SELECT * FROM location";
		// Ejecutar la consulta y devolver el resultado
		return execQuery(query);

	}

	// Método público que devuelve el token secreto de un usuario verificando en el nombre de usuario y la contraseña 
	public static ResultSet getSecretTokenUser(String username, String password) { 
		// Construir la consulta SQL para obtener el token secreto del usuario
		String query = "SELECT secretToken FROM user WHERE name ='" + username + "' AND password ='" + password + "';";
		// Ejecutar la consulta y devolver el resultado
		return execQuery(query);

	}

	// Devuelve el idUser a través el SecretToken
	public static String getIdUserByST(String secretTokenUser) { 
		String query = "SELECT idUser FROM user WHERE secretToken ='" + secretTokenUser + "';";
		ResultSet rs = execQuery(query);
		try {
			rs.next();
			String idUser = rs.getString("idUser");
			return idUser;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;

	}

	// Crea un nuevo evento en la bbdd
	public static String generateNewEvent(String idUser, String eventName, String eventLocation, String eventDate, String eventDescription) {
		String query = "INSERT INTO event (idUser,name,idLocation,dateTime,description)	VALUES ('" + idUser + "','"
				+ eventName + "','" + eventLocation + "','" + eventDate + "','" + eventDescription + "');";

		return executeInsertUpdateAndGetGeneratedKey(query);
	}
	
	
	// añade el usuario a un evento
	public static String addParticipantToEvent(String idUser, String idEvent) { 
		String query = "INSERT INTO participants (idUser,idEvent)	VALUES ('" + idUser + "','" + idEvent + "');";
		return executeInsertUpdateAndGetGeneratedKey(query);
	}

	// Obtienes los participantes de un evento
	public static String getParticipantsByEvent(String idEvent) { 
		String query = "SELECT COUNT(*) AS aforo FROM participants WHERE idEvent ='" + idEvent + "';";
		ResultSet rs = execQuery(query);
		try {
			rs.next();
			String aforo = rs.getString("aforo");
			return aforo;
		} catch (SQLException e) {
			e.printStackTrace();
			return "0";
		}

	}

	// Devuelve un boolean si el user está en un evento o no como participante
	public static boolean isUserInEvent(String idEvent, String idUser) { 																		

		String query = "SELECT * FROM participants WHERE idEvent = " + idEvent + " AND idUser =" + idUser + "; ";

		ResultSet result = execQuery(query);
		try {

			if (result.next()) {
				return true;
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}

		return false;
	}

	//Edita un evento
	public static String updateEvent(String idEvent, String eventName, String eventLocation, String eventDate,String eventDescription) {
		String query = "UPDATE event SET idLocation= '" + eventLocation + "',name='" + eventName + "', dateTime= '"
				+ eventDate + "',description='" + eventDescription + "' WHERE idEvent=" + idEvent + ";";
		return executeInsertUpdateAndGetGeneratedKey(query);
	}

	// Elimina un evento
	public static void deleteEvent(String idEvent) { 
		String query = "DELETE FROM event WHERE idEvent=" + idEvent + ";";
		executeInsertUpdateAndGetGeneratedKey(query);

	}

	// Devuelve boolean si un user es creador o no de un evento
	public static boolean isUserCreator(String idEvent, String idUser) { 

		String query = "Select * FROM event WHERE idEvent =" + idEvent + " AND idUser =" + idUser + ";";

		ResultSet result = execQuery(query);
		try {

			if (result.next()) {
				return true;
			}
		} catch (SQLException e) {
			// En caso de error al procesar el resultado, imprimir la traza del error
			e.printStackTrace();
		}
		// En caso de no encontrar un usuario válido, devolver false
		return false;
	}

	// Creamos nuevo usuario en la BBDD
	public static String generateNewUser(String username, String password, String age, String idLocation, String secretToken) {
		String query = "INSERT INTO user (name,password,age,idLocation,secretToken) VALUES ('" + username + "','"
				+ password + "','" + age + "','" + idLocation + "','" + secretToken + "');";
		System.out.println(query);
		return executeInsertUpdateAndGetGeneratedKey(query);
	}
}
