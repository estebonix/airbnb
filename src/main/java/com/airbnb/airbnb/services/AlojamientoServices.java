package com.airbnb.airbnb.services;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.airbnb.airbnb.dto.AlojamientoDTO;
import com.airbnb.airbnb.dto.UsuarioDTO;

@Service
public class AlojamientoServices {

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
                ORDER BY a.id
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
                ORDER BY a.id
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
                ORDER BY a.id
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

    // Agregar un nuevo alojamiento (con propietario por email)
    public String addAlojamiento(AlojamientoDTO alojamiento, String emailPropietario) {
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            // Primero obtener el ID del usuario por email
            PreparedStatement userPs = conn.prepareStatement("SELECT id FROM usuarios WHERE email = ?");
            userPs.setString(1, emailPropietario);
            ResultSet userRs = userPs.executeQuery();

            if (!userRs.next()) {
                return "Usuario no encontrado";
            }

            Long idUsuario = userRs.getLong("id");

            // Insertar el alojamiento
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

            // Proceder con la eliminación
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
