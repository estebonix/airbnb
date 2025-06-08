package com.airbnb.airbnb.dto;

import java.sql.Date;

public class UsuarioDTO {
    private Long id;
    private String nombre;
    private String apellido;
    private String email;
    private String contraseña;
    private Date fechaNacimiento;
    private String telefono;
    private String es_superhost;
    private String calificacion_promedio;
    private String biografia;
    private String fecha_registro;

    public UsuarioDTO(Long id, String nombre, String apellido, String email, String contraseña, Date fechaNacimiento,
            String telefono, String es_superhost, String calificacion_promedio, String biografia,
            String fecha_registro) {
        this.id = id;
        this.nombre = nombre;
        this.apellido = apellido;
        this.email = email;
        this.contraseña = contraseña;
        this.fechaNacimiento = fechaNacimiento;
        this.telefono = telefono;
        this.es_superhost = es_superhost;
        this.calificacion_promedio = calificacion_promedio;
        this.biografia = biografia;
        this.fecha_registro = fecha_registro;
    }
    
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public String getApellido() {
        return apellido;
    }
    public void setApellido(String apellido) {
        this.apellido = apellido;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getContraseña() {
        return contraseña;
    }
    public void setContraseña(String contraseña) {
        this.contraseña = contraseña;
    }
    public Date getFechaNacimiento() {
        return fechaNacimiento;
    }
    public void setFechaNacimiento(Date fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }
    public String getTelefono() {
        return telefono;
    }
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
    public String getEs_superhost() {
        return es_superhost;
    }
    public void setEs_superhost(String es_superhost) {
        this.es_superhost = es_superhost;
    }
    public String getCalificacion_promedio() {
        return calificacion_promedio;
    }
    public void setCalificacion_promedio(String calificacion_promedio) {
        this.calificacion_promedio = calificacion_promedio;
    }
    public String getBiografia() {
        return biografia;
    }
    public void setBiografia(String biografia) {
        this.biografia = biografia;
    }
    public String getFecha_registro() {
        return fecha_registro;
    }
    public void setFecha_registro(String fecha_registro) {
        this.fecha_registro = fecha_registro;
    }

    
}
