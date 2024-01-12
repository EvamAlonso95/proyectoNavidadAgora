package agora;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateEvent
 */
@WebServlet("/updateEvent")
public class UpdateEvent extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateEvent() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// doGet(request,response);
		String eventName = request.getParameter("name");

		String eventLocation = request.getParameter("idLocation");

		String eventDate = request.getParameter("dateTime");

		String eventDescription = request.getParameter("description");

		String secretTokenUser = request.getParameter("secretToken");

		String idUser = BBDD.getIdUserByST(secretTokenUser);

		String idEvent = request.getParameter("idEvent");

		BBDD.updateEvent(idEvent, eventName, eventLocation, eventDate, eventDescription);
		
	
		response.sendRedirect(request.getContextPath() + "/events.jsp?st=" + secretTokenUser);		
		
	}

}
