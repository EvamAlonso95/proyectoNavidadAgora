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
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String age = request.getParameter("age");
		String idLocation = request.getParameter("idLocation");

		// https://stackoverflow.com/questions/1389736/how-do-i-create-a-unique-id-in-java
		String secretToken = UUID.randomUUID().toString();
		BBDD.generateNewUser(username, password, age, idLocation, secretToken);

		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}

}
