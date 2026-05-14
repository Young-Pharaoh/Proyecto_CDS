<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Iniciar Sesión</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: white;
	min-height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
}

.login-container {
	background: white;
	padding: 40px;
	border-radius: 10px;
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
	width: 100%;
	max-width: 400px;
}

h2 {
	text-align: center;
	color: #333;
	margin-bottom: 30px;
}

.form-group {
	margin-bottom: 20px;
}

label {
	display: block;
	margin-bottom: 8px;
	color: #555;
	font-weight: 500;
}

input[type="email"], input[type="password"] {
	width: 100%;
	padding: 12px 15px;
	border: 1px solid #ddd;
	border-radius: 5px;
	font-size: 14px;
	transition: border-color 0.3s;
}

input[type="email"]:focus, input[type="password"]:focus {
	outline: none;
	border-color: #667eea;
}

.btn-login {
	width: 100%;
	padding: 12px;
	background: #667eea;
	border: none;
	border-radius: 5px;
	color: white;
	font-size: 16px;
	font-weight: 600;
	cursor: pointer;
	transition: opacity 0.3s;
}

.btn-login:hover {
	opacity: 0.9;
}

.error-message {
	color: #dc3545;
	text-align: center;
	margin-bottom: 15px;
}

.success-message {
	color: #28a745;
	text-align: center;
	margin-bottom: 15px;
}

.footer-link {
	text-align: center;
	margin-top: 20px;
}

.footer-link a {
	color: #667eea;
	text-decoration: none;
	font-size: 14px;
}

.footer-link a:hover {
	text-decoration: underline;
}
</style>
</head>
<body>
	<div class="login-container">
		<h2>Iniciar Sesión</h2>

		<c:if test="${not empty mensaje}">
			<p class="success-message">${mensaje}</p>
		</c:if>

		<form action="/loginController?accion=iniciar" method="post">
			<div class="form-group">
				<label for="correo">Correo</label> <input type="email" id="correo"
					name="correo" required placeholder="ejemplo@correo.com">
			</div>

			<div class="form-group">
				<label for="clave">Clave</label> <input type="password" id="clave"
					name="clave" required placeholder="Ingrese su clave">
				<c:if test="${not empty error}">
					<p class="error-message">${error}</p>
				</c:if>
			</div>

			<button type="submit" class="btn-login">Iniciar Sesión</button>
		</form>

		<div class="footer-link">
			<p>¿No tienes cuenta? <a href="jsp/registroVista.jsp">Regístrate aquí</a></p>
		</div>
	</div>
</body>
</html>