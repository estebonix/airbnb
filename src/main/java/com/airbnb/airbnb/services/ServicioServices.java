package com.airbnb.airbnb.services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.airbnb.airbnb.dto.ServicioDTO;

@Service
public class ServicioServices {
    
    @Value("${database.sql.connection}")
    private String databaseUrl;

    public ServicioDTO getServicioById(Long id) {
        try(Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM servicios WHERE id = ?");
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Long servicioId = rs.getLong("id");
                String codigo = rs.getString("codigo");
                String descripcion = rs.getString("descripcion");
                String icono = rs.getString("icono");
                return new ServicioDTO(servicioId, codigo, descripcion, icono);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<String> getServiciosByAlojamientoId(Long alojamientoId) {
        List<Long> serviciosID = new ArrayList<>();
        List<String> servicios = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM alojamiento_servicios WHERE alojamiento_id = ?");
            ps.setLong(1, alojamientoId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Long servicio_id = rs.getLong("servicio_id");
                serviciosID.add(servicio_id);
            }

            for (Long servicioId : serviciosID) {
                servicios.add(getServicioById(servicioId).getDescripcion());
            }

            return servicios;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return servicios;
    }

    public List<ServicioDTO> getServiciosByAlojamientoId2(Long alojamientoId) {
        List<Long> serviciosID = new ArrayList<>();
        List<ServicioDTO> servicios = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(databaseUrl, "usuario", "usuario")) {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM alojamiento_servicios WHERE alojamiento_id = ?");
            ps.setLong(1, alojamientoId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Long servicio_id = rs.getLong("servicio_id");
                serviciosID.add(servicio_id);
            }

            for (Long servicioId : serviciosID) {
                ServicioDTO servicio = getServicioById(servicioId);
                servicios.add(new ServicioDTO(servicio.getId(), servicio.getCodigo(), servicio.getDescripcion(), servicio.getIcono()));
            }

            return servicios;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return servicios;
    }
}
