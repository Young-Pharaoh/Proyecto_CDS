package controlador;


import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.dao.GestorProductoDAO;
import modelo.dao.ProductoDAO;
import modelo.entidad.Producto;
import recursos.Carrito;
import recursos.ItemCarrito;

@WebServlet("/CarritoController")
public class CarritoController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		this.ruteador(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		this.ruteador(req, resp);
	}
	
	private void ruteador(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String ruta = req.getParameter("ruta") == null ? "verCarrito" : req.getParameter("ruta");

		switch (ruta) {
		case "verCarrito":
			this.verCarrito(req, resp);
			break;
		case "agregarAlCarrito":
			this.agregarAlCarrito(req, resp);
			break;
		case "notificacion":
			this.notificacion(req, resp);
			break;
		case "cambiarCantidad":
			this.cambiarCantidad(req, resp);
			break;
		case "eliminarProducto":
			this.eliminarProducto(req, resp);
			break;
		}
		
	}
	
	private void verCarrito(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		System.out.println("ingreso a ver carrito");

		// 1. obtener parametros
		// 2. hablar con el modelo
		List<ItemCarrito> productosEnCarrito = Carrito.getInstance().getItems();
		req.setAttribute("productosEnCarrito", productosEnCarrito);
		// Aqui se deberia obtener los productos en el carrito desde la sesion o base de datos
		// 3. llamar a la vista
		req.getRequestDispatcher("jsp/CarritoVista.jsp").forward(req, resp);
	}
	
	private void agregarAlCarrito(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		System.out.println("ingreso a agregar al carrito");

		// 1. obtener parametros
		int productoId = Integer.parseInt(req.getParameter("productoId"));
		int cantidad = Integer.parseInt(req.getParameter("cantidad"));

		// 2. hablar con el modelo
		GestorProductoDAO gestor = GestorProductoDAO.getGestorProducto();
		Producto producto = gestor.reedProduct(productoId);
		Carrito.getInstance().agregarProducto(producto, cantidad);

		// 3. llamar a la vista
		resp.sendRedirect("CarritoController?ruta=notificacion&producto="+producto.getNombre());
	}
	
	private void notificacion(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		System.out.println("ingreso a notificacion");

		// 1. obtener parametros
		String productoNombre = req.getParameter("producto");
		// 2. hablar con el modelo
		// 3. llamar a la vista
		req.setAttribute("productoNombre", productoNombre);
		req.getRequestDispatcher("jsp/NotificacionVista.jsp").forward(req, resp);
		
	}
	
	private void cambiarCantidad(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		System.out.println("ingreso a cambiar cantidad");

		// 1. obtener parametros
		int productoId = Integer.parseInt(req.getParameter("productoId"));
		int cantidad = Integer.parseInt(req.getParameter("cantidad"));

		// 2. hablar con el modelo
		Carrito.getInstance().actualizarCantidad((long)productoId, cantidad);

		// 3. llamar a la vista
		System.out.println(Carrito.getInstance().getItems().getFirst().getCantidad());
		resp.sendRedirect("CarritoController?ruta=verCarrito");
	}
	
	private void eliminarProducto(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		System.out.println("ingreso a eliminar producto");

		// 1. obtener parametros
		int productoId = Integer.parseInt(req.getParameter("productoId"));

		// 2. hablar con el modelo
		Carrito.getInstance().eliminarProducto((long)productoId);

		// 3. llamar a la vista
		resp.sendRedirect("CarritoController?ruta=verCarrito");
	}

}
