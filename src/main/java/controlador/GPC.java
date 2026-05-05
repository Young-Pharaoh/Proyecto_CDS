package controlador;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.dao.GestorProductoDAO;
import modelo.dao.ProductoDAO;
import modelo.entidad.Producto;

@WebServlet("/GPC")
public class GPC extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private GestorProductoDAO productoDAO;
	

	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
		 this.productoDAO = GestorProductoDAO.getGestorProducto();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		this.router(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		this.router(req, resp);
	}
	
	private void router(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("accion");
		
		if (action == null) {
			this.listar(req, resp);
		} else {
			switch (action) {
			
			case "listar":
				this.listar(req, resp);
				break;
			case "guardar":
				this.guardar(req, resp);
				break;
			case "eliminar":
				this.eliminar(req, resp);
				break;
			case "crear":
				this.crear(req, resp);
				break;
			case "insertar":
				this.insertar(req, resp);
				break;
			case "actualizar":
				this.actualizar(req, resp);
				break;
			default:
				this.listar(req, resp);
				break;
			}
		}
	}
	
	
	private void actualizar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		Producto producto = GestorProductoDAO.getGestorProducto().reedProduct(Integer.parseInt(req.getParameter("id")));
		req.setAttribute("producto", producto);
		req.getRequestDispatcher("jsp/ActualizarProducto.jsp").forward(req, resp);
	}

	private void listar(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		// 1. obtener parametros
		// 2. hablar con el modelo
		List<Producto> productos = this.productoDAO.obtenerTodos();
	
		// 3. llamar a la vista
		req.setAttribute("productos", productos);
		req.getRequestDispatcher("jsp/ListarProductos.jsp").forward(req, resp);
	}
	
	private void guardar(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException {
	    
	    int id = Integer.parseInt(req.getParameter("idProducto"));
	    String nombre = req.getParameter("nombre");
	    String imagen = req.getParameter("imagen");
	    String descripcion = req.getParameter("descripcion");
	    float precio = Float.parseFloat(req.getParameter("precio"));
	    boolean condicion = req.getParameter("condicion") != null;
	    boolean disponibilidad = req.getParameter("disponibilidad") != null;
	    
	    Producto producto = new Producto(imagen, descripcion, precio, condicion, disponibilidad, id, nombre);
	    this.productoDAO.updateProduct(producto);
	    
	    resp.sendRedirect("GPC?accion=listar");
	}

	
	private void eliminar(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		int idProducot = Integer.parseInt(req.getParameter("id"));
		System.out.println("Eliminar producto con id: " + idProducot);
		
		this.productoDAO.deleteProduct(idProducot);
		System.out.println("Producto eliminado");
		resp.sendRedirect("GPC?action=listar");
		
	}
	
	private void crear(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("jsp/CrearProducto.jsp").forward(req, resp);
		
	}
	
	private void insertar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String nombre = req.getParameter("nombre");
		String imagen = req.getParameter("imagen");
		String descripcion = req.getParameter("descripcion");
		float precio = Float.parseFloat(req.getParameter("precio"));
		boolean condicion = req.getParameter("condicion") != null;
		boolean disponibilidad = req.getParameter("disponibilidad") != null;
		
		Producto producto = new Producto();
		producto.setNombre(nombre);
		producto.setImagen(imagen);
		producto.setDescripcion(descripcion);
		producto.setPrecio(precio);
		producto.setCondicion(condicion);
		producto.setDisponibilidad(disponibilidad);
		
		GestorProductoDAO.getGestorProducto().createProduct(producto);
		
		resp.sendRedirect("GPC?accion=listar");
	}
}
