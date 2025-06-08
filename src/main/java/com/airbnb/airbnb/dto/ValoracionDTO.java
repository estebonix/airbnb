package com.airbnb.airbnb.dto;

import java.sql.Date;

public class ValoracionDTO {
    private Integer id;
    private String codigo;
    private String descripcion;
    private UsuarioDTO usuario;
    private AlojamientoDTO alojamiento;
    private Integer puntuacion;
    private String comentario;
    private Integer limpieza;
    private Integer comunicacion;
    private Integer llegada;
    private Integer precision;
    private Integer ubicacion;
    private Integer calidad_precio;
    private Date fecha_valoracion;

    public ValoracionDTO(Integer id, String codigo, String descripcion, UsuarioDTO usuario,
            AlojamientoDTO alojamiento, Integer puntuacion, String comentario, Integer limpieza, Integer comunicacion,
            Integer llegada, Integer precision, Integer ubicacion, Integer calidad_precio, Date fecha_valoracion) {
        this.id = id;
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.usuario = usuario;
        this.alojamiento = alojamiento;
        this.puntuacion = puntuacion;
        this.comentario = comentario;
        this.limpieza = limpieza;
        this.comunicacion = comunicacion;
        this.llegada = llegada;
        this.precision = precision;
        this.ubicacion = ubicacion;
        this.calidad_precio = calidad_precio;
        this.fecha_valoracion = fecha_valoracion;
    }

    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
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
    public UsuarioDTO getUsuario() {
        return usuario;
    }
    public void setUsuario(UsuarioDTO usuario) {
        this.usuario = usuario;
    }
    public AlojamientoDTO getAlojamiento() {
        return alojamiento;
    }
    public void setAlojamiento(AlojamientoDTO alojamiento) {
        this.alojamiento = alojamiento;
    }
    public Integer getPuntuacion() {
        return puntuacion;
    }
    public void setPuntuacion(Integer puntuacion) {
        this.puntuacion = puntuacion;
    }
    public String getComentario() {
        return comentario;
    }
    public void setComentario(String comentario) {
        this.comentario = comentario;
    }
    public Integer getLimpieza() {
        return limpieza;
    }
    public void setLimpieza(Integer limpieza) {
        this.limpieza = limpieza;
    }
    public Integer getComunicacion() {
        return comunicacion;
    }
    public void setComunicacion(Integer comunicacion) {
        this.comunicacion = comunicacion;
    }
    public Integer getLlegada() {
        return llegada;
    }
    public void setLlegada(Integer llegada) {
        this.llegada = llegada;
    }
    public Integer getPrecision() {
        return precision;
    }
    public void setPrecision(Integer precision) {
        this.precision = precision;
    }
    public Integer getUbicacion() {
        return ubicacion;
    }
    public void setUbicacion(Integer ubicacion) {
        this.ubicacion = ubicacion;
    }
    public Integer getCalidad_precio() {
        return calidad_precio;
    }
    public void setCalidad_precio(Integer calidad_precio) {
        this.calidad_precio = calidad_precio;
    }
    public Date getFecha_valoracion() {
        return fecha_valoracion;
    }
    public void setFecha_valoracion(Date fecha_valoracion) {
        this.fecha_valoracion = fecha_valoracion;
    }


}
