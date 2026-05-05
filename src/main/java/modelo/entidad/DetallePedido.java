package modelo.entidad;

import java.io.Serializable;

import jakarta.persistence.*;

@Entity
@Table(name = "detalle_pedido")
public class DetallePedido implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "cantidad", nullable = false)
    private int cantidad;

    @Column(name = "precio_compra", nullable = false)
    private double precioCompra;

    @ManyToOne
    @JoinColumn(name = "pedido_id", nullable = false)
    private Pedido pedido;

    @ManyToOne
    @JoinColumn(name = "producto_id", nullable = false)
    private Producto producto;

    // ======================
    // Constructores
    // ======================

    public DetallePedido() {}

    public DetallePedido(int cantidad, double precioCompra, Pedido pedido, Producto producto) {
        this.cantidad = cantidad;
        this.precioCompra = precioCompra;
        this.pedido = pedido;
        this.producto = producto;
    }

    public DetallePedido(int cantidad, double precioCompra, Producto producto) {
        this.cantidad = cantidad;
        this.precioCompra = precioCompra;
        this.producto = producto;
    }

    // ======================
    // Getters y Setters
    // ======================

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getPrecioCompra() {
        return precioCompra;
    }

    public void setPrecioCompra(double precioCompra) {
        this.precioCompra = precioCompra;
    }

    public Pedido getPedido() {
        return pedido;
    }

    public void setPedido(Pedido pedido) {
        this.pedido = pedido;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    // ======================
    // Método auxiliar
    // ======================

    public double getSubtotal() {
        return this.cantidad * this.precioCompra;
    }
}
