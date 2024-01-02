package agora;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddParticipant
 */
@WebServlet("/addParticipant")
public class AddParticipant extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddParticipant() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		String secretTokenUser = request.getParameter("st");

		String idUser = BBDD.getIdUserByST(secretTokenUser);

		String idEvent = request.getParameter("idEvent");

		BBDD.addParticipantToEvent(idUser, idEvent);

		response.sendRedirect(request.getContextPath() + "/events.jsp?st=" + secretTokenUser);

	}

}
