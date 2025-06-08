package com.airbnb.airbnb.dto;

public class ImagenDTO {
    private Long id;
    private String descripcion;
    private AlojamientoDTO alojamiento;
    private String url;
    private Integer es_principal;
    private Integer orden;

    public ImagenDTO(AlojamientoDTO alojamiento, String descripcion, Integer es_principal, Long id, Integer orden, String url) {
        this.alojamiento = alojamiento;
        this.descripcion = descripcion;
        this.es_principal = es_principal;
        this.id = id;
        this.orden = orden;
        this.url = url;
    }
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public String getDescripcion() {
        return descripcion;
    }
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    public AlojamientoDTO getAlojamiento() {
        return alojamiento;
    }
    public void setAlojamiento(AlojamientoDTO alojamiento) {
        this.alojamiento = alojamiento;
    }
    public String getUrl() {
        return url;
    }
    public void setUrl(String url) {
        this.url = url;
    }
    public Integer getEs_principal() {
        return es_principal;
    }
    public void setEs_principal(Integer es_principal) {
        this.es_principal = es_principal;
    }
    public Integer getOrden() {
        return orden;
    }
    public void setOrden(Integer orden) {
        this.orden = orden;
    }


}

