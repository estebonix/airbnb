package com.airbnb.airbnb.controllers;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

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
import org.springframework.web.multipart.MultipartFile;

import com.airbnb.airbnb.dto.AlojamientoDTO;
import com.airbnb.airbnb.services.AlojamientoServices;

@RestController
@RequestMapping("/alojamiento")
public class AlojamientoController {

    @Autowired
    private AlojamientoServices alojamientoServices;

    // Directorio donde se guardarán las imágenes
    private final String UPLOAD_DIR = "src/main/resources/static/uploads/images/";

    // Crear alojamiento con imágenes y servicios
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
            @RequestParam(required = false) String direccionDescripcion,
            @RequestParam String ciudad,
            @RequestParam String pais,
            @RequestParam(required = false) String codigoPostal,
            @RequestParam String emailPropietario,
            @RequestParam(required = false) String servicios,
            @RequestParam(required = false) MultipartFile[] imagenes) {

        System.out.println("=== INICIANDO CREACIÓN DE ALOJAMIENTO ===");
        System.out.println("Título: " + titulo);
        System.out.println("Email propietario: " + emailPropietario);
        System.out.println("Servicios: " + servicios);
        System.out.println("Número de imágenes: " + (imagenes != null ? imagenes.length : 0));

        try {
            // Crear el objeto alojamiento
            AlojamientoDTO alojamiento = new AlojamientoDTO(null, titulo, descripcion, tipoAlojamiento,
                    capacidad, habitaciones, camas, banos, precioNoche, direccion, 
                    direccionDescripcion != null ? direccionDescripcion : direccion,
                    ciudad, pais, codigoPostal, null, null);

            // Crear el alojamiento y obtener su ID
            System.out.println("Creando alojamiento en la base de datos...");
            Long alojamientoId = alojamientoServices.addAlojamientoConId(alojamiento, emailPropietario);
            
            if (alojamientoId == null) {
                return ResponseEntity.badRequest().body("Error al crear el alojamiento en la base de datos");
            }
            
            System.out.println("Alojamiento creado con ID: " + alojamientoId);

            // Procesar y guardar imágenes si existen
            boolean imagenesProcessedSuccessfully = false;
            if (imagenes != null && imagenes.length > 0) {
                try {
                    procesarImagenes(imagenes, alojamientoId);
                    imagenesProcessedSuccessfully = true;
                } catch (Exception e) {
                    System.err.println("Error procesando imágenes: " + e.getMessage());
                    e.printStackTrace();
                    // Crear imagen por defecto si falla el procesamiento
                    crearImagenPorDefecto(alojamientoId);
                }
            }
            
            // Si no hay imágenes o falló el procesamiento, crear imagen por defecto
            if (!imagenesProcessedSuccessfully) {
                crearImagenPorDefecto(alojamientoId);
            }

            // Procesar y guardar servicios si existen
            if (servicios != null && !servicios.trim().isEmpty()) {
                try {
                    System.out.println("Procesando servicios: " + servicios);
                    procesarServicios(servicios, alojamientoId);
                } catch (Exception e) {
                    System.err.println("Error procesando servicios: " + e.getMessage());
                    e.printStackTrace();
                    // No fallar si hay error con servicios, solo registrar el error
                }
            }

            System.out.println("=== ALOJAMIENTO CREADO EXITOSAMENTE ===");
            return ResponseEntity.ok("Alojamiento creado correctamente con ID: " + alojamientoId);

        } catch (Exception e) {
            System.err.println("=== ERROR EN CREACIÓN DE ALOJAMIENTO ===");
            e.printStackTrace();
            return ResponseEntity.badRequest().body("Error al crear el alojamiento: " + e.getMessage());
        }
    }

    // Procesar imágenes subidas
    private void procesarImagenes(MultipartFile[] imagenes, Long alojamientoId) throws IOException {
        System.out.println("Procesando " + imagenes.length + " imágenes para alojamiento ID: " + alojamientoId);
        
        // Crear directorio si no existe
        Path uploadPath = Paths.get(UPLOAD_DIR);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
            System.out.println("Directorio creado: " + uploadPath.toAbsolutePath());
        }

        boolean esPrimera = true;
        int orden = 1;

        for (MultipartFile imagen : imagenes) {
            if (!imagen.isEmpty()) {
                System.out.println("Procesando imagen: " + imagen.getOriginalFilename() + " (Tamaño: " + imagen.getSize() + " bytes)");
                
                // Validar tipo de archivo
                String contentType = imagen.getContentType();
                if (contentType == null || !contentType.startsWith("image/")) {
                    System.out.println("Saltando archivo no válido: " + imagen.getOriginalFilename() + " (Tipo: " + contentType + ")");
                    continue; // Saltar archivos que no sean imágenes
                }

                try {
                    // Generar nombre único para el archivo
                    String originalFilename = imagen.getOriginalFilename();
                    String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
                    String uniqueFilename = UUID.randomUUID().toString() + fileExtension;

                    // Guardar archivo físicamente
                    Path destinationFile = uploadPath.resolve(uniqueFilename);
                    Files.copy(imagen.getInputStream(), destinationFile, StandardCopyOption.REPLACE_EXISTING);
                    System.out.println("Archivo guardado en: " + destinationFile.toAbsolutePath());

                    // Guardar referencia en base de datos
                    String urlImagen = "/uploads/images/" + uniqueFilename;
                    String descripcionImagen = "Imagen del alojamiento - " + originalFilename;
                    int esPrincipal = esPrimera ? 1 : 0;

                    System.out.println("Insertando en BD: URL=" + urlImagen + ", Principal=" + esPrincipal + ", Orden=" + orden);
                    alojamientoServices.insertarImagen(alojamientoId, descripcionImagen, urlImagen, esPrincipal, orden);

                    esPrimera = false;
                    orden++;
                    
                } catch (Exception e) {
                    System.err.println("Error procesando imagen " + imagen.getOriginalFilename() + ": " + e.getMessage());
                    e.printStackTrace();
                    // Continuar con la siguiente imagen en lugar de fallar completamente
                }
            }
        }
        
        System.out.println("Finalizado procesamiento de imágenes. Total procesadas: " + (orden - 1));
    }

    // Crear imagen por defecto si no se suben imágenes
    private void crearImagenPorDefecto(Long alojamientoId) {
        System.out.println("Creando imagen por defecto para alojamiento ID: " + alojamientoId);
        try {
            String urlImagenDefecto = "/img/default-property.jpg";
            String descripcionDefecto = "Imagen por defecto del alojamiento";
            alojamientoServices.insertarImagen(alojamientoId, descripcionDefecto, urlImagenDefecto, 1, 1);
            System.out.println("Imagen por defecto creada correctamente");
        } catch (Exception e) {
            System.err.println("Error al crear imagen por defecto: " + e.getMessage());
            e.printStackTrace();
            // No lanzar excepción aquí para no bloquear la creación del alojamiento
        }
    }

    // Procesar servicios/comodidades
    private void procesarServicios(String servicios, Long alojamientoId) {
        if (servicios == null || servicios.trim().isEmpty()) {
            return;
        }

        // Dividir los servicios por comas
        String[] serviciosArray = servicios.split(",");
        
        for (String servicio : serviciosArray) {
            String servicioLimpio = servicio.trim();
            if (!servicioLimpio.isEmpty()) {
                // Buscar o crear el servicio y asociarlo al alojamiento
                alojamientoServices.asociarServicio(alojamientoId, servicioLimpio);
            }
        }
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