package modelo.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import modelo.entidad.Producto;

public class ProductoDAO {
	
	private static ProductoDAO INSTANCE;

	EntityManager em;

	private ProductoDAO() {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("persistencia");
		this.em = emf.createEntityManager();
	}

	public static ProductoDAO getProductoDAO() {
		if(INSTANCE == null)
			INSTANCE = new ProductoDAO();
		return INSTANCE;
	}

	public Producto obtenerDetalles(int id) {
		return this.em.find(Producto.class, id);
	}

	public List<Producto> obtenerProductos() {
		return this.em.createQuery("SELECT p FROM Producto p", Producto.class).getResultList();
	}

	public boolean verificarDisponibilidad(Producto producto) {
		if (producto == null) return false;
		Producto p = this.em.find(Producto.class, producto.getIdProducto());
		if (p != null) {
			return p.isDisponibilidad();
		}
		return false;
	}

	public boolean actualizarInventario(Producto producto) {
		if (producto == null) return false;
		this.em.getTransaction().begin();
		try {
			Producto p = this.em.find(Producto.class, producto.getIdProducto());
			if (p != null) {
				p.setDisponibilidad(false);
				this.em.merge(p);
				this.em.getTransaction().commit();
				return true;
			}
			this.em.getTransaction().rollback();
			return false;
		} catch (Exception e) {
			if(this.em.getTransaction().isActive())
				this.em.getTransaction().rollback();
			return false;
		}
	}

	public Producto buscar(String nombre) {
		if (nombre == null) return null;
		try {
			return this.em.createQuery("SELECT p FROM Producto p WHERE p.nombre = :nombre", Producto.class)
				.setParameter("nombre", nombre)
				.getSingleResult();
		} catch (Exception e) {
			return null; // not found
		}
	}
}
