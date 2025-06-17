package com.airbnb.airbnb.controllers;

import java.sql.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.airbnb.airbnb.dto.UsuarioDTO;
import com.airbnb.airbnb.services.UsuarioServices;

@RestController
@RequestMapping("/usuario")
public class UsuarioController {

    @Autowired
    private UsuarioServices usuarioServices;

    // Registrar nuevo usuario
    @PostMapping("/register")
    public ResponseEntity<String> registrarUsuario(
            @RequestParam String nombre,
            @RequestParam String apellido,
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String fechaNacimiento,
            @RequestParam(required = false) String telefono,
            @RequestParam(required = false) String biografia) {
        
        try {
            // Convertir fecha de String a Date
            Date fechaNac = Date.valueOf(fechaNacimiento);
            
            // Crear objeto UsuarioDTO
            UsuarioDTO nuevoUsuario = new UsuarioDTO(
                null, nombre, apellido, email, password, fechaNac, telefono, biografia, null
            );
            
            // Intentar crear el usuario
            UsuarioDTO usuarioCreado = usuarioServices.crearUsuario(nuevoUsuario);
            
            if (usuarioCreado != null) {
                return ResponseEntity.ok("Usuario registrado exitosamente");
            } else {
                return ResponseEntity.badRequest().body("Error al registrar el usuario");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    // Iniciar sesión
    @PostMapping("/login")
    public ResponseEntity<UsuarioDTO> iniciarSesion(
            @RequestParam String email,
            @RequestParam String password) {
        
        try {
            UsuarioDTO usuario = usuarioServices.autenticarUsuario(email, password);
            
            if (usuario != null) {
                return ResponseEntity.ok(usuario);
            } else {
                return ResponseEntity.badRequest().build();
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    // Obtener usuario por ID
    @GetMapping("/{id}")
    public ResponseEntity<UsuarioDTO> obtenerUsuario(@PathVariable Long id) {
        UsuarioDTO usuario = usuarioServices.getAnfitrionById(id);
        
        if (usuario != null) {
            return ResponseEntity.ok(usuario);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // Obtener usuario por email
    @GetMapping("/email/{email}")
    public ResponseEntity<UsuarioDTO> obtenerUsuarioPorEmail(@PathVariable String email) {
        UsuarioDTO usuario = usuarioServices.getUsuarioPorEmail(email);
        
        if (usuario != null) {
            return ResponseEntity.ok(usuario);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}