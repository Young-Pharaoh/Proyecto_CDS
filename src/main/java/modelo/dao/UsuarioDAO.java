package modelo.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import modelo.entidad.Usuario;

public class UsuarioDAO {
		
	private static UsuarioDAO INSTANCE;
	
	EntityManager em;
	
	private UsuarioDAO() {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("persistencia");
		this.em = emf.createEntityManager();
	}
	
	public static UsuarioDAO getUsuarioDAO() {
		if(INSTANCE == null)
			return new UsuarioDAO();
		return INSTANCE;
	}
	
	public boolean crearUsuario(Usuario u) {
		this.em.getTransaction().begin();
		try {
			this.em.persist(u);
			this.em.getTransaction().commit();
			return true;
		} catch (Exception e) {
			if(this.em.getTransaction().isActive())
				this.em.getTransaction().rollback();
			return false;
		}
	}
	
	public Usuario leerUsuario(int id) {
		return this.em.find(Usuario.class, id);
	}
	
	public Usuario getUsuarioPorCorreo(String correo) {
	    try {
			return this.em.createQuery("SELECT u FROM Usuario u WHERE u.correo = :correo", Usuario.class)
	                .setParameter("correo", correo)
	                .getSingleResult();
	    } catch (Exception e) {
	        return null;
	    }
	}
	
	public List<Usuario> leerUsuarios() {
		return this.em.createQuery("SELECT u FROM Usuario u", Usuario.class).getResultList();
	}
	
	
	public boolean actualizarUsuario(Usuario u) {
		this.em.getTransaction().begin();
		try {
			this.em.merge(u);
			this.em.getTransaction().commit();
			return true;
		} catch (Exception e) {
			if(em.getTransaction().isActive())
				em.getTransaction().rollback();
			return false;
		}
	}
	
	public boolean eliminarUsuario(Usuario u) {
		this.em.getTransaction().begin();
		try {
			this.em.remove(u);
			this.em.getTransaction().commit();
			return true;
		} catch (Exception e) {
			if(em.getTransaction().isActive())
				em.getTransaction().rollback();
			return false;
		}
	}
}