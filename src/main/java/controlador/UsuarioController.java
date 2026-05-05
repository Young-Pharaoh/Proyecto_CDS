package controlador;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.dao.UsuarioDAO;
import modelo.entidad.Usuario;

@WebServlet("/usuarioController")
public class UsuarioController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UsuarioController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String accion = request.getParameter("accion");
		
		if (accion == null) {
			response.sendRedirect(request.getContextPath() + "/jsp/registroVista.jsp");
			return;
		}

		switch (accion) {
		case "crear":
			crearUsuario(request, response);
			break;
		default:
			response.sendRedirect(request.getContextPath() + "/jsp/loginVista.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	private void crearUsuario(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String nombre = request.getParameter("nombre");
		String apellido = request.getParameter("apellido");
		String correo = request.getParameter("correo");
		String clave = request.getParameter("clave");
		
		// Por defecto isAdmin puede ser falso
		Usuario nuevoUsuario = new Usuario(nombre, apellido, correo, clave, false);
		
		UsuarioDAO usuarioDAO = UsuarioDAO.getUsuarioDAO();
		
		// Verificar si el correo ya existe
		Usuario existente = usuarioDAO.getUsuarioPorCorreo(correo);
		if (existente != null) {
			request.setAttribute("error", "El correo ya está registrado.");
			request.getRequestDispatcher("/jsp/registroVista.jsp").forward(request, response);
			return;
		}
		
		boolean creado = usuarioDAO.crearUsuario(nuevoUsuario);
		
		if (creado) {
			request.setAttribute("mensaje", "Cuenta creada exitosamente. Puede iniciar sesión.");
			request.getRequestDispatcher("/jsp/loginVista.jsp").forward(request, response);
		} else {
			request.setAttribute("error", "Hubo un error al crear la cuenta. Intente nuevamente.");
			request.getRequestDispatcher("/jsp/registroVista.jsp").forward(request, response);
		}
	}

}
