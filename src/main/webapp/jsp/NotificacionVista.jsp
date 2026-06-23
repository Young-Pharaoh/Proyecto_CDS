<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>    
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Producto agregado</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
<style>
  .notification-overlay {
    position: fixed;
    top: 0; left: 0; right: 0; bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
  }
  .notification-box {
    background: #fff;
    border-radius: 12px;
    padding: 2.5rem 3rem;
    text-align: center;
    box-shadow: 0 8px 30px rgba(0,0,0,0.2);
    max-width: 420px;
    width: 90%;
    animation: fadeIn 0.3s ease;
  }
  @keyframes fadeIn {
    from { opacity: 0; transform: scale(0.9); }
    to { opacity: 1; transform: scale(1); }
  }
  .notification-icon {
    font-size: 3rem;
    color: #28a745;
    margin-bottom: 1rem;
  }
  .notification-box h2 {
    margin: 0 0 0.5rem;
    color: #333;
  }
  .notification-box p {
    color: #555;
    margin: 0 0 1.5rem;
  }
  .notification-actions {
    display: flex;
    gap: 1rem;
    justify-content: center;
    flex-wrap: wrap;
  }
  .notification-actions a {
    text-decoration: none;
    padding: 0.6rem 1.5rem;
    border-radius: 6px;
    font-weight: bold;
    transition: background 0.2s;
  }
  .btn-continue {
    background: #007bff;
    color: #fff;
  }
  .btn-continue:hover {
    background: #0056b3;
  }
  .btn-cart {
    background: #28a745;
    color: #fff;
  }
  .btn-cart:hover {
    background: #1e7e34;
  }
</style>
</head>
<body>
  <!-- Navigation Bar -->
  <nav class="navbar" role="navigation">
    <div class="container">
      <a href="ExplorarCatalogoController?ruta=verListaProductos" class="navbar-brand">Casita musical TALF</a>
      <ul class="navbar-nav">
        <li><a href="ExplorarCatalogoController?ruta=verListaProductos">Productos</a></li>
        <li class="nav-cart">
          <a href="CarritoController?ruta=verCarrito">Carrito</a>
        </li>
        <li><a href="loginController?accion=solicitar">Cerrar sesión</a></li>
      </ul>
    </div>
  </nav>

  <div class="notification-overlay">
    <div class="notification-box">
      <div class="notification-icon">&#10004;</div>
      <h2>¡Producto agregado!</h2>
      <p><strong>${productoNombre}</strong> se ha agregado al carrito exitosamente.</p>
      <div class="notification-actions">
        <a href="ExplorarCatalogoController?ruta=verListaProductos" class="btn-continue">Seguir comprando</a>
        <a href="CarritoController?ruta=verCarrito" class="btn-cart">Ver carrito</a>
      </div>
    </div>
  </div>
</body>
</html>
