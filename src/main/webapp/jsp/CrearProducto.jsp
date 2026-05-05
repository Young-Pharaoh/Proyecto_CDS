<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Crear Producto</title>
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
        padding: 40px 20px;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    
    .container {
        width: 100%;
        max-width: 600px;
    }
    
    .form-card {
        background: white;
        border-radius: 16px;
        box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        overflow: hidden;
    }
    
    .form-header {
        background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
        padding: 25px 30px;
        text-align: center;
    }
    
    .form-header h1 {
        color: white;
        font-size: 1.8rem;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
    }
    
    .form-body {
        padding: 30px;
    }
    
    .form-group {
        margin-bottom: 20px;
    }
    
    label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: #2c3e50;
        font-size: 14px;
    }
    
    input[type="text"],
    input[type="number"],
    textarea {
        width: 100%;
        padding: 12px 15px;
        border: 2px solid #e0e0e0;
        border-radius: 8px;
        font-size: 14px;
        transition: all 0.3s ease;
        font-family: inherit;
    }
    
    input[type="text"]:focus,
    input[type="number"]:focus,
    textarea:focus {
        outline: none;
        border-color: #667eea;
        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.2);
    }
    
    textarea {
        resize: vertical;
        min-height: 100px;
    }
    
    .checkbox-group {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 10px 0;
    }
    
    .checkbox-group input[type="checkbox"] {
        width: 20px;
        height: 20px;
        cursor: pointer;
        accent-color: #667eea;
    }
    
    .checkbox-group label {
        display: inline;
        margin-bottom: 0;
        cursor: pointer;
        font-weight: normal;
    }
    
    .form-actions {
        display: flex;
        gap: 15px;
        margin-top: 30px;
    }
    
    .btn {
        flex: 1;
        padding: 14px 24px;
        border-radius: 8px;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
        cursor: pointer;
        border: none;
        font-size: 15px;
        text-align: center;
    }
    
    .btn-primary {
        background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
        color: white;
        box-shadow: 0 4px 15px rgba(17, 153, 142, 0.4);
    }
    
    .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(17, 153, 142, 0.6);
    }
    
    .btn-secondary {
        background: linear-gradient(135deg, #bdc3c7 0%, #95a5a6 100%);
        color: white;
        box-shadow: 0 4px 15px rgba(149, 165, 166, 0.4);
    }
    
    .btn-secondary:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(149, 165, 166, 0.6);
    }
    
    .back-link {
        display: block;
        text-align: center;
        margin-top: 20px;
        color: white;
        text-decoration: none;
        font-weight: 500;
        transition: all 0.3s ease;
    }
    
    .back-link:hover {
        text-decoration: underline;
    }
    
    .input-hint {
        font-size: 12px;
        color: #7f8c8d;
        margin-top: 5px;
    }
</style>
</head>
<body>
    <div class="container">
        <div class="form-card">
            <div class="form-header">
                <h1>📦 Crear Nuevo Producto</h1>
            </div>
            
            <div class="form-body">
                <form action="GPC" method="post">
                    <input type="hidden" name="accion" value="insertar"/>
                    
                    <div class="form-group">
                        <label for="nombre">Nombre del Producto *</label>
                        <input type="text" id="nombre" name="nombre" required/>
                    </div>
                    
                    <div class="form-group">
                        <label for="imagen">Imagen</label>
                        <input type="text" id="imagen" name="imagen" />
                        <p class="input-hint">Nombre del archivo de imagen (debe estar en la carpeta img/)</p>
                    </div>
                    
                    <div class="form-group">
                        <label for="descripcion">Descripción</label>
                        <textarea id="descripcion" name="descripcion" placeholder="Describe las características del producto..."></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="precio">Precio *</label>
                        <input type="number" id="precio" name="precio" step="0.01" min="0" placeholder="0.00" required/>
                    </div>
                    
                    <div class="form-group">
                        <div class="checkbox-group">
                            <input type="checkbox" id="condicion" name="condicion" value="true"/>
                            <label for="condicion">Producto Nuevo</label>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="checkbox-group">
                            <input type="checkbox" id="disponibilidad" name="disponibilidad" value="true" checked/>
                            <label for="disponibilidad">Disponible</label>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <a href="GPC?accion=listar" class="btn btn-secondary">Cancelar</a>
                        <button type="submit" class="btn btn-primary">✅ Insertar</button>
                    </div>
                </form>
            </div>
        </div>
        
        <a href="GPC?accion=listar" class="back-link">← Volver a la lista de productos</a>
    </div>
</body>
</html>