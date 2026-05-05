package recursos;


import modelo.entidad.Producto;

public class ItemCarrito {

    private Producto producto;
    private int cantidad;

    // ======================
    // Constructor
    // ======================

    public ItemCarrito(Producto producto, int cantidad) {
        this.producto = producto;
        this.cantidad = cantidad;
    }

    // ======================
    // Getters y Setters
    // ======================

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    // ======================
    // Subtotal
    // ======================

    public double getSubtotal() {
        return producto.getPrecio() * cantidad;
    }
}
