<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Actualizar Producto</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], input[type="number"], textarea {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .checkbox-group label {
            display: inline;
            font-weight: normal;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #45a049;
        }
        h1 {
            color: #333;
        }
    </style>
</head>
<body>
    <h1>Actualizar Producto</h1>
    
    <form action="GPC" method="post">
        <input type="hidden" name="accion" value="guardar"/>
        <input type="hidden" name="idProducto" value="${producto.idProducto}"/>
        
        <div class="form-group">
            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre" value="${producto.nombre}" required/>
        </div>
        
        <div class="form-group">
            <label for="imagen">Imagen (URL):</label>
            <input type="text" id="imagen" name="imagen" value="${producto.imagen}"/>
        </div>
        
        <div class="form-group">
            <label for="descripcion">Descripción:</label>
            <textarea id="descripcion" name="descripcion" rows="4">${producto.descripcion}</textarea>
        </div>
        
        <div class="form-group">
            <label for="precio">Precio:</label>
            <input type="number" id="precio" name="precio" step="0.01" value="${producto.precio}" required/>
        </div>
        
        <div class="form-group">
            <div class="checkbox-group">
                <input type="checkbox" id="condicion" name="condicion" value="true" 
                    <c:if test="${producto.condicion}">checked</c:if>/>
                <label for="condicion">Condición (Nuevo)</label>
            </div>
        </div>
        
        <div class="form-group">
            <div class="checkbox-group">
                <input type="checkbox" id="disponibilidad" name="disponibilidad" value="true"
                    <c:if test="${producto.disponibilidad}">checked</c:if>/>
                <label for="disponibilidad">Disponible</label>
            </div>
        </div>
        
        <button type="submit">Guardar</button>
        <a href="GPC?accion=listar"><button type="button">Cancelar</button></a>
    </form>
</body>
</html>
