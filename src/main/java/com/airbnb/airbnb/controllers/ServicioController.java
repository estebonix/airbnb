package com.airbnb.airbnb.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.airbnb.airbnb.dto.ServicioDTO;
import com.airbnb.airbnb.services.ServicioServices;



@RestController
@RequestMapping("/servicios")
public class ServicioController {

    @Autowired
    private ServicioServices servicioServices;
    
    @GetMapping("/{id}")
    public ServicioDTO getServicioByID(@PathVariable Long id) {
        return servicioServices.getServicioById(id);
    }

    @GetMapping
    public List<String> getServiciosByAlojamientoId(@RequestParam Long alojamientoId) {
        return servicioServices.getServiciosByAlojamientoId(alojamientoId);
    }
}
