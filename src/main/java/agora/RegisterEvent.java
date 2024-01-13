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
 * Servlet implementation class RegisterEvent
 */
@WebServlet("/registerEvent")
public class RegisterEvent extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterEvent() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		
		String eventName = request.getParameter("nameEvent");

		String eventLocation = request.getParameter("idLocation");

		String eventDate = request.getParameter("dateTime");

		String eventDescription = request.getParameter("description");

		String secretTokenUser = request.getParameter("secretToken");

		String idUser = BBDD.getIdUserByST(secretTokenUser);

		String idEvent = BBDD.generateNewEvent(idUser, eventName, eventLocation, eventDate, eventDescription);

		BBDD.addParticipantToEvent(idUser, idEvent);

		response.sendRedirect(request.getContextPath() + "/events.jsp?st=" + secretTokenUser);

	}

}
