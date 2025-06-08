package com.airbnb.airbnb.dto;

public class ServicioDTO {
    private Long id;
    private String codigo;
    private String descripcion;
    private String icono;

    public ServicioDTO(Long id, String codigo, String descripcion, String icono) {
        this.id = id;
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.icono = icono;
    }
    
    public String getIcono() {
        return icono;
    }

    public void setIcono(String icono) {
        this.icono = icono;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
}
