<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Carrito de Compras</title>
<link rel="stylesheet" href="../css/styles.css" />
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
              <span class="badge">${productosEnCarrito.size()}</span>
            </a>
          </li>
          <li><a href="loginController?action=logout">Cerrar sesión</a></li>
        </ul>
      </div>
    </nav>

    <!-- Main Content -->
    <main>
      <!-- Page Header -->
      <header class="page-header">
        <div class="container">
          <h1>Carrito de compras</h1>
          <p>Revisa tus artículos antes de finalizar la compra</p>
        </div>
      </header>

      <!-- Cart Content -->
      <section class="container">
        <c:choose>
          <c:when test="${empty productosEnCarrito}">
            <div style="text-align: center; margin: 40px 0;">
                <p>El carrito está vacío.</p>
                <a href="ExplorarCatalogoController?ruta=verListaProductos" class="btn btn-primary">Ver Productos</a>
            </div>
          </c:when>
          <c:otherwise>
            <div class="cart-layout">
              <!-- Cart Items -->
              <div class="cart-items">
                <h2>Artículos en el carrito (${productosEnCarrito.size()})</h2>

                <c:set var="totalSubtotal" value="0" />
                <c:forEach var="item" items="${productosEnCarrito}">
                  <c:set var="totalSubtotal" value="${totalSubtotal + (item.producto.precio * item.cantidad)}" />
                  <!-- Cart Item -->
                  <article class="cart-item">
                    <img src="../img/${item.producto.imagen}" class="cart-item-image" alt="${item.producto.nombre}" />
                    <div class="cart-item-details">
                      <h3 class="cart-item-title">${item.producto.nombre}</h3>
                      <p class="cart-item-price">$<fmt:formatNumber value="${item.producto.precio}" pattern="#0.00" /></p>
                      <div>
                        <form action="CarritoController" method="get" id="form-qty-${item.producto.idProducto}">
                          <input type="hidden" name="ruta" value="cambiarCantidad" />
                          <input type="hidden" name="productoId" value="${item.producto.idProducto}" />
                          <label for="qty-${item.producto.idProducto}">Cantidad:</label>
                          <input
                            type="number"
                            name="cantidad"
                            id="qty-${item.producto.idProducto}"
                            class="form-input cart-item-quantity"
                            value="${item.cantidad}"
                            min="1"
                            max="50"
                            onchange="document.getElementById('form-qty-${item.producto.idProducto}').submit()"
                          />
                        </form>
                      </div>
                    </div>
                    <div class="cart-item-actions">
                      <div class="cart-item-total">$<fmt:formatNumber value="${item.producto.precio * item.cantidad}" pattern="#0.00" /></div>
                      <a href="CarritoController?ruta=eliminarProducto&productoId=${item.producto.idProducto}" class="cart-item-remove">Eliminar</a>
                    </div>
                  </article>
                </c:forEach>
              </div>

              <!-- Cart Summary -->
              <aside class="cart-summary">
                <h2>Resumen del Pedido</h2>

                <div class="summary-row">
                  <span>Subtotal:</span>
                  <span>$<fmt:formatNumber value="${totalSubtotal}" pattern="#0.00" /></span>
                </div>

                <div class="summary-row">
                  <span>Envío:</span>
                  <span>$15.00</span>
                </div>

                <c:set var="tax" value="${totalSubtotal * 0.08}" />
                <div class="summary-row">
                  <span>Impuesto (8%):</span>
                  <span>$<fmt:formatNumber value="${tax}" pattern="#0.00" /></span>
                </div>

                <div class="summary-row total">
                  <span>Total:</span>
                  <span>$<fmt:formatNumber value="${totalSubtotal + 15 + tax}" pattern="#0.00" /></span>
                </div>

                <!-- Cart Actions -->
                <div class="cart-actions">
                  <a href="CarritoController?ruta=finalizarCompra" class="btn btn-primary btn-block">Proceder al Pago</a>
                  <a href="ExplorarCatalogoController?ruta=verListaProductos" class="btn btn-outline btn-block">Continuar Comprando</a>
                </div>
              </aside>
            </div>
          </c:otherwise>
        </c:choose>
      </section>
    </main>

    <!-- Footer
    <footer>
      <div class="container">
        <p>&copy; 2026. All rights reserved.</p>
      </div>
    </footer>
    -->
</body>
</html>