package com.airbnb.airbnb.services;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.airbnb.airbnb.dto.AlojamientoDTO;
import com.airbnb.airbnb.dto.UsuarioDTO;

@Service
public class AlojamientoServices {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private ServicioServices servicioServices;

    @Value("${database.sql.connection}")
    private String databaseUrl;

    // Método auxiliar para crear UsuarioDTO desde ResultSet
    private UsuarioDTO createUsuarioFromResultSet(ResultSet rs, String prefix) throws Exception {
        Long id = rs.getLong(prefix + "id");
        String nombre = rs.getString(prefix + "nombre");
        String apellido = rs.getString(prefix + "apellido");
        String email = rs.getString(prefix + "email");
        String contraseña = rs.getString(prefix + "contraseña");
        Date fechaNacimiento = rs.getDate(prefix + "fecha_nacimiento");
        String telefono = rs.getString(prefix + "telefono");
        String biografia = rs.getString(prefix + "biografia");
        String fechaRegistro = rs.getString(prefix + "fecha_registro");

        return new UsuarioDTO(id, nombre, apellido, email, contraseña, fechaNacimiento, telefono, biografia, fechaRegistro);
    }

    // Método auxiliar para crear AlojamientoDTO desde ResultSet con propietario
    private AlojamientoDTO createAlojamientoFromResultSet(ResultSet rs) throws Exception {
        Long id = rs.getLong("a.id");
        String titulo = rs.getString("a.titulo");
        String descripcion = rs.getString("a.descripcion");
        String tipoAlojamiento = rs.getString("a.tipo_alojamiento");
        Integer capacidad = rs.getInt("a.capacidad");
        Integer habitaciones = rs.getInt("a.habitaciones");
        Integer camas = rs.getInt("a.camas");
        Integer banos = rs.getInt("a.banos");
        Double precioNoche = rs.getDouble("a.precio_noche");
        String direccion = rs.getString("a.direccion");
        String direccionDescripcion = rs.getString("a.direccion_descripcion");
        String ciudad = rs.getString("a.ciudad");
        String pais = rs.getString("a.pais");
        String codigoPostal = rs.getString("a.codigo_postal");
        Date fechaRegistro = rs.getDate("a.fecha_registro");

        // Crear el objeto propietario
        UsuarioDTO propietario = createUsuarioFromResultSet(rs, "u.");

        return new AlojamientoDTO(id, titulo, descripcion, tipoAlojamiento, capacidad, habitaciones,
                camas, banos, precioNoche, direccion, direccionDescripcion, ciudad,
                pais, codigoPostal, fechaRegistro, propietario);
    }

    // Obtener todos los alojamientos con información del propietario
    public List<AlojamientoDTO> getAlojamientos() {
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            String query = """
                SELECT 
                    a.id, a.titulo, a.descripcion, a.tipo_alojamiento, a.capacidad, 
                    a.habitaciones, a.camas, a.banos, a.precio_noche, a.direccion, 
                    a.direccion_descripcion, a.ciudad, a.pais, a.codigo_postal, 
                    a.fecha_registro, a.id_usuario,
                    u.id as 'u.id', u.nombre as 'u.nombre', u.apellido as 'u.apellido', 
                    u.email as 'u.email', u.contraseña as 'u.contraseña', 
                    u.fecha_nacimiento as 'u.fecha_nacimiento', u.telefono as 'u.telefono', 
                    u.biografia as 'u.biografia', u.fecha_registro as 'u.fecha_registro'
                FROM alojamientos a 
                INNER JOIN usuarios u ON a.id_usuario = u.id
                ORDER BY a.id DESC
                """;

            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            List<AlojamientoDTO> alojamientos = new ArrayList<>();

            while (rs.next()) {
                alojamientos.add(createAlojamientoFromResultSet(rs));
            }
            return alojamientos;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    // Obtener un alojamiento por su id con información del propietario
    public AlojamientoDTO getAlojamientoById(Long id) {
        try (Connection conn = dataSource.getConnection()) {
            String query = """
                SELECT 
                    a.id, a.titulo, a.descripcion, a.tipo_alojamiento, a.capacidad, 
                    a.habitaciones, a.camas, a.banos, a.precio_noche, a.direccion, 
                    a.direccion_descripcion, a.ciudad, a.pais, a.codigo_postal, 
                    a.fecha_registro, a.id_usuario,
                    u.id as 'u.id', u.nombre as 'u.nombre', u.apellido as 'u.apellido', 
                    u.email as 'u.email', u.contraseña as 'u.contraseña', 
                    u.fecha_nacimiento as 'u.fecha_nacimiento', u.telefono as 'u.telefono', 
                    u.biografia as 'u.biografia', u.fecha_registro as 'u.fecha_registro'
                FROM alojamientos a 
                INNER JOIN usuarios u ON a.id_usuario = u.id 
                WHERE a.id = ?
                """;

            PreparedStatement ps = conn.prepareStatement(query);
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return createAlojamientoFromResultSet(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Obtener alojamientos por propietario (por ID)
    public List<AlojamientoDTO> getAlojamientosByUsuario(Long idUsuario) {
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            String query = """
                SELECT 
                    a.id, a.titulo, a.descripcion, a.tipo_alojamiento, a.capacidad, 
                    a.habitaciones, a.camas, a.banos, a.precio_noche, a.direccion, 
                    a.direccion_descripcion, a.ciudad, a.pais, a.codigo_postal, 
                    a.fecha_registro, a.id_usuario,
                    u.id as 'u.id', u.nombre as 'u.nombre', u.apellido as 'u.apellido', 
                    u.email as 'u.email', u.contraseña as 'u.contraseña', 
                    u.fecha_nacimiento as 'u.fecha_nacimiento', u.telefono as 'u.telefono', 
                    u.biografia as 'u.biografia', u.fecha_registro as 'u.fecha_registro'
                FROM alojamientos a 
                INNER JOIN usuarios u ON a.id_usuario = u.id 
                WHERE a.id_usuario = ?
                ORDER BY a.id DESC
                """;

            PreparedStatement ps = conn.prepareStatement(query);
            ps.setLong(1, idUsuario);
            ResultSet rs = ps.executeQuery();
            List<AlojamientoDTO> alojamientos = new ArrayList<>();

            while (rs.next()) {
                alojamientos.add(createAlojamientoFromResultSet(rs));
            }
            return alojamientos;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    // Obtener alojamientos por email del propietario
    public List<AlojamientoDTO> getAlojamientosByUsuarioEmail(String email) {
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            String query = """
                SELECT 
                    a.id, a.titulo, a.descripcion, a.tipo_alojamiento, a.capacidad, 
                    a.habitaciones, a.camas, a.banos, a.precio_noche, a.direccion, 
                    a.direccion_descripcion, a.ciudad, a.pais, a.codigo_postal, 
                    a.fecha_registro, a.id_usuario,
                    u.id as 'u.id', u.nombre as 'u.nombre', u.apellido as 'u.apellido', 
                    u.email as 'u.email', u.contraseña as 'u.contraseña', 
                    u.fecha_nacimiento as 'u.fecha_nacimiento', u.telefono as 'u.telefono', 
                    u.biografia as 'u.biografia', u.fecha_registro as 'u.fecha_registro'
                FROM alojamientos a 
                INNER JOIN usuarios u ON a.id_usuario = u.id 
                WHERE u.email = ?
                ORDER BY a.id DESC
                """;

            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            List<AlojamientoDTO> alojamientos = new ArrayList<>();

            while (rs.next()) {
                alojamientos.add(createAlojamientoFromResultSet(rs));
            }
            return alojamientos;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    // Agregar un nuevo alojamiento y devolver su ID
    public Long addAlojamientoConId(AlojamientoDTO alojamiento, String emailPropietario) {
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            // Primero obtener el ID del usuario por email
            PreparedStatement userPs = conn.prepareStatement("SELECT id FROM usuarios WHERE email = ?");
            userPs.setString(1, emailPropietario);
            ResultSet userRs = userPs.executeQuery();

            if (!userRs.next()) {
                throw new RuntimeException("Usuario no encontrado");
            }

            Long idUsuario = userRs.getLong("id");

            // Insertar el alojamiento y obtener el ID generado
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO alojamientos (titulo, descripcion, tipo_alojamiento, capacidad, habitaciones, camas, banos, precio_noche, direccion, direccion_descripcion, ciudad, pais, codigo_postal, fecha_registro, id_usuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_DATE, ?)",
                Statement.RETURN_GENERATED_KEYS
            );
            
            ps.setString(1, alojamiento.getTitulo());
            ps.setString(2, alojamiento.getDescripcion());
            ps.setString(3, alojamiento.getTipoAlojamiento());
            ps.setInt(4, alojamiento.getCapacidad());
            ps.setInt(5, alojamiento.getHabitaciones());
            ps.setInt(6, alojamiento.getCamas());
            ps.setInt(7, alojamiento.getBanos());
            ps.setDouble(8, alojamiento.getPrecioNoche());
            ps.setString(9, alojamiento.getDireccion());
            ps.setString(10, alojamiento.getDireccionDescripcion());
            ps.setString(11, alojamiento.getCiudad());
            ps.setString(12, alojamiento.getPais());
            ps.setString(13, alojamiento.getCodigoPostal());
            ps.setLong(14, idUsuario);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getLong(1);
                }
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error al crear alojamiento: " + e.getMessage());
        }
    }

    // Insertar imagen en la base de datos (ajustado para int)
    public void insertarImagen(Long alojamientoId, String descripcion, String urlImagen, int esPrincipal, int orden) {
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            // Generar código corto que quepa en varchar(10)
            // Formato: IMG + 2 dígitos del alojamientoId + 2 dígitos del orden + 1 dígito random
            String codigo = String.format("IMG%02d%02d%d", 
                alojamientoId % 100,  // Últimos 2 dígitos del ID
                orden % 100,          // Orden (máximo 99)
                (int)(Math.random() * 10)  // Dígito random para unicidad
            );
            
            // Asegurar que el código no exceda 10 caracteres
            if (codigo.length() > 10) {
                codigo = codigo.substring(0, 10);
            }
            
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO imagenes_alojamiento (codigo, descripcion, alojamiento_id, url_imagen, es_principal, orden) VALUES (?, ?, ?, ?, ?, ?)"
            );
            ps.setString(1, codigo);
            ps.setString(2, descripcion != null ? descripcion : "Imagen del alojamiento");
            ps.setInt(3, alojamientoId.intValue()); // Convertir Long a int para la BD
            ps.setString(4, urlImagen);
            ps.setInt(5, esPrincipal);
            ps.setInt(6, orden);
            
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                throw new RuntimeException("No se pudo insertar la imagen");
            }
            
            System.out.println("Imagen insertada correctamente: " + codigo + " para alojamiento " + alojamientoId);
            
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error detallado al insertar imagen: " + e.getMessage());
            throw new RuntimeException("Error al insertar imagen: " + e.getMessage());
        }
    }

    // Asociar servicio al alojamiento (ajustado para int)
    public void asociarServicio(Long alojamientoId, String nombreServicio) {
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            System.out.println("Asociando servicio '" + nombreServicio + "' al alojamiento " + alojamientoId);
            
            // Primero buscar si el servicio existe
            PreparedStatement buscarPs = conn.prepareStatement("SELECT id FROM servicios WHERE descripcion = ?");
            buscarPs.setString(1, nombreServicio);
            ResultSet rs = buscarPs.executeQuery();
            
            Long servicioId;
            if (rs.next()) {
                servicioId = rs.getLong("id");
                System.out.println("Servicio existente encontrado con ID: " + servicioId);
            } else {
                // Si no existe, crearlo
                System.out.println("Creando nuevo servicio: " + nombreServicio);
                PreparedStatement crearPs = conn.prepareStatement(
                    "INSERT INTO servicios (codigo, descripcion, icono) VALUES (?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS
                );
                String codigo = nombreServicio.toLowerCase()
                    .replace(" ", "_")
                    .replace("ñ", "n")
                    .replaceAll("[^a-z0-9_]", ""); // Limpiar caracteres especiales
                
                // Limitar código a longitud apropiada si es necesario
                if (codigo.length() > 50) {
                    codigo = codigo.substring(0, 50);
                }
                
                crearPs.setString(1, codigo);
                crearPs.setString(2, nombreServicio);
                crearPs.setString(3, "default.png"); // Icono por defecto
                
                crearPs.executeUpdate();
                ResultSet generatedKeys = crearPs.getGeneratedKeys();
                if (generatedKeys.next()) {
                    servicioId = generatedKeys.getLong(1);
                    System.out.println("Nuevo servicio creado con ID: " + servicioId);
                } else {
                    throw new RuntimeException("No se pudo crear el servicio");
                }
            }
            
            // Asociar el servicio al alojamiento
            PreparedStatement asociarPs = conn.prepareStatement(
                "INSERT IGNORE INTO alojamiento_servicios (alojamiento_id, servicio_id) VALUES (?, ?)"
            );
            asociarPs.setInt(1, alojamientoId.intValue()); // Convertir Long a int
            asociarPs.setLong(2, servicioId);
            
            int rowsInserted = asociarPs.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Servicio asociado correctamente");
            } else {
                System.out.println("El servicio ya estaba asociado al alojamiento");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error al asociar servicio '" + nombreServicio + "': " + e.getMessage());
            throw new RuntimeException("Error al asociar servicio: " + e.getMessage());
        }
    }

    // Agregar un nuevo alojamiento (con propietario por email)
    public String addAlojamiento(AlojamientoDTO alojamiento, String emailPropietario) {
        try {
            Long id = addAlojamientoConId(alojamiento, emailPropietario);
            if (id != null) {
                return "Alojamiento agregado correctamente";
            } else {
                return "No se pudo agregar el alojamiento";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Error: " + e.getMessage();
        }
    }

    // Agregar alojamiento por ID de usuario
    public String addAlojamiento(AlojamientoDTO alojamiento, Long idUsuario) {
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO alojamientos (titulo, descripcion, tipo_alojamiento, capacidad, habitaciones, camas, banos, precio_noche, direccion, direccion_descripcion, ciudad, pais, codigo_postal, fecha_registro, id_usuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_DATE, ?)"
            );
            ps.setString(1, alojamiento.getTitulo());
            ps.setString(2, alojamiento.getDescripcion());
            ps.setString(3, alojamiento.getTipoAlojamiento());
            ps.setInt(4, alojamiento.getCapacidad());
            ps.setInt(5, alojamiento.getHabitaciones());
            ps.setInt(6, alojamiento.getCamas());
            ps.setInt(7, alojamiento.getBanos());
            ps.setDouble(8, alojamiento.getPrecioNoche());
            ps.setString(9, alojamiento.getDireccion());
            ps.setString(10, alojamiento.getDireccionDescripcion());
            ps.setString(11, alojamiento.getCiudad());
            ps.setString(12, alojamiento.getPais());
            ps.setString(13, alojamiento.getCodigoPostal());
            ps.setLong(14, idUsuario);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                return "Alojamiento agregado correctamente";
            } else {
                return "No se pudo agregar el alojamiento";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Error: " + e.getMessage();
        }
    }

    // Método de compatibilidad (deprecated)
    @Deprecated
    public String addAlojamiento(AlojamientoDTO alojamiento) {
        return addAlojamiento(alojamiento, 1L);
    }

    // Actualizar alojamiento (verificando propiedad por email)
    public String updateAlojamiento(Long id, AlojamientoDTO alojamientoDTO, String emailUsuario) {
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            // Verificar que el usuario es el propietario
            String checkQuery = """
                SELECT a.id_usuario, u.email 
                FROM alojamientos a 
                INNER JOIN usuarios u ON a.id_usuario = u.id 
                WHERE a.id = ?
                """;

            PreparedStatement checkPs = conn.prepareStatement(checkQuery);
            checkPs.setLong(1, id);
            ResultSet rs = checkPs.executeQuery();

            if (!rs.next()) {
                return "Alojamiento no encontrado";
            }

            String emailPropietario = rs.getString("email");
            if (!emailPropietario.equals(emailUsuario)) {
                return "No tienes permisos para modificar este alojamiento";
            }

            // Proceder con la actualización
            PreparedStatement ps = conn.prepareStatement(
                    "UPDATE alojamientos SET titulo = ?, descripcion = ?, tipo_alojamiento = ?, capacidad = ?, habitaciones = ?, camas = ?, banos = ?, precio_noche = ?, direccion = ?, direccion_descripcion = ?, ciudad = ?, pais = ?, codigo_postal = ? WHERE id = ?"
            );
            ps.setString(1, alojamientoDTO.getTitulo());
            ps.setString(2, alojamientoDTO.getDescripcion());
            ps.setString(3, alojamientoDTO.getTipoAlojamiento());
            ps.setInt(4, alojamientoDTO.getCapacidad());
            ps.setInt(5, alojamientoDTO.getHabitaciones());
            ps.setInt(6, alojamientoDTO.getCamas());
            ps.setInt(7, alojamientoDTO.getBanos());
            ps.setDouble(8, alojamientoDTO.getPrecioNoche());
            ps.setString(9, alojamientoDTO.getDireccion());
            ps.setString(10, alojamientoDTO.getDireccionDescripcion());
            ps.setString(11, alojamientoDTO.getCiudad());
            ps.setString(12, alojamientoDTO.getPais());
            ps.setString(13, alojamientoDTO.getCodigoPostal());
            ps.setLong(14, id);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                return "Alojamiento actualizado correctamente";
            } else {
                return "No se pudo actualizar el alojamiento";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Error al actualizar el alojamiento: " + e.getMessage();
        }
    }

    // Eliminar alojamiento (verificando propiedad por email)
    public String deleteAlojamiento(Long id, String emailUsuario) {
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            // Verificar que el usuario es el propietario
            String checkQuery = """
                SELECT a.id_usuario, u.email 
                FROM alojamientos a 
                INNER JOIN usuarios u ON a.id_usuario = u.id 
                WHERE a.id = ?
                """;

            PreparedStatement checkPs = conn.prepareStatement(checkQuery);
            checkPs.setLong(1, id);
            ResultSet rs = checkPs.executeQuery();

            if (!rs.next()) {
                return "Alojamiento no encontrado";
            }

            String emailPropietario = rs.getString("email");
            if (!emailPropietario.equals(emailUsuario)) {
                return "No tienes permisos para eliminar este alojamiento";
            }

            // Eliminar primero las referencias en otras tablas
            PreparedStatement deleteImagenesPs = conn.prepareStatement("DELETE FROM imagenes_alojamiento WHERE alojamiento_id = ?");
            deleteImagenesPs.setLong(1, id);
            deleteImagenesPs.executeUpdate();

            PreparedStatement deleteServiciosPs = conn.prepareStatement("DELETE FROM alojamiento_servicios WHERE alojamiento_id = ?");
            deleteServiciosPs.setLong(1, id);
            deleteServiciosPs.executeUpdate();

            PreparedStatement deleteValoracionesPs = conn.prepareStatement("DELETE FROM valoraciones WHERE alojamiento_id = ?");
            deleteValoracionesPs.setLong(1, id);
            deleteValoracionesPs.executeUpdate();

            // Proceder con la eliminación del alojamiento
            PreparedStatement ps = conn.prepareStatement("DELETE FROM alojamientos WHERE id = ?");
            ps.setLong(1, id);
            int rows = ps.executeUpdate();
            if (rows > 0) {
                return "Alojamiento eliminado correctamente";
            } else {
                return "No se pudo eliminar el alojamiento";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Error al eliminar el alojamiento: " + e.getMessage();
        }
    }

    // Métodos de compatibilidad (deprecated)
    @Deprecated
    public String updateAlojamiento(Long id, AlojamientoDTO alojamientoDTO) {
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            PreparedStatement ps = conn.prepareStatement(
                    "UPDATE alojamientos SET titulo = ?, descripcion = ?, tipo_alojamiento = ?, capacidad = ?, habitaciones = ?, camas = ?, banos = ?, precio_noche = ?, direccion = ?, direccion_descripcion = ?, ciudad = ?, pais = ?, codigo_postal = ? WHERE id = ?"
            );
            ps.setString(1, alojamientoDTO.getTitulo());
            ps.setString(2, alojamientoDTO.getDescripcion());
            ps.setString(3, alojamientoDTO.getTipoAlojamiento());
            ps.setInt(4, alojamientoDTO.getCapacidad());
            ps.setInt(5, alojamientoDTO.getHabitaciones());
            ps.setInt(6, alojamientoDTO.getCamas());
            ps.setInt(7, alojamientoDTO.getBanos());
            ps.setDouble(8, alojamientoDTO.getPrecioNoche());
            ps.setString(9, alojamientoDTO.getDireccion());
            ps.setString(10, alojamientoDTO.getDireccionDescripcion());
            ps.setString(11, alojamientoDTO.getCiudad());
            ps.setString(12, alojamientoDTO.getPais());
            ps.setString(13, alojamientoDTO.getCodigoPostal());
            ps.setLong(14, id);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                return "Alojamiento actualizado correctamente";
            } else {
                return "No se encontró el alojamiento con el ID proporcionado";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Error al actualizar el alojamiento";
        }
    }

    @Deprecated
    public String deleteAlojamiento(Long id) {
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            // Eliminar primero las referencias en otras tablas
            PreparedStatement deleteImagenesPs = conn.prepareStatement("DELETE FROM imagenes_alojamiento WHERE alojamiento_id = ?");
            deleteImagenesPs.setLong(1, id);
            deleteImagenesPs.executeUpdate();

            PreparedStatement deleteServiciosPs = conn.prepareStatement("DELETE FROM alojamiento_servicios WHERE alojamiento_id = ?");
            deleteServiciosPs.setLong(1, id);
            deleteServiciosPs.executeUpdate();

            PreparedStatement deleteValoracionesPs = conn.prepareStatement("DELETE FROM valoraciones WHERE alojamiento_id = ?");
            deleteValoracionesPs.setLong(1, id);
            deleteValoracionesPs.executeUpdate();

            // Eliminar el alojamiento
            PreparedStatement ps = conn.prepareStatement("DELETE FROM alojamientos WHERE id = ?");
            ps.setLong(1, id);
            int rows = ps.executeUpdate();
            if (rows > 0) {
                return "Alojamiento eliminado correctamente";
            } else {
                return "No se encontró el alojamiento con el ID proporcionado";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Error al eliminar el alojamiento";
        }
    }
}