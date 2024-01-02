<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="agora.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Events list</title>
	</head>
	
	<body>

		<h1>ESTOY EN EVENTOS</h1>
		<%
		//La query de pedir todos los eventos se guarda en un ResulSet rs
		ResultSet rs = null;
		try {			
			rs = BBDD.getEvents();
		} catch (Exception e) {
			e.printStackTrace();			
		}

		String secretToken = request.getParameter("st");
		String idUser = BBDD.getIdUserByST(secretToken);
		%>

		<table cellpadding="15" border="1" style="background-color: #ffffcc;">
			<thead>
				<th>Evento</th>
				<th>Localidad</th> 
				<th>Fecha</th>
				<th>Descripción</th>
				<th>Asistentes</th>
				<th>Unirse</th>
				<th>Editar</th>
				<th>Eliminar</th>
			</thead>
		<!-- Ejecuta el bucle hasta que no haya nada en rs.next(), donde se han guardado todos los eventos y lee hasta donde haya un espacio -->
			<%
			while (rs.next()) {
				String idEvent = rs.getString("idEvent");
			%>
				<tr>
					<!--Usamos el método getString("nombre_parametro_tabla") para poner los valores de la bbdd tabla eventos que necesitemos-->
					<td><%=rs.getString("nameEvent")%></td>
					<td><%=rs.getString("nameLocation")%></td>
					<td><%=rs.getString("dateTime")%></td>
					<td><%=rs.getString("description")%></td>
					<td><%=BBDD.getPaticipantsByEvent(idEvent)%></td>
					<td>
						<%if (BBDD.isUserInEvent(idEvent, idUser) == false) {%> 
							<a href="http://localhost:8080/agora/addParticipant?st=<%=secretToken%>&idEvent=<%=idEvent%>">
								Unirme
							</a>
						<%}%>
					</td>
					<td>
						<%if (BBDD.isUserCreator(idEvent, idUser)) {%> 
							<a href="http://localhost:8080/agora/updateEvent.jsp?st=<%=secretToken%>&idEvent=<%=idEvent%>">
								Editar
							</a>
						<%} else{%> 
							<p>Opción no disponible</p>
						<%}%>				
					</td>
					<td>
						<%if (BBDD.isUserCreator(idEvent, idUser)) {%> 
							<a href="http://localhost:8080/agora/deleteEvent?st=<%=secretToken%>&idEvent=<%=idEvent%>">
								Eliminar
							</a>
						<%} else {%> 
							<p>Opción no disponible</p> 
						<%}%>				
					</td>
				</tr>
			<%}%>
		</table>

	<!-- request de la pagina en la que estoy (es como la url) -->
		<a  href="http://localhost:8080/agora/newEvent.jsp?st=<%=secretToken%>">
			Crear evento
		</a>
	</body>
	
</html>