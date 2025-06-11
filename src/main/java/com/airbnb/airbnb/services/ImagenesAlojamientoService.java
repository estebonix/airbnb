package com.airbnb.airbnb.services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.airbnb.airbnb.dto.AlojamientoDTO;
import com.airbnb.airbnb.dto.ImagenDTO;

@Service
public class ImagenesAlojamientoService {

    @Value("${database.sql.connection}")
    private String databaseUrl;
    private Connection conn;

    public ResponseEntity<String> getMainImagen(Integer id) {
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            PreparedStatement ps = conn.prepareStatement("SELECT url_imagen FROM imagenes_alojamiento WHERE alojamiento_id = ? AND es_principal = 1");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String url_imagen = rs.getString("url_imagen");
                return ResponseEntity.ok(url_imagen);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

    public List<ImagenDTO> getImagenesByAlojamientoId(Long id) {
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM imagenes_alojamiento WHERE alojamiento_id = ?");
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            List<ImagenDTO> imagenes = new ArrayList<>();
            while (rs.next()) {
                Long imagenId = rs.getLong("id");
                String descripcion = rs.getString("descripcion");
                AlojamientoDTO alojamiento = new AlojamientoServices().getAlojamientoById(rs.getLong("alojamiento_id"));
                String url_imagen = rs.getString("url_imagen");
                Integer es_principal = rs.getInt("es_principal");
                Integer orden = rs.getInt("orden");
                imagenes.add(new ImagenDTO(alojamiento, descripcion, es_principal, imagenId, orden, url_imagen));
            }
            return imagenes;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ArrayList<>();
    }
}
