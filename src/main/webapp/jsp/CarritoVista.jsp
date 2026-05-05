<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Carrito de Compras</title>
<style>
  table { border-collapse: collapse; width: 100%; max-width: 900px; }
  th, td { border: 1px solid #ccc; padding: 8px; text-align: left; vertical-align: middle; }
  th { background: #f5f5f5; }
  .right { text-align: right; }
  .actions { font-size: 0.9em; }
  .actions a { margin-right: 8px; cursor: pointer; color: #0066cc; text-decoration: none; }
  .actions a:hover { text-decoration: underline; }

  /* Modal styles */
  .modal-overlay {
    display: none;
    position: fixed;
    z-index: 999;
    left: 0; top: 0; right: 0; bottom: 0;
    background: rgba(0,0,0,0.5);
    align-items: center;
    justify-content: center;
  }
  .modal {
    background: #fff;
    padding: 18px;
    border-radius: 6px;
    max-width: 420px;
    width: 90%;
    box-shadow: 0 2px 10px rgba(0,0,0,0.3);
  }
  .modal h3 { margin-top: 0; }
  .modal .row { margin: 10px 0; }
  .modal .links a { margin-right: 12px; color: #0066cc; text-decoration: none; }
  .modal .links a:hover { text-decoration: underline; }
  .close-btn { float: right; color: #999; cursor: pointer; }
</style>
</head>
<body>
<h1>Carrito de Compras</h1>

<c:choose>
  <c:when test="${empty productosEnCarrito}">
    <p>El carrito está vacío.</p>
  </c:when>
  <c:otherwise>
    <c:set var="total" value="0" scope="page" />
    <table>
      <thead>
        <tr>
          <th>Producto</th>
          <th class="right">Precio unitario</th>
          <th class="right">Cantidad</th>
          <th class="right">Subtotal</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="item" items="${productosEnCarrito}">
          <c:set var="subtotal" value="${item.producto.precio * item.cantidad}" />
          <tr>
            <td>
              ${item.producto.nombre}
              <div class="actions">
                <a href="#" onclick="openQtyModal(${item.producto.idProducto}, ${item.cantidad}); return false;">Cambiar cantidad</a>
                <a href="#" onclick="openDeleteModal(${item.producto.idProducto}); return false;">Eliminar</a>
              </div>
            </td>
            <td class="right">
              <fmt:formatNumber value="${item.producto.precio}" pattern="#0.00" />
            </td>
            <td class="right">${item.cantidad}</td>
            <td class="right">
              <fmt:formatNumber value="${subtotal}" pattern="#0.00" />
            </td>
          </tr>
          <c:set var="total" value="${total + subtotal}" />
        </c:forEach>
      </tbody>
      <tfoot>
        <tr>
          <th colspan="3" class="right">Total</th>
          <th class="right">
            <fmt:formatNumber value="${total}" pattern="#0.00" />
          </th>
        </tr>
      </tfoot>
    </table>

    <p style="margin-top:16px;">
      <a href="CarritoController?ruta=finalizarCompra">Finalizar compra</a>
      &nbsp;|&nbsp;
      <a href="ExplorarCatalogoController">Seguir comprando</a>
    </p>
  </c:otherwise>
</c:choose>

<div id="qtyModalOverlay" class="modal-overlay" onclick="if(event.target===this) closeQtyModal();">
  <div class="modal" role="dialog" aria-modal="true" aria-labelledby="qtyModalTitle">
    <span class="close-btn" onclick="closeQtyModal()">✖</span>
    <h3 id="qtyModalTitle">Cambiar cantidad</h3>
    <div class="row">
      <form id="qtyForm" action="CarritoController" method="get">
        <input type="hidden" name="ruta" value="cambiarCantidad" />
        <input type="hidden" name="productoId" id="qtyProductoId" value="" />
        <label for="qtyInput">Cantidad:</label>
        <input id="qtyInput" name="cantidad" type="number" min="1" value="1" style="width:80px; margin-left:8px;" />
        
        <div class="links" style="margin-top:12px;">
          <a href="#" onclick="if(validateQty()) document.getElementById('qtyForm').submit(); return false;">Guardar</a>
          <a href="#" onclick="closeQtyModal(); return false;">Cancelar</a>
        </div>
      </form>
    </div>
  </div>
</div>

<div id="delModalOverlay" class="modal-overlay" onclick="if(event.target===this) closeDelModal();">
  <div class="modal" role="dialog" aria-modal="true" aria-labelledby="delModalTitle">
    <span class="close-btn" onclick="closeDelModal()">✖</span>
    <h3 id="delModalTitle">Confirmar eliminación</h3>
    <div class="row">
      <p>¿Desea eliminar este producto del carrito?</p>
      <form id="delForm" action="CarritoController" method="get" style="display:inline;">
        <input type="hidden" name="ruta" value="eliminarProducto" />
        <input type="hidden" name="productoId" id="delProductoId" value="" />
        
        <div class="links">
          <a href="#" onclick="document.getElementById('delForm').submit(); return false;">Confirmar</a>
          <a href="#" onclick="closeDelModal(); return false;">Cancelar</a>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  function openQtyModal(productId, currentQty) {
    document.getElementById('qtyProductoId').value = productId;
    document.getElementById('qtyInput').value = currentQty > 0 ? currentQty : 1;
    document.getElementById('qtyModalOverlay').style.display = 'flex';
    document.getElementById('qtyInput').focus();
  }
  
  function closeQtyModal() {
    document.getElementById('qtyModalOverlay').style.display = 'none';
  }

  function validateQty() {
    var input = document.getElementById('qtyInput');
    var v = parseInt(input.value, 10);
    if (isNaN(v) || v < 1) {
      alert('Ingrese una cantidad válida (>= 1).');
      input.focus();
      return false;
    }
    return true;
  }

  function openDeleteModal(productId) {
    document.getElementById('delProductoId').value = productId;
    document.getElementById('delModalOverlay').style.display = 'flex';
  }
  
  function closeDelModal() {
    document.getElementById('delModalOverlay').style.display = 'none';
  }
</script>

</body>
</html>