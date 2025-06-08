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

                return new UsuarioDTO(idUsuario, nombre, apellido, email, contraseña, fechaNacimiento, telefono, es_superhost, calificacion_promedio, biografia, fecha_registro);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
