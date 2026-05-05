package modelo.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import modelo.entidad.DetallePedido;
import modelo.entidad.Pedido;
import modelo.entidad.Producto;

public class DetallePedidoDAO {

    private static DetallePedidoDAO INSTANCE;

    EntityManager em;

    private DetallePedidoDAO() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("persistencia");
        this.em = emf.createEntityManager();
    }

    public static DetallePedidoDAO getDetallePedidoDAO() {
        if (INSTANCE == null)
            INSTANCE = new DetallePedidoDAO();
        return INSTANCE;
    }

    public boolean crearDetallePedido(DetallePedido detalle) {
        this.em.getTransaction().begin();
        try {
            this.em.persist(detalle);
            this.em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (this.em.getTransaction().isActive())
                this.em.getTransaction().rollback();
            return false;
        }
    }

    public DetallePedido leerDetallePedido(Long id) {
        return this.em.find(DetallePedido.class, id);
    }

    public List<DetallePedido> leerDetallesPedido() {
        return this.em.createQuery("FROM DetallePedido", DetallePedido.class).getResultList();
    }

    public List<DetallePedido> leerDetallesPorPedido(Pedido pedido) {
        return this.em.createQuery("FROM DetallePedido d WHERE d.pedido = :pedido", DetallePedido.class)
                .setParameter("pedido", pedido)
                .getResultList();
    }

    public List<DetallePedido> leerDetallesPorPedidoId(Long pedidoId) {
        return this.em.createQuery("FROM DetallePedido d WHERE d.pedido.id = :pedidoId", DetallePedido.class)
                .setParameter("pedidoId", pedidoId)
                .getResultList();
    }

    public List<DetallePedido> leerDetallesPorProducto(Producto producto) {
        return this.em.createQuery("FROM DetallePedido d WHERE d.producto = :producto", DetallePedido.class)
                .setParameter("producto", producto)
                .getResultList();
    }

    public List<DetallePedido> leerDetallesPorProductoId(int productoId) {
        return this.em.createQuery("FROM DetallePedido d WHERE d.producto.idProducto = :productoId", DetallePedido.class)
                .setParameter("productoId", productoId)
                .getResultList();
    }

    public boolean actualizarDetallePedido(DetallePedido detalle) {
        this.em.getTransaction().begin();
        try {
            this.em.merge(detalle);
            this.em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (this.em.getTransaction().isActive())
                this.em.getTransaction().rollback();
            return false;
        }
    }

    public boolean eliminarDetallePedido(DetallePedido detalle) {
        this.em.getTransaction().begin();
        try {
            DetallePedido managedDetalle = this.em.contains(detalle) ? detalle : this.em.merge(detalle);
            this.em.remove(managedDetalle);
            this.em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (this.em.getTransaction().isActive())
                this.em.getTransaction().rollback();
            return false;
        }
    }

    public boolean eliminarDetallePedidoPorId(Long id) {
        DetallePedido detalle = leerDetallePedido(id);
        if (detalle != null) {
            return eliminarDetallePedido(detalle);
        }
        return false;
    }
}
