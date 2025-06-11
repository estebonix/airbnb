package com.airbnb.airbnb.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.airbnb.airbnb.services.ImagenesAlojamientoService;

@RestController
@RequestMapping("/alojamiento/imagenes")
public class ImagenesAlojamientoController {

    @Autowired
    private ImagenesAlojamientoService imagenesAlojamientoService;

    @GetMapping("/mainImagen/{id}")
    public ResponseEntity<String> getMainImagen(@PathVariable Integer id) {
        return imagenesAlojamientoService.getMainImagen(id);
    }

}
