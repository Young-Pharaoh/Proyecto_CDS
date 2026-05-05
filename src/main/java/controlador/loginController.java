package controlador;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.dao.UsuarioDAO;
import modelo.entidad.Usuario;

@WebServlet("/loginController")
public class loginController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.router(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.router(req, resp);
	}
	
	private void router(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String ruta = req.getParameter("accion") == null? "solicitar" : req.getParameter("accion");
		System.out.println("ingreso a router");
		
		switch(ruta) {
		case "solicitar":
			this.solicitar(req, resp);
			break;
		case "iniciar":
			this.iniciar(req, resp);
			break;
		}
	}

	private void solicitar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("ingreso a solicitar");
		req.getRequestDispatcher("jsp/loginVista.jsp").forward(req, resp);		
	}

	private void iniciar(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException {

	    Usuario usuario = UsuarioDAO.getUsuarioDAO()
	            .getUsuarioPorCorreo(req.getParameter("correo"));

	    if (usuario != null && usuario.getClave().equals(req.getParameter("clave"))) {

	        if (usuario.isAdmin()) {
	            req.getRequestDispatcher("/GPC?accion=listar")
	                    .forward(req, resp);
	        } else {
	            req.getRequestDispatcher("/ExplorarCatalogoController?ruta=verListaProductos")
	                    .forward(req, resp);
	        }

	    } else {
	        // credentials incorrect
	    	req.setAttribute("error", "Credenciales incorrectas");
	        this.solicitar(req, resp);
	    }
	}
}
