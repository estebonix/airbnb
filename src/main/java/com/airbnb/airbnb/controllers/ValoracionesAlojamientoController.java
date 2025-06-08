package com.airbnb.airbnb.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.airbnb.airbnb.dto.ValoracionDTO;
import com.airbnb.airbnb.services.ValoracionesAlojamientoService;



@RestController
@RequestMapping("/alojamiento/valoraciones")
public class ValoracionesAlojamientoController {

    @Autowired
    private ValoracionesAlojamientoService valoracionesAlojamientoService;
    
    @GetMapping("/getAll")
    public String getAllValoraciones() {
        // TODO: HACER ESTO
        return new String();
    }
    
    @GetMapping("/get/{id}")
    public ResponseEntity<ValoracionDTO> getValoracion(@PathVariable Integer id) {
        return valoracionesAlojamientoService.getValoracion(id);
    }

    @GetMapping("/media/{alojamiento_id}")
    public ResponseEntity<Double> getValoracionMedia(@PathVariable Long alojamiento_id) {
        return valoracionesAlojamientoService.getValoracionMedia(alojamiento_id);
    }
    
}