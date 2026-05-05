<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Gestión de Productos</title>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: black;
        min-height: 100vh;
        padding: 40px 20px;
    }
    
    .container {
        max-width: 1200px;
        margin: 0 auto;
    }
    
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
    }
    
    h1 {
        color: white;
        font-size: 2rem;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
    }
    
    .btn {
        display: inline-block;
        padding: 12px 24px;
        border-radius: 8px;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
        cursor: pointer;
        border: none;
        font-size: 14px;
    }
    
    .btn-primary {
        background:  #11998e;
        color: white;
        box-shadow: 0 4px 15px rgba(17, 153, 142, 0.4);
    }
    
    .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(17, 153, 142, 0.6);
    }
    
    .header-actions {
        display: flex;
        gap: 15px;
        align-items: center;
    }
    
    .btn-logout {
        background: #e74c3c;
        color: white;
        box-shadow: 0 4px 15px rgba(231, 76, 60, 0.4);
    }
    
    .btn-logout:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(231, 76, 60, 0.6);
    }
    
    .btn-edit {
        background:  #f5576c
        color: white;
        padding: 8px 16px;
        font-size: 12px;
    }
    
    .btn-edit:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(245, 87, 108, 0.4);
    }
    
    .btn-delete {
        background:  #ff416c;
        color: white;
        padding: 8px 16px;
        font-size: 12px;
    }
    
    .btn-delete:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(255, 75, 43, 0.4);
    }
    
    .table-container {
        background: white;
        border-radius: 16px;
        box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        overflow: hidden;
    }
    
    table {
        width: 100%;
        border-collapse: collapse;
    }
    
    thead {
        background:  #2c3e50;
    }
    
    th {
        color: white;
        padding: 18px 15px;
        text-align: left;
        font-weight: 600;
        text-transform: uppercase;
        font-size: 13px;
        letter-spacing: 1px;
    }
    
    tbody tr {
        border-bottom: 1px solid #eee;
        transition: all 0.3s ease;
    }
    
    tbody tr:hover {
        background-color: #f8f9ff;
        transform: scale(1.01);
    }
    
    tbody tr:last-child {
        border-bottom: none;
    }
    
    td {
        padding: 15px;
        vertical-align: middle;
        color: #333;
    }
    
    .product-image {
        width: 70px;
        height: 70px;
        object-fit: cover;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }
    
    .product-name {
        font-weight: 600;
        color: #2c3e50;
        font-size: 15px;
    }
    
    .product-description {
        color: #7f8c8d;
        font-size: 13px;
        max-width: 250px;
        line-height: 1.4;
    }
    
    .product-price {
        font-weight: 700;
        color: #27ae60;
        font-size: 16px;
    }
    
    .actions {
        display: flex;
        gap: 8px;
    }
    
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        color: #7f8c8d;
    }
    
    .empty-state p {
        font-size: 18px;
        margin-bottom: 20px;
    }
</style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📦 Gestión de Productos</h1>
            <div class="header-actions">
                <a href="GPC?accion=crear" class="btn btn-primary">+ Crear Producto</a>
                <a href="loginController?accion=solicitar" class="btn btn-logout">🚪 Cerrar Sesión</a>
            </div>
        </div>
        
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Imagen</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Precio</th>
                        <th>Acciones</th>
                    </tr>
                </thead>

                <tbody>
                    <c:choose>
                        <c:when test="${empty productos}">
                            <tr>
                                <td colspan="5">
                                    <div class="empty-state">
                                        <p>No hay productos registrados</p>
                                        <a href="GPC?accion=crear" class="btn btn-primary">Crear primer producto</a>
                                    </div>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${productos}" var="producto">
                                <tr>
                                    <td><img src="img/${producto.imagen}" alt="${producto.nombre}" class="product-image"></td>
                                    <td class="product-name">${producto.nombre}</td>
                                    <td class="product-description">${producto.descripcion}</td>
                                    <td class="product-price">$${producto.precio}</td>
                                    <td>
                                        <div class="actions">
                                            <a href="GPC?accion=actualizar&id=${producto.idProducto}" class="btn btn-edit">✏️ Editar</a>
                                            <a href="GPC?accion=eliminar&id=${producto.idProducto}" class="btn btn-delete" onclick="return confirm('¿Estás seguro de eliminar este producto?')">🗑️ Eliminar</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>