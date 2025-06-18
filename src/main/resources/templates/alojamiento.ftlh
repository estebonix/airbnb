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
        </div>

        <!-- Header Section -->
        <header class="header">
            <h1 class="property-title">${alojamiento.getTitulo()}</h1>
            <p class="property-location">📍 ${alojamiento.getCiudad()}, ${alojamiento.getPais()}</p>
            <div class="rating-section">
                <span>${alojamiento.getTipoAlojamiento()}</span>
                <div class="rating">
                    <span class="star">⭐</span>
                    <span class="rating-text">${valoracion}</span>
                </div>
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
                                <img src="${imagen.getUrl()}" alt="${imagen.getDescripcion()}" class="thumbnail" 
                                     onclick="changeMainImage('${imagen.getUrl()}')">
                            </#if>
                        </#list>
                    </div>
                </div>

                <!-- Description -->
                <section class="description">
                    <h2>Acerca de este espacio</h2>
                    <p>${alojamiento.getDescripcion()}</p>
                    
                    <!-- Detalles del alojamiento -->
                    <div class="property-details" style="margin-top: 20px; padding: 20px; background: #f8f9fa; border-radius: 8px;">
                        <h4 style="margin-bottom: 15px; color: #333;">Detalles del alojamiento</h4>
                        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;">
                            <div><strong>🏠 Tipo:</strong> ${alojamiento.getTipoAlojamiento()}</div>
                            <div><strong>👥 Capacidad:</strong> ${alojamiento.getCapacidad()} huéspedes</div>
                            <div><strong>🛏️ Habitaciones:</strong> ${alojamiento.getHabitaciones()}</div>
                            <div><strong>🛌 Camas:</strong> ${alojamiento.getCamas()}</div>
                            <div><strong>🚿 Baños:</strong> ${alojamiento.getBanos()}</div>
                        </div>
                    </div>
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
                        <#if servicios?? && servicios?size gt 0>
                            <#list servicios as servicio>
                                <div class="amenity-item">
                                    <span class="amenity-icon">
                                        <#if servicio.getIcono()??>
                                            <img src="/icons/${servicio.getIcono()}.png" alt="${servicio.getDescripcion()}">
                                        <#else>
                                            ✅
                                        </#if>
                                    </span>
                                    <span>${servicio.getDescripcion()}</span>
                                </div>
                            </#list>
                        <#else>
                            <div class="amenity-item">
                                <span class="amenity-icon">ℹ️</span>
                                <span>No hay servicios especificados</span>
                            </div>
                        </#if>
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

                    <form class="booking-form" onsubmit="handleBooking(event)">
                        <div class="form-group">
                            <label class="form-label">Fechas</label>
                            <div class="date-inputs">
                                <input type="date" class="form-input" name="checkin" id="checkin" required>
                                <input type="date" class="form-input" name="checkout" id="checkout" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Huéspedes</label>
                            <select class="form-input" name="guests" id="guests">
                                <#list 1..alojamiento.getCapacidad() as num>
                                    <option value="${num}" class="form-option">${num} huésped<#if num gt 1>es</#if></option>
                                </#list>
                            </select>
                        </div>

                        <button type="submit" class="book-button">Reservar</button>
                    </form>

                    <div class="price-breakdown">
                        <div class="price-row">
                            <span id="nights-calculation">${alojamiento.getPrecioNoche()}€ x 1 noche</span>
                            <span id="subtotal">${alojamiento.getPrecioNoche()}€</span>
                        </div>
                        <div class="price-row">
                            <span>Tarifa de limpieza</span>
                            <span>15€</span>
                        </div>
                        <div class="price-row">
                            <span>Tarifa de servicio</span>
                            <span>10€</span>
                        </div>
                        <div class="price-row total-price">
                            <span>Total</span>
                            <span id="total-price">${(alojamiento.getPrecioNoche() + 25)?string.computer}€</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="/js/session-manager.js"></script>
    <script>
        // Variables globales del alojamiento
        var alojamientoData = {
            id: ${alojamiento.id},
            titulo: '${alojamiento.getTitulo()?js_string}',
            propietario: {
                email: '${(alojamiento.propietario.email)!""}'
            },
            precioNoche: ${alojamiento.getPrecioNoche()?string.computer}
        };

        // Variable global para edición
        var currentAlojamiento = null;

        // Inicialización de la página
        document.addEventListener('DOMContentLoaded', function() {
            console.log('=== INICIALIZANDO PÁGINA DE ALOJAMIENTO ===');
            
            var currentUserEmail = localStorage.getItem('userEmail');
            var propietarioEmail = '${(alojamiento.propietario.email)!""}';
            
            console.log('Email usuario actual:', currentUserEmail);
            console.log('Email propietario:', propietarioEmail);
            
            // Verificar si es propietario
            if (currentUserEmail && propietarioEmail && currentUserEmail === propietarioEmail) {
                console.log('✅ Usuario es propietario del alojamiento');
                
                var ownerActions = document.getElementById('owner-actions');
                if (ownerActions) {
                    ownerActions.style.display = 'block';
                }
                
                var contactBtn = document.querySelector('.contact-host-btn');
                if (contactBtn) {
                    contactBtn.textContent = '👤 Este es tu alojamiento';
                    contactBtn.disabled = true;
                    contactBtn.style.opacity = '0.6';
                    contactBtn.style.cursor = 'not-allowed';
                }
            }

            // Configurar fechas para reservas
            var today = new Date();
            var tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            
            var checkinInput = document.getElementById('checkin');
            var checkoutInput = document.getElementById('checkout');
            
            if (checkinInput) {
                checkinInput.min = today.toISOString().split('T')[0];
                checkinInput.addEventListener('change', updateCheckoutMin);
                checkinInput.addEventListener('change', calculateTotal);
            }
            
            if (checkoutInput) {
                checkoutInput.min = tomorrow.toISOString().split('T')[0];
                checkoutInput.addEventListener('change', calculateTotal);
            }
        });

        // Funciones de utilidad
        function updateCheckoutMin() {
            var checkinDate = new Date(document.getElementById('checkin').value);
            var checkoutInput = document.getElementById('checkout');
            
            if (checkinDate && checkoutInput) {
                var minCheckout = new Date(checkinDate);
                minCheckout.setDate(minCheckout.getDate() + 1);
                checkoutInput.min = minCheckout.toISOString().split('T')[0];
                
                if (checkoutInput.value && new Date(checkoutInput.value) <= checkinDate) {
                    checkoutInput.value = '';
                }
                calculateTotal();
            }
        }

        function calculateTotal() {
            var checkinDate = document.getElementById('checkin').value;
            var checkoutDate = document.getElementById('checkout').value;
            var precioNoche = alojamientoData.precioNoche;
            
            if (checkinDate && checkoutDate) {
                var checkin = new Date(checkinDate);
                var checkout = new Date(checkoutDate);
                var timeDiff = checkout.getTime() - checkin.getTime();
                var nights = Math.ceil(timeDiff / (1000 * 3600 * 24));
                
                if (nights > 0) {
                    var subtotal = precioNoche * nights;
                    var cleaningFee = 15;
                    var serviceFee = 10;
                    var total = subtotal + cleaningFee + serviceFee;
                    
                    document.getElementById('nights-calculation').textContent = precioNoche + '€ x ' + nights + ' noche' + (nights > 1 ? 's' : '');
                    document.getElementById('subtotal').textContent = subtotal + '€';
                    document.getElementById('total-price').textContent = total + '€';
                }
            }
        }

        function handleBooking(event) {
            event.preventDefault();
            
            var currentUserEmail = localStorage.getItem('userEmail');
            if (!currentUserEmail) {
                alert('Debes iniciar sesión para realizar una reserva');
                window.location.href = '/login';
                return;
            }
            
            var checkinDate = document.getElementById('checkin').value;
            var checkoutDate = document.getElementById('checkout').value;
            var guests = document.getElementById('guests').value;
            
            if (!checkinDate || !checkoutDate) {
                alert('Por favor selecciona las fechas de entrada y salida');
                return;
            }
            
            alert('Reserva simulada:\\nAlojamiento: ' + alojamientoData.titulo + '\\nFechas: ' + checkinDate + ' a ' + checkoutDate + '\\nHuéspedes: ' + guests + '\\n\\nEsta funcionalidad estará disponible próximamente.');
        }

        function changeMainImage(newSrc) {
            var mainImage = document.querySelector('.main-image');
            if (mainImage) {
                mainImage.src = newSrc;
                mainImage.style.opacity = '0.5';
                setTimeout(function() {
                    mainImage.style.opacity = '1';
                }, 150);
            }
        }

        function contactarAnfitrion(email) {
            if (!email || email.trim() === '') {
                alert('Email del anfitrión no disponible');
                return;
            }
            
            var subject = encodeURIComponent('Consulta sobre: ' + alojamientoData.titulo);
            var body = encodeURIComponent('Hola, estoy interesado en tu alojamiento y me gustaría hacer una consulta.');
            var mailtoLink = 'mailto:' + email + '?subject=' + subject + '&body=' + body;
            
            try {
                window.location.href = mailtoLink;
            } catch (error) {
                console.error('Error al abrir cliente de email:', error);
                alert('No se pudo abrir el cliente de email. Email: ' + email);
            }
        }

        function eliminarAlojamiento(id) {
            if (!confirm('¿Estás seguro de que quieres eliminar este alojamiento?\\n\\nEsta acción no se puede deshacer.')) {
                return;
            }
            
            var userEmail = localStorage.getItem('userEmail');
            if (!userEmail) {
                alert('Debes estar logueado para realizar esta acción');
                return;
            }
            
            var deleteBtn = document.querySelector('.delete-listing-btn');
            var originalText = deleteBtn.textContent;
            deleteBtn.disabled = true;
            deleteBtn.textContent = '🔄 Eliminando...';
            
            fetch('/alojamiento/delete/' + id + '?emailPropietario=' + encodeURIComponent(userEmail), {
                method: 'DELETE'
            })
            .then(function(response) {
                return response.text();
            })
            .then(function(result) {
                alert(result);
                if (result.indexOf('correctamente') !== -1) {
                    window.location.href = '/';
                }
            })
            .catch(function(error) {
                console.error('Error en eliminación:', error);
                alert('Error al eliminar el alojamiento: ' + error.message);
            })
            .finally(function() {
                deleteBtn.disabled = false;
                deleteBtn.textContent = originalText;
            });
        }

        // FUNCIONES DE EDICIÓN
        function editarAlojamiento(alojamientoId) {
            console.log('Editando alojamiento:', alojamientoId);
            
            var userEmail = localStorage.getItem('userEmail');
            if (!userEmail) {
                alert('Debes estar logueado para editar un alojamiento');
                return;
            }

            fetch('/alojamiento/' + alojamientoId)
                .then(function(response) {
                    if (!response.ok) {
                        throw new Error('No se pudo obtener la información del alojamiento');
                    }
                    return response.json();
                })
                .then(function(data) {
                    currentAlojamiento = data;
                    
                    if (!currentAlojamiento.propietario || currentAlojamiento.propietario.email !== userEmail) {
                        alert('No tienes permisos para editar este alojamiento');
                        return;
                    }

                    createEditModal();
                    populateEditForm();
                    showEditModal();
                })
                .catch(function(error) {
                    console.error('Error al cargar datos del alojamiento:', error);
                    alert('Error al cargar los datos del alojamiento: ' + error.message);
                });
        }

        function createEditModal() {
            var modal = document.getElementById('editAlojamientoModal');
            if (modal) {
                modal.remove();
            }

            modal = document.createElement('div');
            modal.id = 'editAlojamientoModal';
            modal.className = 'modal';
            modal.style.display = 'none';

            modal.innerHTML = '<div class="modal-content">' +
                '<div class="modal-header">' +
                    '<h2>✏️ Editar Alojamiento</h2>' +
                    '<span class="close" onclick="closeEditModal()" title="Cerrar">&times;</span>' +
                '</div>' +
                '<form id="editAlojamientoForm" class="edit-form">' +
                    '<div class="form-section">' +
                        '<h3>Información Básica</h3>' +
                        '<div class="form-group">' +
                            '<label for="edit-titulo" class="form-label">Título *</label>' +
                            '<input type="text" id="edit-titulo" name="titulo" required class="form-input">' +
                        '</div>' +
                        '<div class="form-group">' +
                            '<label for="edit-descripcion" class="form-label">Descripción *</label>' +
                            '<textarea id="edit-descripcion" name="descripcion" required class="form-input" rows="4"></textarea>' +
                        '</div>' +
                        '<div class="form-row">' +
                            '<div class="form-group">' +
                                '<label for="edit-tipo" class="form-label">Tipo de Alojamiento *</label>' +
                                '<select id="edit-tipo" name="tipoAlojamiento" required class="form-input">' +
                                    '<option value="">Seleccione</option>' +
                                    '<option value="Apartamento">Apartamento</option>' +
                                    '<option value="Casa">Casa</option>' +
                                    '<option value="Estudio">Estudio</option>' +
                                    '<option value="Villa">Villa</option>' +
                                    '<option value="Loft">Loft</option>' +
                                '</select>' +
                            '</div>' +
                            '<div class="form-group">' +
                                '<label for="edit-capacidad" class="form-label">Capacidad *</label>' +
                                '<input type="number" id="edit-capacidad" name="capacidad" required min="1" max="20" class="form-input">' +
                            '</div>' +
                        '</div>' +
                    '</div>' +
                    '<div class="form-section">' +
                        '<h3>Detalles del Espacio</h3>' +
                        '<div class="form-row">' +
                            '<div class="form-group">' +
                                '<label for="edit-habitaciones" class="form-label">Habitaciones *</label>' +
                                '<input type="number" id="edit-habitaciones" name="habitaciones" required min="0" max="10" class="form-input">' +
                            '</div>' +
                            '<div class="form-group">' +
                                '<label for="edit-camas" class="form-label">Camas *</label>' +
                                '<input type="number" id="edit-camas" name="camas" required min="1" max="20" class="form-input">' +
                            '</div>' +
                        '</div>' +
                        '<div class="form-row">' +
                            '<div class="form-group">' +
                                '<label for="edit-banos" class="form-label">Baños *</label>' +
                                '<input type="number" id="edit-banos" name="banos" required min="1" max="10" step="0.5" class="form-input">' +
                            '</div>' +
                            '<div class="form-group">' +
                                '<label for="edit-precio" class="form-label">Precio por Noche (€) *</label>' +
                                '<input type="number" id="edit-precio" name="precioNoche" required min="1" step="0.01" class="form-input">' +
                            '</div>' +
                        '</div>' +
                    '</div>' +
                    '<div class="form-section">' +
                        '<h3>Ubicación</h3>' +
                        '<div class="form-group">' +
                            '<label for="edit-direccion" class="form-label">Dirección *</label>' +
                            '<input type="text" id="edit-direccion" name="direccion" required class="form-input">' +
                        '</div>' +
                        '<div class="form-group">' +
                            '<label for="edit-direccion-desc" class="form-label">Descripción de la Dirección</label>' +
                            '<input type="text" id="edit-direccion-desc" name="direccionDescripcion" class="form-input">' +
                        '</div>' +
                        '<div class="form-row">' +
                            '<div class="form-group">' +
                                '<label for="edit-ciudad" class="form-label">Ciudad *</label>' +
                                '<input type="text" id="edit-ciudad" name="ciudad" required class="form-input">' +
                            '</div>' +
                            '<div class="form-group">' +
                                '<label for="edit-pais" class="form-label">País *</label>' +
                                '<input type="text" id="edit-pais" name="pais" required class="form-input">' +
                            '</div>' +
                        '</div>' +
                        '<div class="form-group">' +
                            '<label for="edit-codigo-postal" class="form-label">Código Postal</label>' +
                            '<input type="text" id="edit-codigo-postal" name="codigoPostal" class="form-input">' +
                        '</div>' +
                    '</div>' +
                '</form>' +
                '<div class="modal-footer">' +
                    '<button type="button" class="cancel-btn" onclick="closeEditModal()">Cancelar</button>' +
                    '<button type="button" class="save-btn" onclick="saveAlojamientoChanges()">Guardar Cambios</button>' +
                '</div>' +
            '</div>';

            document.body.appendChild(modal);

            modal.addEventListener('click', function(e) {
                if (e.target === modal) {
                    closeEditModal();
                }
            });

            modal.querySelector('.modal-content').addEventListener('click', function(e) {
                e.stopPropagation();
            });
        }

        function populateEditForm() {
            if (!currentAlojamiento) return;

            document.getElementById('edit-titulo').value = currentAlojamiento.titulo || '';
            document.getElementById('edit-descripcion').value = currentAlojamiento.descripcion || '';
            document.getElementById('edit-tipo').value = currentAlojamiento.tipoAlojamiento || '';
            document.getElementById('edit-capacidad').value = currentAlojamiento.capacidad || '';
            document.getElementById('edit-habitaciones').value = currentAlojamiento.habitaciones || '';
            document.getElementById('edit-camas').value = currentAlojamiento.camas || '';
            document.getElementById('edit-banos').value = currentAlojamiento.banos || '';
            document.getElementById('edit-precio').value = currentAlojamiento.precioNoche || '';
            document.getElementById('edit-direccion').value = currentAlojamiento.direccion || '';
            document.getElementById('edit-direccion-desc').value = currentAlojamiento.direccionDescripcion || '';
            document.getElementById('edit-ciudad').value = currentAlojamiento.ciudad || '';
            document.getElementById('edit-pais').value = currentAlojamiento.pais || '';
            document.getElementById('edit-codigo-postal').value = currentAlojamiento.codigoPostal || '';
        }

        function showEditModal() {
            var modal = document.getElementById('editAlojamientoModal');
            if (modal) {
                modal.style.display = 'block';
                document.body.style.overflow = 'hidden';
            }
        }

        function closeEditModal() {
            var modal = document.getElementById('editAlojamientoModal');
            if (modal) {
                modal.style.display = 'none';
                document.body.style.overflow = 'auto';
            }
            currentAlojamiento = null;
        }

        function validateEditForm() {
            var requiredFields = [
                'edit-titulo', 'edit-descripcion', 'edit-tipo', 'edit-capacidad',
                'edit-habitaciones', 'edit-camas', 'edit-banos', 'edit-precio',
                'edit-direccion', 'edit-ciudad', 'edit-pais'
            ];

            var isValid = true;
            var errors = [];

            for (var i = 0; i < requiredFields.length; i++) {
                var field = document.getElementById(requiredFields[i]);
                if (!field || !field.value.trim()) {
                    isValid = false;
                    errors.push('El campo ' + requiredFields[i].replace('edit-', '') + ' es requerido');
                    if (field) {
                        field.style.borderColor = '#dc3545';
                    }
                } else if (field) {
                    field.style.borderColor = '';
                }
            }

            var capacidad = parseInt(document.getElementById('edit-capacidad').value);
            var habitaciones = parseInt(document.getElementById('edit-habitaciones').value);
            var camas = parseInt(document.getElementById('edit-camas').value);
            var banos = parseFloat(document.getElementById('edit-banos').value);
            var precio = parseFloat(document.getElementById('edit-precio').value);

            if (capacidad < 1 || capacidad > 20) {
                isValid = false;
                errors.push('La capacidad debe estar entre 1 y 20 personas');
            }

            if (habitaciones < 0 || habitaciones > 10) {
                isValid = false;
                errors.push('Las habitaciones deben estar entre 0 y 10');
            }

            if (camas < 1 || camas > 20) {
                isValid = false;
                errors.push('Las camas deben estar entre 1 y 20');
            }

            if (banos < 1 || banos > 10) {
                isValid = false;
                errors.push('Los baños deben estar entre 1 y 10');
            }

            if (precio <= 0) {
                isValid = false;
                errors.push('El precio debe ser mayor a 0');
            }

            if (!isValid) {
                alert('Errores en el formulario:\\n' + errors.join('\\n'));
            }

            return isValid;
        }

        function gatherFormData() {
            return {
                id: currentAlojamiento.id,
                titulo: document.getElementById('edit-titulo').value.trim(),
                descripcion: document.getElementById('edit-descripcion').value.trim(),
                tipoAlojamiento: document.getElementById('edit-tipo').value,
                capacidad: parseInt(document.getElementById('edit-capacidad').value),
                habitaciones: parseInt(document.getElementById('edit-habitaciones').value),
                camas: parseInt(document.getElementById('edit-camas').value),
                banos: parseFloat(document.getElementById('edit-banos').value),
                precioNoche: parseFloat(document.getElementById('edit-precio').value),
                direccion: document.getElementById('edit-direccion').value.trim(),
                direccionDescripcion: document.getElementById('edit-direccion-desc').value.trim(),
                ciudad: document.getElementById('edit-ciudad').value.trim(),
                pais: document.getElementById('edit-pais').value.trim(),
                codigoPostal: document.getElementById('edit-codigo-postal').value.trim(),
                propietario: currentAlojamiento.propietario,
                fechaRegistro: currentAlojamiento.fechaRegistro
            };
        }

        function saveAlojamientoChanges() {
            console.log('Guardando cambios del alojamiento...');

            if (!validateEditForm()) {
                return;
            }

            var userEmail = localStorage.getItem('userEmail');
            if (!userEmail) {
                alert('Debes estar logueado para realizar esta acción');
                return;
            }

            var formData = gatherFormData();
            
            var saveBtn = document.querySelector('.save-btn');
            var originalText = saveBtn.textContent;
            saveBtn.disabled = true;
            saveBtn.textContent = 'Guardando...';

            fetch('/alojamiento/update/' + currentAlojamiento.id + '?emailPropietario=' + encodeURIComponent(userEmail), {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(formData)
            })
            .then(function(response) {
                return response.text();
            })
            .then(function(result) {
                if (result.indexOf('correctamente') !== -1) {
                    alert('Alojamiento actualizado correctamente');
                    closeEditModal();
                    
                    setTimeout(function() {
                        window.location.reload();
                    }, 1000);
                } else {
                    throw new Error(result);
                }
            })
            .catch(function(error) {
                console.error('Error al actualizar alojamiento:', error);
                alert('Error al actualizar el alojamiento: ' + error.message);
            })
            .finally(function() {
                saveBtn.disabled = false;
                saveBtn.textContent = originalText;
            });
        }

        // Event listener para teclas
        document.addEventListener('keydown', function(e) {
            var modal = document.getElementById('editAlojamientoModal');
            if (modal && modal.style.display === 'block') {
                if (e.key === 'Escape') {
                    closeEditModal();
                }
            }
        });
    </script>
</body>
</html>