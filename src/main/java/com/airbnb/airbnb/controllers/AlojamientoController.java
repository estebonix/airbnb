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

    // Crear alojamiento
    @PostMapping("/add")
    public ResponseEntity<String> addAlojamiento(@RequestParam String titulo, @RequestParam String descripcion, @RequestParam String tipoAlojamiento, @RequestParam Integer capacidad, @RequestParam Integer habitaciones, @RequestParam Integer camas, @RequestParam Integer banos, @RequestParam Double precioNoche, @RequestParam String direccion, @RequestParam String direccionDescripcion, @RequestParam String ciudad, @RequestParam String pais, @RequestParam String codigoPostal) {
        
        AlojamientoDTO alojamiento = new AlojamientoDTO(banos, camas, capacidad, ciudad, codigoPostal, descripcion, direccion, direccionDescripcion, null, habitaciones, null, pais, precioNoche, tipoAlojamiento, titulo); 

        String result = alojamientoServices.addAlojamiento(alojamiento);
        return ResponseEntity.ok(result);
    }

    // Consultar todos los alojamientos
    @GetMapping("/getAll")
    public ResponseEntity<List<AlojamientoDTO>> getAllAlojamientos() {
        return ResponseEntity.ok(alojamientoServices.getAlojamientos());
    }

    // Consultar alojamiento por id
    @GetMapping("/{id}")
    public ResponseEntity<AlojamientoDTO> getAlojamientoById(@PathVariable Long id) {
        AlojamientoDTO dto = alojamientoServices.getAlojamientoById(id);
        if (dto != null) return ResponseEntity.ok(dto);
        return ResponseEntity.notFound().build();
    }
    
    // Actualizar alojamiento
    @PutMapping("/update/{id}")
    public ResponseEntity<String> updateAlojamiento(@PathVariable Long id, @RequestBody AlojamientoDTO alojamientoDTO) {
         
        String result = alojamientoServices.updateAlojamiento(id, alojamientoDTO);
        return ResponseEntity.ok(result);
    }

    // Borrar alojamiento
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteAlojamiento(@PathVariable Long id) {
        
        String result = alojamientoServices.deleteAlojamiento(id);
        return ResponseEntity.ok(result);
    }
}