package agora;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RegisterNewUser
 */
@WebServlet("/registerNewUser")
public class RegisterNewUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterNewUser() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//codifica los caracteres para que sean tildes y no caracteres extraños
		request.setCharacterEncoding("UTF-8");
		
		// Obtiene el valor del parámetro "username" de la solicitud POST y se guarda en la variable username
		String username = request.getParameter("username");
		
		// Obtiene el valor del parámetro "password" de la solicitud POST y se guarda en la variable password
		String password = request.getParameter("password");
		
		// Obtiene el valor del parámetro "age" de la solicitud POST y se guarda en la variable age
		String age = request.getParameter("age");
		
		// Obtiene el valor del parámetro "idLocation" de la solicitud POST y se guarda en la variable idLocation
		String idLocation = request.getParameter("idLocation");

		// https://stackoverflow.com/questions/1389736/how-do-i-create-a-unique-id-in-java
		//Creamos un numero que sirva como identificador unico del usuario para saber si está logeado correctamente
		String secretToken = UUID.randomUUID().toString();
		BBDD.generateNewUser(username, password, age, idLocation, secretToken);

		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}

}
