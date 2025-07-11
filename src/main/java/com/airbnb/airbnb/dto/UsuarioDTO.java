package com.airbnb.airbnb.dto;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class UsuarioDTO {
    private Long id;
    private String nombre;
    private String apellido;
    private String email;
    private String contraseña;
    private Date fechaNacimiento;
    private String telefono;
    private String biografia;
    private String fecha_registro;

    // Constructor por defecto (necesario para Jackson)
    public UsuarioDTO() {
    }

    @JsonCreator
    public UsuarioDTO(
            @JsonProperty("id") Long id,
            @JsonProperty("nombre") String nombre,
            @JsonProperty("apellido") String apellido,
            @JsonProperty("email") String email,
            @JsonProperty("contraseña") String contraseña,
            @JsonProperty("fechaNacimiento") Date fechaNacimiento,
            @JsonProperty("telefono") String telefono,
            @JsonProperty("biografia") String biografia,
            @JsonProperty("fecha_registro") String fecha_registro) {
        this.id = id;
        this.nombre = nombre;
        this.apellido = apellido;
        this.email = email;
        this.contraseña = contraseña;
        this.fechaNacimiento = fechaNacimiento;
        this.telefono = telefono;
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