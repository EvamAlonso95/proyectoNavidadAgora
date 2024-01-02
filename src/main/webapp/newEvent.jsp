<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="agora.*" %>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>CreateNewEvent</title>
	</head>
	<body>
		<form action="http://localhost:8080/agora/registerEvent" method="post">
			<input type="hidden" name="secretToken" value="<%=request.getParameter("st")%>"/>
			<label>
				Nombre del evento:
				<input type="text" name="nameEvent" required placeholder="Plan de bolera"/>
			</label>
			<%
				ResultSet rs = null;
				try{
					rs = BBDD.getLocations();
				}catch(Exception e){} 
			%>	
		
			<label >
				Elige tu localidad: <!-- Inicia un campo de selección (<select>) para elegir una localidad. El nombre del campo es "idLocation". -->
				<select name="idLocation">
					<% while(rs.next()){ %>
					<!--  Para cada ubicación en el conjunto de resultados, crea una opción (<option>) en el menú desplegable. 
					El valor de la opción es el "idLocation" y el texto visible es el "name" de la ubicación. -->
						<option value="<%=rs.getString("idLocation")%>">
							<%=rs.getString("name")%>
						</option>
					<%} %>
				</select>
			</label>			
			
			<label> 
				Fecha del evento:
				<input type="datetime-local" name="dateTime" required/>
			</label>
			
			<label>
				 Descripción del evento:
				<textarea  name="description"></textarea>
			</label>
			
			<input type="submit" name="Enviar"/>
		</form>

	</body>
</html>