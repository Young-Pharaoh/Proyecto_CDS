package recursos;


import modelo.dao.GestorProductoDAO;
import modelo.entidad.Producto;

import java.util.List;


import jakarta.ws.rs.*;
import jakarta.ws.rs.core.*;


@Path("/productos")
public class RecursoProducto {
	
	
	private GestorProductoDAO gestor;
	public RecursoProducto() {
		this.gestor = GestorProductoDAO.getGestorProducto();
	}
	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public List<Producto> getPersona(){
		return this.gestor.reedProducts();
	}
	
	@GET
	@Path("/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public Producto getPersonaPorId(@PathParam("id") int id){
		return this.gestor.reedProduct(id);
	}
	
	@POST
	@Path("/add")
	@Consumes(MediaType.APPLICATION_JSON)
	public boolean agregarPersona(Producto p) {
		return this.gestor.createProduct(p);
	}
	
	@PUT
	@Path("/update")
	@Consumes(MediaType.APPLICATION_JSON)
	public boolean actualizarPersona(Producto p) {
		return this.gestor.updateProduct(p);
	}
	
	@DELETE
	@Path("/delete/{id}")
	public boolean eliminarPersona(@PathParam("id") int id) {
		return this.gestor.deleteProduct(id);
	}
}
