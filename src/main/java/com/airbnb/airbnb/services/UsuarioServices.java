package com.airbnb.airbnb.services;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.airbnb.airbnb.dto.UsuarioDTO;

@Service
public class UsuarioServices {
    
    @Value("${database.sql.connection}")
    private String databaseUrl;

    // Obtener un anfitrion por su id
    public UsuarioDTO getAnfitrionById(Long id) {
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM usuarios WHERE id = ?");
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Long idUsuario = rs.getLong("id");
                String nombre = rs.getString("nombre");
                String apellido = rs.getString("apellido");
                String email = rs.getString("email");
                String contraseña = rs.getString("contraseña");
                Date fechaNacimiento = rs.getDate("fecha_nacimiento");
                String telefono = rs.getString("telefono");
                String es_superhost = rs.getString("es_superhost");
                String calificacion_promedio = rs.getString("calificacion_promedio");
                String biografia = rs.getString("biografia");
                String fecha_registro = rs.getString("fecha_registro");

                return new UsuarioDTO(idUsuario, nombre, apellido, email, contraseña, fechaNacimiento, telefono, biografia, fecha_registro);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Crear un nuevo usuario
    public UsuarioDTO crearUsuario(UsuarioDTO usuario) {
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO usuarios (nombre, apellido, email, contraseña, fecha_nacimiento, telefono, biografia) VALUES (?, ?, ?, ?, ?, ?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellido());
            ps.setString(3, usuario.getEmail());
            ps.setString(4, usuario.getContraseña());
            ps.setDate(5, usuario.getFechaNacimiento());
            ps.setString(6, usuario.getTelefono());
            ps.setString(9, usuario.getBiografia());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    Long id = generatedKeys.getLong(1);
                    usuario.setId(id);
                    return usuario;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}