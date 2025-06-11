package com.airbnb.airbnb.services;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.airbnb.airbnb.dto.AlojamientoDTO;
import com.airbnb.airbnb.dto.UsuarioDTO;
import com.airbnb.airbnb.dto.ValoracionDTO;

@Service
public class ValoracionesAlojamientoService {
    
    @Value("${database.sql.connection}")
    private String databaseUrl;
    
    @Autowired
    AlojamientoServices alojamientoServices;
    @Autowired
    UsuarioServices usuarioServices;

    public ResponseEntity<ValoracionDTO> getValoracion(Integer id) {
        try (Connection connection = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM valoraciones WHERE id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String codigo = rs.getString("codigo");
                String descripcion = rs.getString("descripcion");
                Integer puntuacion = rs.getInt("puntuacion");
                String comentario = rs.getString("comentario");
                Integer limpieza = rs.getInt("limpieza");
                Integer comunicacion = rs.getInt("comunicacion");
                Integer llegada = rs.getInt("llegada");
                Integer precision = rs.getInt("precision");
                Integer ubicacion = rs.getInt("ubicacion");
                Integer calidad_precio = rs.getInt("calidad_precio");
                Date fecha_valoracion = rs.getDate("fecha_valoracion");
                Long usuario_id = rs.getLong("usuario_id");
                Long alojamiento_id = rs.getLong("alojamiento_id");
                
                UsuarioDTO usuario = usuarioServices.getAnfitrionById(usuario_id);
                AlojamientoDTO alojamiento = alojamientoServices.getAlojamientoById(alojamiento_id);

                return ResponseEntity.ok(new ValoracionDTO(id, codigo, descripcion, usuario, alojamiento, puntuacion, comentario, limpieza, comunicacion, llegada, precision, ubicacion, calidad_precio, fecha_valoracion));
            } else {
                return ResponseEntity.notFound().build();
            }
            
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }


    public ResponseEntity<Double> getValoracionMedia(Long alojamiento_id) {
        try (Connection connection = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            PreparedStatement ps = connection.prepareStatement(
                "SELECT AVG(puntuacion) as media FROM valoraciones WHERE alojamiento_id = ?"
            );
            ps.setLong(1, alojamiento_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Double media = rs.getDouble("media");
                if (rs.wasNull()) {
                    return ResponseEntity.ok(0d);
                }
                return ResponseEntity.ok(media);
            } else {
                return ResponseEntity.ok(0d);
            }
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }
}
