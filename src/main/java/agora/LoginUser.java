package agora;

import java.io.IOException;

import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginUser
 */
@WebServlet("/loginUser") // Esto es el código que se ejecuta al llamar a esta URL
public class LoginUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginUser() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 * 
	 */

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Obtiene el valor del parámetro "username" de la solicitud POST.
		String username = request.getParameter("username");

		// Obtiene el valor del parámetro "password" de la solicitud POST.
		String password = request.getParameter("password");

		String age = request.getParameter("age");

		String idLocation = request.getParameter("idLocation");

		// Llama al método isValidUser de la clase BBDD para verificar si el usuario es
		// válido
		boolean isValid = BBDD.isValidUser(username, password);

		if (isValid) {
			// Si el usuario es válido, llama al método getSecretTokenUser de la clase BBDD
			// para obtener el token secreto del usuario.
			try {
				ResultSet secretToken = BBDD.getSecretTokenUser(username, password);
				// Mueve el cursor al primer resultado en el conjunto de resultados.
				secretToken.next();
				// Obtiene el valor de la columna "secretToken" del conjunto de resultados.
				String st = secretToken.getString("secretToken");
				// Redirige la respuesta a "events.jsp" con el token secreto como parámetro.
				response.sendRedirect(request.getContextPath() + "/events.jsp?st=" + st);
			} catch (SQLException e) {
				// Maneja excepciones de SQL. Si ocurre un error al obtener el token secreto,
				// imprime la traza del error y redirige a "index.jsp".
				// TODO Auto-generated catch block
				e.printStackTrace();
				response.sendRedirect(request.getContextPath() + "/index.jsp");
			}
			// Redirige a "index.jsp" si el usuario no es válido o hay un error en la
			// obtención del token secreto.
		} else {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
		}
	}
}
