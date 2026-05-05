package recursos;


import java.util.ArrayList;
import java.util.List;

import modelo.entidad.Producto;

public class Carrito {
	
	private static Carrito INSTANCE;
	
	public static Carrito getInstance() {
		if (INSTANCE == null) {
			INSTANCE = new Carrito();
		}
		return INSTANCE;
	}

    private List<ItemCarrito> items = new ArrayList<>();

    // ======================
    // Agregar producto
    // ======================

    public void agregarProducto(Producto producto, int cantidad) {

        for (ItemCarrito item : items) {
            if (item.getProducto().getIdProducto()
                    == (producto.getIdProducto())) {

                item.setCantidad(
                    item.getCantidad() + cantidad
                );
                return;
            }
        }

        items.add(new ItemCarrito(producto, cantidad));
    }

    // ======================
    // Eliminar producto
    // ======================

    public void eliminarProducto(Long productoId) {
        items.removeIf(
            i -> i.getProducto().getIdProducto()
                 == (productoId)
        );
    }

    // ======================
    // Actualizar cantidad
    // ======================

    public void actualizarCantidad(Long productoId,
                                   int cantidad) {

        for (ItemCarrito item : items) {
            if (item.getProducto().getIdProducto()
                    == (productoId)) {

                item.setCantidad(cantidad);
                return;
            }
        }
    }

    // ======================
    // Calcular total
    // ======================

    public double getTotal() {
        double total = 0;

        for (ItemCarrito item : items) {
            total += item.getSubtotal();
        }

        return total;
    }


    public List<ItemCarrito> getItems() {
        return items;
    }

    public boolean estaVacio() {
        return items.isEmpty();
    }

    public void vaciar() {
        items.clear();
    }
}

