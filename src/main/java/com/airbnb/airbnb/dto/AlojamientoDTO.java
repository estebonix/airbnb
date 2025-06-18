package com.airbnb.airbnb.dto;

import java.sql.Date;

public class AlojamientoDTO {

    private Long id;
    private String titulo;
    private String descripcion;
    private String tipoAlojamiento;
    private Integer capacidad;
    private Integer habitaciones;
    private Integer camas;
    private Integer banos;
    private Double precioNoche;
    private String direccion;
    private String direccionDescripcion;
    private String ciudad;
    private String pais;
    private String codigoPostal;
    private Date fechaRegistro;
    private UsuarioDTO propietario; // Objeto completo del propietario

    // Constructor principal con UsuarioDTO completo
    public AlojamientoDTO(Long id, String titulo, String descripcion, String tipoAlojamiento,
            Integer capacidad, Integer habitaciones, Integer camas, Integer banos,
            Double precioNoche, String direccion, String direccionDescripcion,
            String ciudad, String pais, String codigoPostal, Date fechaRegistro,
            UsuarioDTO propietario) {
        this.id = id;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.tipoAlojamiento = tipoAlojamiento;
        this.capacidad = capacidad;
        this.habitaciones = habitaciones;
        this.camas = camas;
        this.banos = banos;
        this.precioNoche = precioNoche;
        this.direccion = direccion;
        this.direccionDescripcion = direccionDescripcion;
        this.ciudad = ciudad;
        this.pais = pais;
        this.codigoPostal = codigoPostal;
        this.fechaRegistro = fechaRegistro;
        this.propietario = propietario;
    }

    // Constructor de compatibilidad con orden original (deprecated)
    @Deprecated
    public AlojamientoDTO(Integer banos, Integer camas, Integer capacidad, String ciudad, String codigoPostal,
            String descripcion, String direccion, String direccionDescripcion, Date fechaRegistro,
            Integer habitaciones, Long id, String pais, Double precioNoche, String tipoAlojamiento,
            String titulo, Long idUsuario) {
        this.banos = banos;
        this.camas = camas;
        this.capacidad = capacidad;
        this.ciudad = ciudad;
        this.codigoPostal = codigoPostal;
        this.descripcion = descripcion;
        this.direccion = direccion;
        this.direccionDescripcion = direccionDescripcion;
        this.fechaRegistro = fechaRegistro;
        this.habitaciones = habitaciones;
        this.id = id;
        this.pais = pais;
        this.precioNoche = precioNoche;
        this.tipoAlojamiento = tipoAlojamiento;
        this.titulo = titulo;
        // Propietario se establecerá por separado
        this.propietario = null;
    }

    // Constructor sin propietario (deprecated)
    @Deprecated
    public AlojamientoDTO(Integer banos, Integer camas, Integer capacidad, String ciudad, String codigoPostal,
            String descripcion, String direccion, String direccionDescripcion, Date fechaRegistro,
            Integer habitaciones, Long id, String pais, Double precioNoche, String tipoAlojamiento,
            String titulo) {
        this(banos, camas, capacidad, ciudad, codigoPostal, descripcion, direccion, direccionDescripcion,
                fechaRegistro, habitaciones, id, pais, precioNoche, tipoAlojamiento, titulo, (Long) null);
    }

    // Getters y setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getTipoAlojamiento() {
        return tipoAlojamiento;
    }

    public void setTipoAlojamiento(String tipoAlojamiento) {
        this.tipoAlojamiento = tipoAlojamiento;
    }

    public Integer getCapacidad() {
        return capacidad;
    }

    public void setCapacidad(Integer capacidad) {
        this.capacidad = capacidad;
    }

    public Integer getHabitaciones() {
        return habitaciones;
    }

    public void setHabitaciones(Integer habitaciones) {
        this.habitaciones = habitaciones;
    }

    public Integer getCamas() {
        return camas;
    }

    public void setCamas(Integer camas) {
        this.camas = camas;
    }

    public Integer getBanos() {
        return banos;
    }

    public void setBanos(Integer banos) {
        this.banos = banos;
    }

    public Double getPrecioNoche() {
        return precioNoche;
    }

    public void setPrecioNoche(Double precioNoche) {
        this.precioNoche = precioNoche;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getDireccionDescripcion() {
        return direccionDescripcion;
    }

    public void setDireccionDescripcion(String direccionDescripcion) {
        this.direccionDescripcion = direccionDescripcion;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getCodigoPostal() {
        return codigoPostal;
    }

    public void setCodigoPostal(String codigoPostal) {
        this.codigoPostal = codigoPostal;
    }

    public Date getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Date fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public UsuarioDTO getPropietario() {
        return propietario;
    }

    public void setPropietario(UsuarioDTO propietario) {
        this.propietario = propietario;
    }

    // Métodos de conveniencia para obtener información del propietario
    public String getNombrePropietario() {
        if (propietario != null) {
            String nombre = "";
            if (propietario.getNombre() != null) {
                nombre += propietario.getNombre();
            }
            if (propietario.getApellido() != null) {
                if (!nombre.isEmpty()) {
                    nombre += " ";
                }
                nombre += propietario.getApellido();
            }
            return nombre.isEmpty() ? "Propietario desconocido" : nombre;
        }
        return "Sin propietario";
    }

    public String getEmailPropietario() {
        return propietario != null ? propietario.getEmail() : null;
    }

    public Long getIdPropietario() {
        return propietario != null ? propietario.getId() : null;
    }

    // Método para verificar si el usuario es el propietario
    public boolean esPropietario(Long userId) {
        return propietario != null && propietario.getId() != null && propietario.getId().equals(userId);
    }

    public boolean esPropietario(String userEmail) {
        return propietario != null && propietario.getEmail() != null && propietario.getEmail().equals(userEmail);
    }
}
