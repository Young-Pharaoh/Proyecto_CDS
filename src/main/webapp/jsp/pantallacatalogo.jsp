<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Productos - Static Web Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
    <style>
        .search-form {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color:  #f5f5f5;
            color: #333;
            padding: 20px;
        }

        div {
            max-width: 1200px;
        }

        form {
            background-color: white;
            padding:  20px;
            border-radius:  8px;
            box-shadow:  0 2px 4px rgba(0, 0, 0, 0.1);
        }

        fieldset {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
        }

        legend {
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
            padding: 0 10px;
        }

        input[type="text"] {
            padding: 10px;
            border: 1px solid #bbb;
            border-radius: 4px;
            font-size: 14px;
            width: 300px;
            margin-right: 10px;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
        }

        input[type="submit"] {
            padding: 10px 30px;
            background-color:  #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight:  bold;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }

        input[type="submit"]:active {
            transform: scale(0.98);
        }

        table {
            width:  100%;
            max-width: 1200px;
            margin: 0 auto;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        thead {
            background-color: #2c3e50;
            color: white;
        }

        thead th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
        }

        tbody tr {
            border-bottom:  1px solid #ecf0f1;
            transition: background-color 0.3s;
        }

        tbody tr:hover {
            background-color: #f8f9fa;
        }

        tbody td {
            padding: 15px;
            vertical-align: middle;
        }

        tbody img {
            max-width: 100px;
            max-height:  100px;
            object-fit: cover;
            border-radius: 4px;
            transition: transform 0.3s;
        }

        tbody img:hover {
            transform: scale(1.05);
        }

        a {
            color: #3498db;
            text-decoration:  none;
            font-weight:  500;
            transition: color 0.3s;
        }

        a:hover {
            color: #2980b9;
            text-decoration: underline;
        }

        .actions-bar {
            max-width: 1200px;
            margin: 0 auto 20px;
            display: flex;
            justify-content: flex-end;
            gap: 15px;
        }

        .btn-cart,
        .btn-logout {
            display: inline-block;
            padding: 10px 20px;
            border-radius: 5px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-cart {
            background-color: #3498db;
            color: white;
        }

        .btn-cart:hover {
            background-color: #2980b9;
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
        }

        .btn-logout {
            background-color: #e74c3c;
            color: white;
        }

        .btn-logout:hover {
            background-color: #c0392b;
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
        }

        /* Responsive design */
        @media (max-width: 768px) {
            input[type="text"] {
                width: 100%;
                margin-right: 0;
                margin-bottom: 10px;
            }

            table {
                font-size: 12px;
            }

            thead th,
            tbody td {
                padding: 10px;
            }

            tbody img {
                max-width: 80px;
                max-height: 80px;
            }
            input{
            	margin: 20px;
            }
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
      <!-- Page Header -->
      <header class="page-header">
        <div class="container">
          <h1>Nuestros Productos</h1>
          <p>Descubre nuestra colección seleccionada de artículos premium</p>
        </div>
      </header>

      <!-- Products Section -->
      <section class="container">
        <form class="search-form" method="POST" action="ExplorarCatalogoController?ruta=buscarProducto">
            <input type="text" name="productoBuscado" class="form-input" placeholder="Buscar producto...">
            <button type="submit" class="btn btn-primary">Buscar</button>
        </form>

        <!-- Products Grid -->
        <div class="products-grid">
          <c:forEach items="${productos}" var="producto">
              <!-- Product Card -->
              <article class="card product-card">
                <img src="${pageContext.request.contextPath}/img/${producto.imagen}" class="product-card-image" alt="${producto.nombre}" />
                <div class="product-card-body">
                  <h2 class="product-card-title">${producto.nombre}</h2>
                  <p class="product-card-description">${producto.descripcion}</p>
                  <p class="product-card-description">Disponibilidad: ${producto.disponibilidad}</p>
                  <div class="product-card-footer">
                    <span class="product-price">$${producto.precio}</span>
                    <a href="ProductoController?id=${producto.idProducto}" class="btn btn-primary">Ver detalles</a>
                  </div>
                </div>
              </article>
          </c:forEach>
        </div>
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
