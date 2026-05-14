# Proyecto_CDS

Una aplicación web de comercio electrónico de discos de vinilo construida con Jakarta EE, Jersey (JAX-RS), JPA/EclipseLink y JSP. Los usuarios pueden explorar un catálogo de productos, registrarse/iniciar sesión y realizar pedidos. Existe un rol de administrador para gestionar el inventario.

## Tecnologías Utilizadas

- **Java 21** / Jakarta EE
- **Apache Tomcat 10.x** — contenedor de servlets
- **Jersey 3.1** — API REST (`/rest/*`)
- **EclipseLink 4.0** — JPA/ORM
- **MySQL 8** — base de datos relacional
- **JSP + JSTL** — vistas en el servidor

## Ejecución con Docker

### Requisitos Previos

- Tener instalados [Docker](https://docs.docker.com/get-docker/) y [Docker Compose](https://docs.docker.com/compose/install/).

### Pasos

```bash
# 1. Clonar el repositorio (si aún no lo has hecho)
git clone <url-del-repo>
cd Proyecto_CDS

# 2. Construir e iniciar todos los servicios
docker compose up -d

# 3. Abrir la aplicación en el navegador
#    http://localhost:8080
```

La primera ejecución tarda unos minutos mientras Maven descarga las dependencias y construye el archivo WAR. Los inicios posteriores son rápidos.

### Detener la aplicación

```bash
docker compose down
```

Para borrar también el volumen de la base de datos:

```bash
docker compose down -v
```

## Credenciales por Defecto

| Rol           | Correo                  | Contraseña |
|---------------|-------------------------|------------|
| Administrador | admin@gmail.com         | admin123   |
| Usuario       | juan.perez@gmail.com    | 123456     |

## Estructura del Proyecto

```
src/main/
├── java/
│   ├── controlador/   # Controladores de lógica de negocio
│   ├── modelo/
│   │   ├── conexion/  # Ayudante de conexión JDBC
│   │   ├── dao/       # Objetos de acceso a datos (DAO)
│   │   └── entidad/   # Entidades JPA
│   └── recursos/      # Endpoints REST de JAX-RS (/rest/*)
├── resources/
│   └── META-INF/
│       └── persistence.xml   # Configuración de JPA
└── webapp/
    ├── WEB-INF/web.xml       # Configuración de Servlets y Jersey
    ├── jsp/                  # Vistas JSP
    └── img/                  # Imágenes de productos
```
