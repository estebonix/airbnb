package com.airbnb.airbnb.controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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
        try {
            // Obtener alojamiento
            AlojamientoDTO alojamiento = alojamientoServices.getAlojamientoById(id);
            if (alojamiento == null) {
                model.addAttribute("error", "Alojamiento no encontrado");
                return "error";
            }
            model.addAttribute("alojamiento", alojamiento);
            
            // Obtener servicios
            List<ServicioDTO> servicios = servicioServices.getServiciosByAlojamientoId2(id);
            model.addAttribute("servicios", servicios != null ? servicios : new ArrayList<>());
            
            // Obtener valoración
            try {
                ResponseEntity<Double> valoracionResponse = valoracionesServices.getValoracionMedia(id);
                Double valoracion = valoracionResponse.getBody();
                model.addAttribute("valoracion", valoracion != null ? valoracion : 0.0);
            } catch (Exception e) {
                System.err.println("Error al obtener valoración: " + e.getMessage());
                model.addAttribute("valoracion", 0.0);
            }
            
            // Obtener imágenes
            try {
                List<ImagenDTO> imagenes = imagenesAlojamientoService.getImagenesByAlojamientoId(id);
                model.addAttribute("imagenes", imagenes != null ? imagenes : new ArrayList<>());
            } catch (Exception e) {
                System.err.println("Error al obtener imágenes: " + e.getMessage());
                model.addAttribute("imagenes", new ArrayList<>());
            }
            
            return "alojamiento";
            
        } catch (Exception e) {
            System.err.println("Error en alojamientoPage: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error al cargar el alojamiento: " + e.getMessage());
            return "error";
        }
    }

    @GetMapping("login")
    public String loginPage() {
        return "redirect:/login.html";
    }

    @GetMapping("crear-alojamiento")
    public String crearAlojamientoPage() {
        return "crear-alojamiento";
    }

    @GetMapping("profile")
    public String profilePage(@RequestParam(required = false) String email, Model model) {
        try {
            System.out.println("=== PROFILE: Iniciando carga de perfil ===");
            // Si no viene email por parámetro, mostrar página con JavaScript para obtenerlo
            if (email == null || email.trim().isEmpty()) {
                System.out.println("No hay email en parámetros, mostrando página con JS");
                model.addAttribute("needsEmailFromJS", true);
                return "profile";
            }
            
            System.out.println("Email recibido: " + email);
            
            // Buscar usuario por email
            UsuarioDTO usuario = usuarioServices.getUsuarioPorEmail(email);

            if (usuario == null) {
                System.out.println("Usuario no encontrado para email: " + email);
                model.addAttribute("error", "Usuario no encontrado");
                model.addAttribute("needsEmailFromJS", true);
                return "profile";
            }

            System.out.println("Usuario encontrado: " + usuario.getNombre() + " " + usuario.getApellido());

            // Pasar datos del usuario al template
            model.addAttribute("usuario", usuario);

            // Nombre completo
            String nombreCompleto = "";
            if (usuario.getNombre() != null && !usuario.getNombre().trim().isEmpty()) {
                nombreCompleto += usuario.getNombre();
            }
            if (usuario.getApellido() != null && !usuario.getApellido().trim().isEmpty()) {
                if (!nombreCompleto.isEmpty()) {
                    nombreCompleto += " ";
                }
                nombreCompleto += usuario.getApellido();
            }
            if (nombreCompleto.isEmpty()) {
                nombreCompleto = "Usuario";
            }

            model.addAttribute("nombreCompleto", nombreCompleto);
            model.addAttribute("email", usuario.getEmail());
            model.addAttribute("telefono", usuario.getTelefono());
            model.addAttribute("biografia", usuario.getBiografia());
            // Formatear fecha de nacimiento
            if (usuario.getFechaNacimiento() != null) {
                model.addAttribute("fechaNacimiento", usuario.getFechaNacimiento());
                System.out.println("Fecha nacimiento agregada: " + usuario.getFechaNacimiento());
            }
            
            // Formatear fecha de registro - manejar como String
            if (usuario.getFecha_registro() != null && !usuario.getFecha_registro().trim().isEmpty()) {
                try {
                    // Si viene como timestamp, extraer solo el año
                    String fechaRegistroStr = usuario.getFecha_registro();
                    if (fechaRegistroStr.contains("-")) {
                        String año = fechaRegistroStr.substring(0, 4);
                        model.addAttribute("añoRegistro", año);
                        System.out.println("Año de registro extraído: " + año);
                    } else {
                        model.addAttribute("añoRegistro", "2024");
                    }
                } catch (Exception e) {
                    System.err.println("Error procesando fecha de registro: " + e.getMessage());
                    model.addAttribute("añoRegistro", "2024");
                }
            } else {
                model.addAttribute("añoRegistro", "2024");
            }

            // Calcular completitud del perfil
            int completitud = 0;
            if (usuario.getNombre() != null && !usuario.getNombre().trim().isEmpty()) {
                completitud += 20;
            }
            if (usuario.getApellido() != null && !usuario.getApellido().trim().isEmpty()) {
                completitud += 20;
            }
            if (usuario.getEmail() != null && !usuario.getEmail().trim().isEmpty()) {
                completitud += 20;
            }
            if (usuario.getTelefono() != null && !usuario.getTelefono().trim().isEmpty()) {
                completitud += 20;
            }
            if (usuario.getBiografia() != null && !usuario.getBiografia().trim().isEmpty()) {
                completitud += 20;
            }

            model.addAttribute("completitudPerfil", completitud);
            model.addAttribute("needsEmailFromJS", false);

            System.out.println("=== PROFILE: Datos cargados correctamente ===");
            System.out.println("- Nombre completo: " + nombreCompleto);
            System.out.println("- Email: " + usuario.getEmail());
            System.out.println("- Completitud: " + completitud + "%");

            return "profile";

        } catch (Exception e) {
            System.err.println("=== ERROR en profilePage ===");
            e.printStackTrace();
            model.addAttribute("error", "Error interno del servidor");
            model.addAttribute("needsEmailFromJS", true);
            return "profile";
        }
    }   
}