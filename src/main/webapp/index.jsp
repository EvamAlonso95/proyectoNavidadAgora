<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="agora.*"%>
<!-- Establecemos el lenguaje de la página JAVA especificamos que la pág es HTML con codificación UFT-8-->
<!-- Esto define el tipo de documento (DOCTYPE) como HTML5-->

<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8">
		<title> Register and Login</title>
	</head>
	
	<body>
		<h3>Register</h3>
			
			<!-- Formulario que envía los datos al servidor. -->
			<!--El atributo action especifica la URL a dónde se envían y el método post es cómo se envían los datos-->
			
			<form action="http://localhost:8080/agora/registerNewUser" method="post">
			
				<!--  Etiqueta para asociar un texto con un campo de entrada al clickar -->
				<label>
					 Usuario: 
					<input type="text" name="username" required	placeholder="Usuario1" />
				</label> 
			
				<label> 
					Contraseña: 
					<input type="password" name="password" required />
				</label>
			 
				<label> 
					Edad: 
					<input type="text" name="age"required />
				</label>
			
				<%
				ResultSet rs = null;
				try {
					rs = BBDD.getLocations();
				} catch (Exception e) {
				}
				%>
			
				<label>
					Localidad: 
					<select name="idLocation">
			
						<%while (rs.next()) {%>
							<option value="<%=rs.getString("idLocation")%>">
								<%=rs.getString("name")%>
							</option>
						<%}%>
						
					</select>
				</label> 
				<input type="submit" name="Enviar" />
			</form>
		
		<h3>Log in</h3>		
	
			<form action="http://localhost:8080/agora/loginUser" method="post">
				
				<label> 
					Usuario: 
					<input type="text" name="username" required	placeholder="Usuario1" />
				</label> 
			
				<label>
					 Contraseña: 
					<input type="password" name="password"required />
				</label> 
			
				<input type="submit" name="Enviar" />
			</form>


	</body>
	
</html>