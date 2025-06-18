<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${alojamiento.getTitulo()} - Airbnb</title>
    <link rel="stylesheet" href="/css/alojamiento.css">
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

                <!-- Seccion del anfitrion -->
                <section class="host-section">
                    <h3>Acerca del anfitrión</h3>
                    <div class="host-info">
                        <div class="host-avatar">
                            <img src="/img/default-avatar.jpg" 
                                alt="${(alojamiento.propietario.nombre)!'Anfitrión'}" 
                                class="host-avatar">
                        </div>
                        <div class="host-details">
                            <h4 class="host-name">
                                <#if alojamiento.propietario?? && alojamiento.propietario.nombre??>
                                    ${alojamiento.propietario.nombre}<#if alojamiento.propietario.apellido??> ${alojamiento.propietario.apellido}</#if>
                                <#else>
                                    Anfitrión
                                </#if>
                            </h4>
                            <div class="host-stats">
                                <#if alojamiento.propietario??>
                                    <div class="host-stat">
                                        <span class="stat-icon">📧</span>
                                        <span>Contacto verificado</span>
                                    </div>
                                    <div class="host-stat">
                                        <span class="stat-icon">⭐</span>
                                        <span>Anfitrión desde 
                                            <#if alojamiento.propietario.fecha_registro??>
                                                <#assign fechaStr = alojamiento.propietario.fecha_registro>
                                                <#if fechaStr?contains("-")>
                                                    ${fechaStr?substring(0, 4)}
                                                <#else>
                                                    2024
                                                </#if>
                                            <#else>
                                                2024
                                            </#if>
                                        </span>
                                    </div>
                                    <#if alojamiento.propietario.biografia?? && alojamiento.propietario.biografia?trim != "">
                                        <div class="host-bio">
                                            <p>${alojamiento.propietario.biografia}</p>
                                        </div>
                                    </#if>
                                <#else>
                                    <span class="no-host-info">Información del anfitrión no disponible</span>
                                </#if>
                            </div>
                        </div>
                    </div>
                    
                    <#if alojamiento.propietario?? && alojamiento.propietario.email??>
                        <div class="host-actions">
                            <button class="contact-host-btn" onclick="contactarAnfitrion('${alojamiento.propietario.email}')">
                                📩 Contactar anfitrión
                            </button>
                            
                            <div id="owner-actions" style="display: none;">
                                <button class="edit-listing-btn" onclick="editarAlojamiento(${alojamiento.id})">
                                    ✏️ Editar alojamiento
                                </button>
                                <button class="delete-listing-btn" onclick="eliminarAlojamiento(${alojamiento.id})">
                                    🗑️ Eliminar alojamiento
                                </button>
                            </div>
                        </div>
                    </#if>
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
    <script>
        // JavaScript para manejar las acciones del propietario
        document.addEventListener('DOMContentLoaded', function() {
        console.log('=== INICIALIZANDO PÁGINA DE ALOJAMIENTO ===');
        
        // Obtener emails de forma segura
        const currentUserEmail = localStorage.getItem('userEmail');
        const propietarioEmail = '${(alojamiento.propietario.email)!""}';
        
        console.log('Email usuario actual:', currentUserEmail);
        console.log('Email propietario:', propietarioEmail);
        
        // Solo proceder si ambos emails existen
        if (currentUserEmail && propietarioEmail && currentUserEmail === propietarioEmail) {
            console.log('✅ Usuario es propietario del alojamiento');
            
            // Mostrar opciones de propietario
            const ownerActions = document.getElementById('owner-actions');
            if (ownerActions) {
                ownerActions.style.display = 'block';
            }
            
            // Modificar botón de contacto
            const contactBtn = document.querySelector('.contact-host-btn');
            if (contactBtn) {
                contactBtn.textContent = '👤 Este es tu alojamiento';
                contactBtn.disabled = true;
                contactBtn.style.opacity = '0.6';
                contactBtn.style.cursor = 'not-allowed';
            }
        } else if (currentUserEmail && propietarioEmail) {
            console.log('ℹ️ Usuario no es propietario');
        } else {
            console.log('⚠️ Información de email incompleta');
        }
    });

    function contactarAnfitrion(email) {
        console.log('Contactando anfitrión:', email);
        
        if (!email || email.trim() === '') {
            alert('Email del anfitrión no disponible');
            return;
        }
        
        const subject = 'Consulta sobre: ${(alojamiento.titulo)!"alojamiento"}';
        const body = 'Hola, estoy interesado en tu alojamiento y me gustaría hacer una consulta.';
        const mailtoLink = `mailto:${(alojamiento.propietario.email)!"Sin email"}`;
        
        try {
            window.location.href = mailtoLink;
        } catch (error) {
            console.error('Error al abrir cliente de email:', error);
            alert('No se pudo abrir el cliente de email. Email: ' + email);
        }
    }

    function editarAlojamiento(id) {
        console.log('Editando alojamiento:', id);
        alert('Funcionalidad de edición en desarrollo');
    }

    function eliminarAlojamiento(id) {
        console.log('Eliminando alojamiento:', id);
        
        if (!confirm('¿Estás seguro de que quieres eliminar este alojamiento?')) {
            return;
        }
        
        const userEmail = localStorage.getItem('userEmail');
        if (!userEmail) {
            alert('Debes estar logueado para realizar esta acción');
            return;
        }
        
        console.log('Enviando solicitud de eliminación...');
        
        fetch(`/alojamiento/delete/${id}?emailPropietario=${encodeURIComponent(userEmail)}`, {
            method: 'DELETE'
        })
        .then(response => {
            console.log('Respuesta del servidor:', response.status);
            return response.text();
        })
        .then(result => {
            console.log('Resultado:', result);
            alert(result);
            if (result.includes('correctamente')) {
                console.log('Redirigiendo a página principal...');
                window.location.href = '/';
            }
        })
        .catch(error => {
            console.error('Error en eliminación:', error);
            alert('Error al eliminar el alojamiento: ' + error.message);
        });
    }

    // Función de debugging para verificar datos
    function debugAlojamientoData() {
        console.log('=== DEBUG: DATOS DEL ALOJAMIENTO ===');
        console.log('ID:', '${alojamiento.id!"NO_ID"}');
        console.log('Título:', '${(alojamiento.titulo)!"NO_TITULO"}');
        console.log('Propietario existe:', '${alojamiento.propietario??}');
        console.log('Email propietario:', '${(alojamiento.propietario.email)!"NO_EMAIL"}');
        console.log('Nombre propietario:', '${(alojamiento.propietario.nombre)!"NO_NOMBRE"}');
        console.log('Usuario actual:', localStorage.getItem('userEmail'));
    }
    </script>
</body>
</html>