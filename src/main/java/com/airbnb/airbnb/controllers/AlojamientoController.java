package com.airbnb.airbnb.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.airbnb.airbnb.dto.AlojamientoDTO;
import com.airbnb.airbnb.services.AlojamientoServices;

@RestController
@RequestMapping("/alojamiento")
public class AlojamientoController {

    @Autowired
    private AlojamientoServices alojamientoServices;

    // Crear alojamiento (requiere email del propietario)
    @PostMapping("/add")
    public ResponseEntity<String> addAlojamiento(
            @RequestParam String titulo,
            @RequestParam String descripcion,
            @RequestParam String tipoAlojamiento,
            @RequestParam Integer capacidad,
            @RequestParam Integer habitaciones,
            @RequestParam Integer camas,
            @RequestParam Integer banos,
            @RequestParam Double precioNoche,
            @RequestParam String direccion,
            @RequestParam String direccionDescripcion,
            @RequestParam String ciudad,
            @RequestParam String pais,
            @RequestParam String codigoPostal,
            @RequestParam(required = false) String emailPropietario) {

        AlojamientoDTO alojamiento = new AlojamientoDTO(null, titulo, descripcion, tipoAlojamiento,
                capacidad, habitaciones, camas, banos, precioNoche, direccion, direccionDescripcion,
                ciudad, pais, codigoPostal, null, null);

        String result;
        if (emailPropietario != null && !emailPropietario.trim().isEmpty()) {
            result = alojamientoServices.addAlojamiento(alojamiento, emailPropietario);
        } else {
            // Si no se especifica propietario, usar el método deprecated (usuario ID 1)
            result = alojamientoServices.addAlojamiento(alojamiento);
        }

        return ResponseEntity.ok(result);
    }

    // Consultar todos los alojamientos (con información del propietario)
    @GetMapping("/getAll")
    public ResponseEntity<List<AlojamientoDTO>> getAllAlojamientos() {
        List<AlojamientoDTO> alojamientos = alojamientoServices.getAlojamientos();
        return ResponseEntity.ok(alojamientos);
    }

    // Consultar alojamiento por id (con información del propietario)
    @GetMapping("/{id}")
    public ResponseEntity<AlojamientoDTO> getAlojamientoById(@PathVariable Long id) {
        AlojamientoDTO dto = alojamientoServices.getAlojamientoById(id);
        if (dto != null) {
            return ResponseEntity.ok(dto);
        }
        return ResponseEntity.notFound().build();
    }

    // Consultar alojamientos por propietario (por ID)
    @GetMapping("/propietario/{userId}")
    public ResponseEntity<List<AlojamientoDTO>> getAlojamientosByPropietario(@PathVariable Long userId) {
        List<AlojamientoDTO> alojamientos = alojamientoServices.getAlojamientosByUsuario(userId);
        return ResponseEntity.ok(alojamientos);
    }

    // Consultar alojamientos por propietario (por email)
    @GetMapping("/propietario/email/{email}")
    public ResponseEntity<List<AlojamientoDTO>> getAlojamientosByPropietarioEmail(@PathVariable String email) {
        List<AlojamientoDTO> alojamientos = alojamientoServices.getAlojamientosByUsuarioEmail(email);
        return ResponseEntity.ok(alojamientos);
    }

    // Actualizar alojamiento (requiere verificación de propietario)
    @PutMapping("/update/{id}")
    public ResponseEntity<String> updateAlojamiento(
            @PathVariable Long id,
            @RequestBody AlojamientoDTO alojamientoDTO,
            @RequestParam(required = false) String emailPropietario) {

        String result;
        if (emailPropietario != null && !emailPropietario.trim().isEmpty()) {
            result = alojamientoServices.updateAlojamiento(id, alojamientoDTO, emailPropietario);
        } else {
            // Método deprecated sin verificación de propietario
            result = alojamientoServices.updateAlojamiento(id, alojamientoDTO);
        }

        return ResponseEntity.ok(result);
    }

    // Borrar alojamiento (requiere verificación de propietario)
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteAlojamiento(
            @PathVariable Long id,
            @RequestParam(required = false) String emailPropietario) {

        String result;
        if (emailPropietario != null && !emailPropietario.trim().isEmpty()) {
            result = alojamientoServices.deleteAlojamiento(id, emailPropietario);
        } else {
            // Método deprecated sin verificación de propietario
            result = alojamientoServices.deleteAlojamiento(id);
        }

        return ResponseEntity.ok(result);
    }

    // Endpoint para verificar si un usuario es propietario de un alojamiento
    @GetMapping("/{id}/es-propietario")
    public ResponseEntity<Boolean> esPropietario(
            @PathVariable Long id,
            @RequestParam String email) {

        AlojamientoDTO alojamiento = alojamientoServices.getAlojamientoById(id);
        if (alojamiento == null) {
            return ResponseEntity.notFound().build();
        }

        boolean esPropietario = alojamiento.esPropietario(email);
        return ResponseEntity.ok(esPropietario);
    }

    // Endpoint para obtener información básica del propietario de un alojamiento
    @GetMapping("/{id}/propietario")
    public ResponseEntity<String> getInfoPropietario(@PathVariable Long id) {
        AlojamientoDTO alojamiento = alojamientoServices.getAlojamientoById(id);
        if (alojamiento == null) {
            return ResponseEntity.notFound().build();
        }

        String info = String.format("Propietario: %s (%s)",
                alojamiento.getNombrePropietario(),
                alojamiento.getEmailPropietario());

        return ResponseEntity.ok(info);
    }
}
