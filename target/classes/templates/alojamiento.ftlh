<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${alojamiento.getTitulo()} - Airbnb</title>
    <link rel="stylesheet" href="http://localhost:8080/css/alojamiento.css">
</head>
<body>
    <div class="container">
        <!-- Navigation Buttons -->
        <div class="nav-buttons">
            <button class="back-button" onclick="window.history.back()">
                ← Volver atrás
            </button>
            <button class="edit-button" onclick="openEditModal()">
                ✏️ Editar
            </button>
        </div>

        <!-- Header Section -->
        <header class="header">
            <h1 class="property-title">${alojamiento.getTitulo()}</h1>
            <p class="property-location">📍 ${alojamiento.getCiudad()}, ${alojamiento.getPais()}</p>
            <div class="rating-section">
                <span>${alojamiento.getTipoAlojamiento()}</span>
            </div>
        </header>

        <!-- Main Content -->
        <div class="main-content">
            <div class="left-column">
                <!-- Image Gallery -->
                <div class="image-gallery">
                    <#list imagenes as imagen>
                        <#if imagen.getEs_principal() == 1>
                            <img src="${imagen.getUrl()}" alt="${imagen.getDescripcion()}" class="main-image">
                        </#if>
                    </#list>
                    
                    <div class="thumbnail-grid">
                        <#list imagenes as imagen>
                            <#if (imagen.getEs_principal() != 1)>
                                <img src="${imagen.getUrl()}" alt="${imagen.getDescripcion()}" class="thumbnail">
                            </#if>
                        </#list>
                    </div>
                </div>

                <!-- Description -->
                <section class="description">
                    <h2>Acerca de este espacio</h2>
                    <p>${alojamiento.getDescripcion()}</p>
                </section>

                <!-- Servicios -->
                <section class="amenities">
                    <h3>¿Qué ofrece este lugar?</h3>
                    <div class="amenities-grid">
                        <#list servicios as servicio>
                            <div class="amenity-item">
                                <span class="amenity-icon"><img src="/icons/${servicio.getIcono()}.png"></span>
                                <span>${servicio.getDescripcion()}</span>
                            </div>
                        </#list>
                    </div>
                </section>
            </div>

            <!-- Booking Card -->
            <div class="right-column">
                <div class="booking-card">
                    <div class="price-section">
                        <span class="price">${alojamiento.getPrecioNoche()}€</span>
                        <span class="price-period"> noche</span>
                    </div>

                    <form class="booking-form">
                        <div class="form-group">
                            <label class="form-label">Fechas</label>
                            <div class="date-inputs">
                                <input type="date" class="form-input" name="checkin" value="" required>
                                <input type="date" class="form-input" name="checkout" value="" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Huéspedes</label>
                            <select class="form-input" name="guests">
                                <#list 1..alojamiento.getCapacidad() as num>
                                    <option value="${num}" class="form-option"></option>
                                </#list>
                            </select>
                        </div>

                        <button type="submit" class="book-button">Reservar</button>
                    </form>

                    <div class="price-breakdown">
                        <div class="price-row">
                            <span>${alojamiento.getPrecioNoche()}€ x <#--${nights!0}--> noches</span>
                            <span>${alojamiento.getPrecioNoche()}€</span>
                        </div>
                        <div class="price-row">
                            <span>Tarifa de limpieza</span>
                            <span>€<#--${cleaningFee!0}--></span> <!-- POR HACER -->
                        </div>
                        <div class="price-row">
                            <span>Tarifa de servicio</span>
                            <span>€<#--${serviceFee!0}--></span> <!-- POR HACER --> 
                        </div>
                        <div class="price-row total-price">
                            <span>Total</span>
                            <span>${alojamiento.getPrecioNoche()}€</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>