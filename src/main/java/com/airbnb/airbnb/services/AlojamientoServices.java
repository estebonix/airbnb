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

@Service
public class AlojamientoServices {
    
    @Autowired
    private ServicioServices servicioServices;
    
    @Value("${database.sql.connection}")
    private String databaseUrl;
    private Connection conn;

    // Obtener todos los alojamientos de la base de datos
    // y devolverlos como una lista de objetos AlojamientoDTO
    public List<AlojamientoDTO> getAlojamientos() {
        try(Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM alojamientos");
            ResultSet rs = ps.executeQuery();
            List<AlojamientoDTO> alojamientos = new ArrayList<>();
            while (rs.next()) {
                Long id = rs.getLong("id");
                String titulo = rs.getString("titulo");
                String descripcion = rs.getString("descripcion");
                String tipoAlojamiento = rs.getString("tipo_alojamiento");
                Integer capacidad = rs.getInt("capacidad");
                Integer habitaciones = rs.getInt("habitaciones");
                Integer camas = rs.getInt("camas");
                Integer banos = rs.getInt("banos");
                Double precioNoche = rs.getDouble("precio_noche");
                String direccion = rs.getString("direccion");
                String direccion_descripcion = rs.getString("direccion_descripcion");
                String ciudad = rs.getString("ciudad");
                String pais = rs.getString("pais");
                String codigoPostal = rs.getString("codigo_postal");
                Date fecha_registro = rs.getDate("fecha_registro");
                
                alojamientos.add(new AlojamientoDTO(banos, camas, capacidad, ciudad, codigoPostal, descripcion, direccion, direccion_descripcion, fecha_registro, habitaciones, id, pais, precioNoche, tipoAlojamiento, titulo));
            }
            return alojamientos;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    
    // Obtener un alojamiento por su id
    public AlojamientoDTO getAlojamientoById(Long id) {
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM alojamientos WHERE id = ?");
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String titulo = rs.getString("titulo");
                String descripcion = rs.getString("descripcion");
                String tipoAlojamiento = rs.getString("tipo_alojamiento");
                Integer capacidad = rs.getInt("capacidad");
                Integer habitaciones = rs.getInt("habitaciones");
                Integer camas = rs.getInt("camas");
                Integer banos = rs.getInt("banos");
                Double precioNoche = rs.getDouble("precio_noche");
                String direccion = rs.getString("direccion");
                String direccion_descripcion = rs.getString("direccion_descripcion");
                String ciudad = rs.getString("ciudad");
                String pais = rs.getString("pais");
                String codigoPostal = rs.getString("codigo_postal");
                Date fecha_registro = rs.getDate("fecha_registro");

                return new AlojamientoDTO(banos, camas, capacidad, ciudad, codigoPostal, descripcion, direccion, direccion_descripcion, fecha_registro, habitaciones, id, pais, precioNoche, tipoAlojamiento, titulo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Agregar un nuevo alojamiento a la base de datos
    public String addAlojamiento(AlojamientoDTO alojamiento) {
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")){
            PreparedStatement ps = conn.prepareStatement("INSERT INTO alojamientos (titulo, descripcion, tipo_alojamiento, capacidad, habitaciones, camas, banos, precio_noche, direccion, direccion_descripcion, ciudad, pais, codigo_postal, fecha_registro) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_DATE)");
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
            
            int rows = ps.executeUpdate();
            ps.close();
            conn.close();
            if (rows > 0) {
                return "Alojamiento agregado correctamente";
            } else {
                return "No se pudo agregar el alojamiento";
            }

            
        } catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    public String updateAlojamiento(Long id, AlojamientoDTO alojamientoDTO) {
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            PreparedStatement ps = conn.prepareStatement("UPDATE alojamientos SET titulo = ?, descripcion = ?, tipo_alojamiento = ?, capacidad = ?, habitaciones = ?, camas = ?, banos = ?, precio_noche = ?, direccion = ?, direccion_descripcion = ?, ciudad = ?, pais = ?, codigo_postal = ? WHERE id = ?");
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