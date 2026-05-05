package modelo.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import modelo.conexion.BddConnection;
import modelo.entidad.Producto;

public class ProductoDAO {
	
	private static List<Producto> productos;
	
	public static Producto obtenerDetalles(int id) {
		List<Producto> productos = obtenerProductos();

		for (Producto p : productos) {
			if (p.getIdProducto() == id) {
				return p;
			}
		}
		return null;
	}

	public static List<Producto> obtenerProductos() {
		
		String _SQL_GET_ALL_ = "SELECT * FROM PRODUCTO";
		try {
			PreparedStatement pstmt = BddConnection.getConexion().prepareStatement(_SQL_GET_ALL_);
			ResultSet rs = pstmt.executeQuery();
			
			List<Producto> productos = new ArrayList<>();
			
			while (rs.next()) {
			    productos.add(new Producto(
			        rs.getString("imagen"),                       // 1. imagen (varchar)
			        rs.getString("descripcion"),                  // 2. descripcion (varchar)
			        rs.getFloat("precio"),                        // 3. precio (float)
			        rs.getBoolean("condicion"), // 4. Convert tinyint back to String
			        rs.getBoolean("disponibilidad"),              // 5. disponibilidad (tinyint/boolean)
			        rs.getInt("idProducto"),                      // 6. idProducto (int)
			        rs.getString("nombre")                        // 7. nombre (varchar)
			    ));
			}
			BddConnection.cerrar(rs);
			BddConnection.cerrar(pstmt);
			BddConnection.cerrar();
			for(Producto p: productos) {
				System.out.println(p.toString());
			}
			return productos;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
	}

	public static boolean verificarDisponibilidad(Producto producto) {

		List<Producto> productos = obtenerProductos();

		if (producto == null) {
			return false;
		}

		for (Producto p : productos) {
			if (p.getIdProducto() == producto.getIdProducto()) {
				return p.isDisponibilidad();
			}
		}

		return false; // not found
	}

	public static boolean actualizarInventario(Producto producto) {
		List<Producto> productos = obtenerProductos();

		if (producto == null) {
			return false;
		}

		for (Producto p : productos) {
			if (p.getIdProducto() == producto.getIdProducto()) {
				p.setDisponibilidad(false);
				return true;
			}
		}

		return false; // not found
	}

	public static Producto buscar(String nombre) {
		List<Producto> productos = obtenerProductos();

		if (nombre == null) {
			return null;
		}

		for (Producto p : productos) {
			if (p.getNombre().equalsIgnoreCase(nombre)) {
				return p;
			}
		}

		return null; // not found
	}
}
