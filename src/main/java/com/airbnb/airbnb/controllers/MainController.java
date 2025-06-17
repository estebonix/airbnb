package com.airbnb.airbnb.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.airbnb.airbnb.dto.AlojamientoDTO;
import com.airbnb.airbnb.dto.ImagenDTO;
import com.airbnb.airbnb.dto.ServicioDTO;
import com.airbnb.airbnb.dto.UsuarioDTO;
import com.airbnb.airbnb.services.AlojamientoServices;
import com.airbnb.airbnb.services.ImagenesAlojamientoService;
import com.airbnb.airbnb.services.ServicioServices;
import com.airbnb.airbnb.services.UsuarioServices;
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

    @Autowired
    private UsuarioServices usuarioServices;

    @GetMapping
    public String mainPage() {
        return "index";
    }

    @GetMapping("alojamiento/{id}/page")
    public String alojamientoPage(@PathVariable Long id, Model model) {
        AlojamientoDTO alojamiento = alojamientoServices.getAlojamientoById(id);
        model.addAttribute("alojamiento", alojamiento);
        List<ServicioDTO> servicios = servicioServices.getServiciosByAlojamientoId2(id);
        model.addAttribute("servicios", servicios);
        Double valoracion = valoracionesServices.getValoracionMedia(id).getBody();
        model.addAttribute("valoracion", valoracion);
        List<ImagenDTO> imagenes = imagenesAlojamientoService.getImagenesByAlojamientoId(id);
        model.addAttribute("imagenes", imagenes);
        return "alojamiento";
    }

    @GetMapping("login")
    public String loginPage() {
        return "redirect:/login.html";
    }

    @GetMapping("profile")
    public String profilePage(@RequestParam(required = false) Long userId, Model model) {
        if (userId != null) {
            UsuarioDTO usuario = usuarioServices.getAnfitrionById(userId);
            if (usuario != null) {
                model.addAttribute("usuario", usuario);
                model.addAttribute("name", usuario.getNombre() + " " + usuario.getApellido());
                model.addAttribute("email", usuario.getEmail());
                model.addAttribute("telefono", usuario.getTelefono());
                model.addAttribute("biografia", usuario.getBiografia());
                model.addAttribute("fechaRegistro", usuario.getFecha_registro());
                
                // Formatear fecha de nacimiento si existe
                if (usuario.getFechaNacimiento() != null) {
                    model.addAttribute("fechaNacimiento", usuario.getFechaNacimiento().toString());
                }
            }
        }
        return "profile";
    }   
}