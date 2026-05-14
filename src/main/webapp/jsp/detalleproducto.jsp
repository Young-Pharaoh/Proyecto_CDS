<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${producto.nombre}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar" role="navigation">
      <div class="container">
        <a href="ExplorarCatalogoController?ruta=verListaProductos" class="navbar-brand">Casita musical TALF</a>
        <ul class="navbar-nav">
          <li><a href="ExplorarCatalogoController?ruta=verListaProductos">Productos</a></li>
          <li class="nav-cart">
            <a href="CarritoController?ruta=verCarrito">
              Carrito
            </a>
          </li>
          <li><a href="loginController?accion=solicitar">Cerrar sesión</a></li>
        </ul>
      </div>
    </nav>

    <!-- Main Content -->
    <main>
      <!-- Breadcrumb Navigation -->
      <div class="container">
        <nav>
          <ul class="breadcrumb">
            <li><a href="ExplorarCatalogoController?ruta=verListaProductos">Productos</a></li>
            <li aria-current="page">
              ${producto.nombre}
            </li>
          </ul>
        </nav>
      </div>

      <!-- Product Detail Section -->
      <section class="container">
        <article class="product-detail">
          <!-- Product Images -->
          <div class="product-images">
            <img
              src="${pageContext.request.contextPath}/img/${producto.imagen}"
              class="product-image-main"
              alt="${producto.nombre}"
            />
          </div>

          <!-- Product Information -->
          <div class="product-info">
            <h1>${producto.nombre}</h1>
            <p class="product-price">$${producto.precio}</p>

            <div class="product-description">
              <p>
                ${producto.descripcion}
              </p>
              <br>
              <p>
                <strong>Condición:</strong> <c:out value="${producto.condicion ? 'Nuevo' : 'Usado'}"/>
              </p>
              <p>
                <strong>Disponibilidad:</strong> ${producto.disponibilidad}
              </p>
            </div>

            <!-- Product Actions -->
            <form action="CarritoController?ruta=agregarAlCarrito" method="POST">
              <input type="hidden" name="productoId" value="${producto.idProducto}">
              <div class="product-actions">
                <div class="quantity-selector">
                  <label for="quantity">Cantidad:</label>
                  <input
                    type="number"
                    id="quantity"
                    name="cantidad"
                    class="form-input"
                    value="1"
                    min="1"
                    max="10"
                  />
                </div>
                <button type="submit" class="btn btn-primary">
                  Agregar al Carrito
                </button>
              </div>
            </form>
          </div>
        </article>
      </section>
    </main>

	<!-- Footer
    <footer>
      <div class="container">
        <p>&copy;  All rights reserved.</p>
      </div>
    </footer>
    -->
</body>
</html>