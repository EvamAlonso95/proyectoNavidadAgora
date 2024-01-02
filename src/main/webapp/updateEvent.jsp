<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="agora.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="charset=UTF-8">
		<title>Update Event</title>
	</head>
	<body>
		<h1>Edita el evento</h1>

		<%
		String idEvent = request.getParameter("idEvent");
		//La query de pedir todos los eventos se guarda en un ResulSet rs
		ResultSet rsEvent = null;
		try {
			rsEvent = BBDD.getEventById(idEvent);
			rsEvent.next();
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/index.jsp");
		}

		String secretToken = request.getParameter("st");
		String idUser = BBDD.getIdUserByST(secretToken);
		System.out.println(rsEvent.getString(1));
		%>
		
		<form action="http://localhost:8080/agora/updateEvent" method="post">
			<input type="hidden" name="secretToken" value="<%=secretToken%>"/> 
			
			<input type="hidden" name="idEvent" value="<%=idEvent%>"/> 
			
			<label>
				Nombre del evento: <input type="text" name="name" required placeholder="Plan de bolera" value="<%=rsEvent.getString("nameEvent")%>"/>
			</label>
		
			<%
			ResultSet rsLocation = null;
			try {
				rsLocation = BBDD.getLocations();//['alcobebdas,guadalajara']
			} catch (Exception e) {
			}
			%>

			<label>
				Elige tu localidad: <!-- Inicia un campo de selección (<select>) para elegir una localidad. El nombre del campo es "idLocation". -->
					<select name="idLocation">
						<%while (rsLocation.next()) {%>
							<!--  Para cada ubicación en el conjunto de resultados, crea una opción (<option>) en el menú desplegable. El valor de la opción es el "idLocation" y el texto visible es el "name" de la ubicación. -->
							<option value="<%=rsLocation.getString("idLocation")%>"
								<%
								String attributeSelected = "";
								if (rsEvent.getString("nameLocation").equalsIgnoreCase(rsLocation.getString("name"))) {
									attributeSelected = "selected";
								}
								%>
								<%=attributeSelected%>>
								<%=rsLocation.getString("name")%>
							</option>
						<%}%>
					</select>
			</label> 
			
			<label> 
				Fecha del evento: 
				<input type="datetime-local"name="dateTime" required value="<%=rsEvent.getString("dateTime")%>" />
			</label>
			
			 <label> 
			 	Descripción del evento: 
		 			<textarea name="description"><%=rsEvent.getString("description")%></textarea>
	 		</label>
			<input type="submit" name="Enviar" />
		</form>
	</body>
</html>