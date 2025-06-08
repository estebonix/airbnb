package com.airbnb.airbnb.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.airbnb.airbnb.dto.AlojamientoDTO;
import com.airbnb.airbnb.dto.ImagenDTO;
import com.airbnb.airbnb.dto.ServicioDTO;
import com.airbnb.airbnb.services.AlojamientoServices;
import com.airbnb.airbnb.services.ImagenesAlojamientoService;
import com.airbnb.airbnb.services.ServicioServices;
import com.airbnb.airbnb.services.ValoracionesAlojamientoService;

@Controller
@RequestMapping("/")
public class MainController {

    @Autowired
    private AlojamientoServices alojamientoServices;
    
    @Autowired
    private ServicioServices servicioServices;
    
    @Autowired
    private ValoracionesAlojamientoService valoracionesServices;

    @Autowired
    private ImagenesAlojamientoService imagenesAlojamientoService;

    @GetMapping
    public String mainPage() {
        return "index";
    }

    @GetMapping("alojamiento/{id}/page")
    public String alojamientoPage(@PathVariable Long id, Model model) {
        AlojamientoDTO alojamiento = alojamientoServices.getAlojamientoById(id);
        model.addAttribute( "alojamiento", alojamiento);
        List<ServicioDTO> servicios = servicioServices.getServiciosByAlojamientoId2(id);
        model.addAttribute("servicios", servicios);
        Double valoracion = valoracionesServices.getValoracionMedia(id).getBody();
        model.addAttribute("valoracion", valoracion);
        List<ImagenDTO> imagenes = imagenesAlojamientoService.getImagenesByAlojamientoId(id);
        model.addAttribute("imagenes", imagenes);
        return "alojamiento";
    }
        
}
