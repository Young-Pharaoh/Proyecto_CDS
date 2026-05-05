package modelo.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import modelo.entidad.Pedido;
import modelo.entidad.Usuario;

public class PedidoDAO {

    private static PedidoDAO INSTANCE;

    EntityManager em;

    private PedidoDAO() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("persistencia");
        this.em = emf.createEntityManager();
    }

    public static PedidoDAO getPedidoDAO() {
        if (INSTANCE == null)
            INSTANCE = new PedidoDAO();
        return INSTANCE;
    }

    public boolean crearPedido(Pedido pedido) {
        this.em.getTransaction().begin();
        try {
            this.em.persist(pedido);
            this.em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (this.em.getTransaction().isActive())
                this.em.getTransaction().rollback();
            return false;
        }
    }

    public Pedido leerPedido(Long id) {
        return this.em.find(Pedido.class, id);
    }

    public List<Pedido> leerPedidos() {
        return this.em.createQuery("FROM Pedido", Pedido.class).getResultList();
    }

    public List<Pedido> leerPedidosPorCliente(Usuario cliente) {
        return this.em.createQuery("FROM Pedido p WHERE p.cliente = :cliente", Pedido.class)
                .setParameter("cliente", cliente)
                .getResultList();
    }

    public List<Pedido> leerPedidosPorClienteId(int clienteId) {
        return this.em.createQuery("FROM Pedido p WHERE p.cliente.idUsuario = :clienteId", Pedido.class)
                .setParameter("clienteId", clienteId)
                .getResultList();
    }

    public boolean actualizarPedido(Pedido pedido) {
        this.em.getTransaction().begin();
        try {
            this.em.merge(pedido);
            this.em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (this.em.getTransaction().isActive())
                this.em.getTransaction().rollback();
            return false;
        }
    }

    public boolean eliminarPedido(Pedido pedido) {
        this.em.getTransaction().begin();
        try {
            Pedido managedPedido = this.em.contains(pedido) ? pedido : this.em.merge(pedido);
            this.em.remove(managedPedido);
            this.em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (this.em.getTransaction().isActive())
                this.em.getTransaction().rollback();
            return false;
        }
    }

    public boolean eliminarPedidoPorId(Long id) {
        Pedido pedido = leerPedido(id);
        if (pedido != null) {
            return eliminarPedido(pedido);
        }
        return false;
    }
}
