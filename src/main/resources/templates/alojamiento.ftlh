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
                <br>
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
                            <button class="contact-host-btn">
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
                <br>
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

        // VERSIÓN OPTIMIZADA DEL MODAL DE EDICIÓN - Reemplazar en alojamiento.ftlh

        // Variables globales optimizadas
        var currentAlojamiento = null;
        var editModal = null;
        var isModalOpen = false;

        // FUNCIONES DE EDICIÓN OPTIMIZADAS
        function editarAlojamiento(alojamientoId) {
            console.log('Editando alojamiento:', alojamientoId);
            
            var userEmail = localStorage.getItem('userEmail');
            if (!userEmail) {
                alert('Debes estar logueado para editar un alojamiento');
                return;
            }

            // Mostrar loading
            showLoadingSpinner('Cargando datos del alojamiento...');

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
                        throw new Error('No tienes permisos para editar este alojamiento');
                    }

                    hideLoadingSpinner();
                    createOptimizedEditModal();
                    populateEditForm();
                    showEditModal();
                })
                .catch(function(error) {
                    hideLoadingSpinner();
                    console.error('Error al cargar datos del alojamiento:', error);
                    alert('Error: ' + error.message);
                });
        }

        function createOptimizedEditModal() {
            // Eliminar modal existente si existe
            if (editModal) {
                editModal.remove();
                editModal = null;
            }

            editModal = document.createElement('div');
            editModal.id = 'editAlojamientoModal';
            editModal.className = 'modal';
            editModal.style.display = 'none';

            // HTML del modal optimizado
            editModal.innerHTML = `
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>✏️ Editar Alojamiento</h2>
                        <span class="close" onclick="closeEditModal()" title="Cerrar">&times;</span>
                    </div>
                    
                    <form id="editAlojamientoForm" class="edit-form" onsubmit="handleFormSubmit(event)">
                        <!-- Información Básica -->
                        <div class="form-section">
                            <h3>📝 Información Básica</h3>
                            <div class="form-group">
                                <label for="edit-titulo" class="form-label">Título</label>
                                <input type="text" id="edit-titulo" name="titulo" required class="form-input" 
                                    maxlength="100" placeholder="Título del alojamiento">
                            </div>
                            <div class="form-group">
                                <label for="edit-descripcion" class="form-label">Descripción</label>
                                <textarea id="edit-descripcion" name="descripcion" required class="form-input" 
                                        rows="4" maxlength="1000" placeholder="Describe tu alojamiento..."></textarea>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="edit-tipo" class="form-label">Tipo de Alojamiento</label>
                                    <select id="edit-tipo" name="tipoAlojamiento" required class="form-input">
                                        <option value="">Seleccione un tipo</option>
                                        <option value="Apartamento">Apartamento</option>
                                        <option value="Casa">Casa</option>
                                        <option value="Estudio">Estudio</option>
                                        <option value="Villa">Villa</option>
                                        <option value="Loft">Loft</option>
                                        <option value="Cabaña">Cabaña</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="edit-precio" class="form-label">Precio por Noche (€)</label>
                                    <input type="number" id="edit-precio" name="precioNoche" required 
                                        min="1" max="10000" step="0.01" class="form-input" placeholder="50.00">
                                </div>
                            </div>
                        </div>

                        <!-- Detalles del Espacio -->
                        <div class="form-section">
                            <h3>🏠 Detalles del Espacio</h3>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="edit-capacidad" class="form-label">Capacidad</label>
                                    <input type="number" id="edit-capacidad" name="capacidad" required 
                                        min="1" max="20" class="form-input" placeholder="4">
                                </div>
                                <div class="form-group">
                                    <label for="edit-habitaciones" class="form-label">Habitaciones</label>
                                    <input type="number" id="edit-habitaciones" name="habitaciones" required 
                                        min="0" max="10" class="form-input" placeholder="2">
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="edit-camas" class="form-label">Camas</label>
                                    <input type="number" id="edit-camas" name="camas" required 
                                        min="1" max="20" class="form-input" placeholder="2">
                                </div>
                                <div class="form-group">
                                    <label for="edit-banos" class="form-label">Baños</label>
                                    <input type="number" id="edit-banos" name="banos" required 
                                        min="1" max="10" step="0.5" class="form-input" placeholder="1">
                                </div>
                            </div>
                        </div>

                        <!-- Ubicación -->
                        <div class="form-section">
                            <h3>📍 Ubicación</h3>
                            <div class="form-group">
                                <label for="edit-direccion" class="form-label">Dirección</label>
                                <input type="text" id="edit-direccion" name="direccion" required class="form-input" 
                                    maxlength="200" placeholder="Calle, número, piso...">
                            </div>
                            <div class="form-group">
                                <label for="edit-direccion-desc" class="form-label">Descripción de la Dirección (Opcional)</label>
                                <input type="text" id="edit-direccion-desc" name="direccionDescripcion" class="form-input" 
                                    maxlength="300" placeholder="Indicaciones adicionales...">
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="edit-ciudad" class="form-label">Ciudad</label>
                                    <input type="text" id="edit-ciudad" name="ciudad" required class="form-input" 
                                        maxlength="100" placeholder="Madrid">
                                </div>
                                <div class="form-group">
                                    <label for="edit-pais" class="form-label">País</label>
                                    <input type="text" id="edit-pais" name="pais" required class="form-input" 
                                        maxlength="100" placeholder="España">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="edit-codigo-postal" class="form-label">Código Postal (Opcional)</label>
                                <input type="text" id="edit-codigo-postal" name="codigoPostal" class="form-input" 
                                    maxlength="10" placeholder="28001">
                            </div>
                        </div>
                    </form>
                    
                    <div class="modal-footer">
                        <button type="button" class="cancel-btn" onclick="closeEditModal()">
                            <i class="fas fa-times"></i> Cancelar
                        </button>
                        <button type="button" class="save-btn" onclick="saveAlojamientoChanges()">
                            <i class="fas fa-save"></i> Guardar Cambios
                        </button>
                    </div>
                </div>
            `;

            document.body.appendChild(editModal);

            // Event listeners optimizados
            setupModalEventListeners();
        }

        function setupModalEventListeners() {
            // Cerrar modal al hacer clic en el fondo
            editModal.addEventListener('click', function(e) {
                if (e.target === editModal) {
                    closeEditModal();
                }
            });

            // Prevenir cierre al hacer clic en el contenido
            var modalContent = editModal.querySelector('.modal-content');
            modalContent.addEventListener('click', function(e) {
                e.stopPropagation();
            });

            // Validación en tiempo real (debounced)
            var inputs = editModal.querySelectorAll('input, textarea, select');
            inputs.forEach(function(input) {
                input.addEventListener('input', debounceValidation);
                input.addEventListener('blur', function() {
                    validateField(this);
                });
            });
        }

        function populateEditForm() {
            if (!currentAlojamiento) {
                console.error('No hay datos del alojamiento para poblar el formulario');
                return;
            }

            try {
                // Poblar campos de forma segura
                setFieldValue('edit-titulo', currentAlojamiento.titulo);
                setFieldValue('edit-descripcion', currentAlojamiento.descripcion);
                setFieldValue('edit-tipo', currentAlojamiento.tipoAlojamiento);
                setFieldValue('edit-capacidad', currentAlojamiento.capacidad);
                setFieldValue('edit-habitaciones', currentAlojamiento.habitaciones);
                setFieldValue('edit-camas', currentAlojamiento.camas);
                setFieldValue('edit-banos', currentAlojamiento.banos);
                setFieldValue('edit-precio', currentAlojamiento.precioNoche);
                setFieldValue('edit-direccion', currentAlojamiento.direccion);
                setFieldValue('edit-direccion-desc', currentAlojamiento.direccionDescripcion);
                setFieldValue('edit-ciudad', currentAlojamiento.ciudad);
                setFieldValue('edit-pais', currentAlojamiento.pais);
                setFieldValue('edit-codigo-postal', currentAlojamiento.codigoPostal);

                console.log('Formulario poblado correctamente');
            } catch (error) {
                console.error('Error al poblar el formulario:', error);
                alert('Error al cargar los datos en el formulario');
            }
        }

        function setFieldValue(fieldId, value) {
            var field = document.getElementById(fieldId);
            if (field && value !== undefined && value !== null) {
                field.value = value;
            }
        }

        function showEditModal() {
            if (!editModal) {
                console.error('Modal no existe');
                return;
            }

            editModal.style.display = 'block';
            document.body.style.overflow = 'hidden';
            isModalOpen = true;

            // Animar entrada
            requestAnimationFrame(function() {
                editModal.style.opacity = '1';
            });

            // Foco en el primer campo
            setTimeout(function() {
                var firstInput = editModal.querySelector('#edit-titulo');
                if (firstInput) {
                    firstInput.focus();
                }
            }, 300);
        }

        function closeEditModal() {
            if (!editModal || !isModalOpen) return;

            // Verificar si hay cambios sin guardar
            if (hasUnsavedChanges() && !confirm('¿Estás seguro de cerrar? Los cambios no guardados se perderán.')) {
                return;
            }

            editModal.style.display = 'none';
            document.body.style.overflow = 'auto';
            isModalOpen = false;
            currentAlojamiento = null;

            // Limpiar el modal después de un delay
            setTimeout(function() {
                if (editModal && editModal.parentNode) {
                    editModal.parentNode.removeChild(editModal);
                    editModal = null;
                }
            }, 300);
        }

        function hasUnsavedChanges() {
            if (!currentAlojamiento || !editModal) return false;

            var currentValues = gatherFormData();
            
            // Comparar valores importantes
            return (
                currentValues.titulo !== currentAlojamiento.titulo ||
                currentValues.descripcion !== currentAlojamiento.descripcion ||
                currentValues.precioNoche !== currentAlojamiento.precioNoche ||
                currentValues.capacidad !== currentAlojamiento.capacidad
            );
        }

        function handleFormSubmit(event) {
            event.preventDefault();
            saveAlojamientoChanges();
        }

        // Validación optimizada
        var validationTimeout;
        function debounceValidation() {
            clearTimeout(validationTimeout);
            validationTimeout = setTimeout(function() {
                validateForm();
            }, 500);
        }

        function validateField(field) {
            var value = field.value.trim();
            var isValid = true;

            // Limpiar estados anteriores
            field.classList.remove('error', 'success');

            // Validaciones específicas
            switch (field.id) {
                case 'edit-titulo':
                    isValid = value.length >= 5 && value.length <= 100;
                    break;
                case 'edit-descripcion':
                    isValid = value.length >= 20 && value.length <= 1000;
                    break;
                case 'edit-precio':
                    var precio = parseFloat(value);
                    isValid = precio > 0 && precio <= 10000;
                    break;
                case 'edit-capacidad':
                case 'edit-habitaciones':
                case 'edit-camas':
                case 'edit-banos':
                    var num = parseFloat(value);
                    isValid = num > 0 && num <= 20;
                    break;
                default:
                    isValid = field.hasAttribute('required') ? value.length > 0 : true;
            }

            // Aplicar clase de estado
            if (field.hasAttribute('required') || value.length > 0) {
                field.classList.add(isValid ? 'success' : 'error');
            }

            return isValid;
        }

        function validateForm() {
            var form = document.getElementById('editAlojamientoForm');
            if (!form) return false;

            var inputs = form.querySelectorAll('input[required], textarea[required], select[required]');
            var isValid = true;
            var errors = [];

            inputs.forEach(function(input) {
                if (!validateField(input)) {
                    isValid = false;
                    errors.push(input.previousElementSibling.textContent + ' no es válido');
                }
            });

            // Validaciones adicionales
            var capacidad = parseInt(document.getElementById('edit-capacidad').value);
            var habitaciones = parseInt(document.getElementById('edit-habitaciones').value);
            var camas = parseInt(document.getElementById('edit-camas').value);

            if (capacidad < camas) {
                isValid = false;
                errors.push('La capacidad no puede ser menor que el número de camas');
            }

            // Actualizar botón de guardar
            var saveBtn = document.querySelector('.save-btn');
            if (saveBtn) {
                saveBtn.disabled = !isValid;
            }

            return isValid;
        }

        function gatherFormData() {
            if (!currentAlojamiento) {
                console.error('No hay datos del alojamiento actual');
                return null;
            }

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
                direccionDescripcion: document.getElementById('edit-direccion-desc').value.trim() || null,
                ciudad: document.getElementById('edit-ciudad').value.trim(),
                pais: document.getElementById('edit-pais').value.trim(),
                codigoPostal: document.getElementById('edit-codigo-postal').value.trim() || null,
                propietario: currentAlojamiento.propietario,
                fechaRegistro: currentAlojamiento.fechaRegistro
            };
        }

        function saveAlojamientoChanges() {
            console.log('Iniciando guardado de cambios...');

            if (!validateForm()) {
                alert('Por favor corrige los errores en el formulario antes de continuar');
                return;
            }

            var userEmail = localStorage.getItem('userEmail');
            if (!userEmail) {
                alert('Debes estar logueado para realizar esta acción');
                return;
            }

            var formData = gatherFormData();
            if (!formData) {
                alert('Error al recopilar los datos del formulario');
                return;
            }

            var saveBtn = document.querySelector('.save-btn');
            var originalHTML = saveBtn.innerHTML;
            
            // Estado de carga
            saveBtn.disabled = true;
            saveBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Guardando...';

            fetch('/alojamiento/update/' + currentAlojamiento.id + '?emailPropietario=' + encodeURIComponent(userEmail), {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(formData)
            })
            .then(function(response) {
                if (!response.ok) {
                    throw new Error('Error del servidor: ' + response.status);
                }
                return response.text();
            })
            .then(function(result) {
                console.log('Respuesta del servidor:', result);
                
                if (result.indexOf('correctamente') !== -1) {
                    // Éxito
                    saveBtn.innerHTML = '<i class="fas fa-check"></i> Guardado';
                    saveBtn.style.background = 'linear-gradient(135deg, #51cf66 0%, #40c057 100%)';
                    
                    setTimeout(function() {
                        closeEditModal();
                        showSuccessMessage('Alojamiento actualizado correctamente');
                        
                        // Recargar página después de un momento
                        setTimeout(function() {
                            window.location.reload();
                        }, 1500);
                    }, 1000);
                } else {
                    throw new Error(result);
                }
            })
            .catch(function(error) {
                console.error('Error al actualizar alojamiento:', error);
                
                saveBtn.innerHTML = '<i class="fas fa-exclamation-triangle"></i> Error';
                saveBtn.style.background = 'linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%)';
                
                alert('Error al actualizar el alojamiento: ' + error.message);
                
                // Restaurar botón después de 3 segundos
                setTimeout(function() {
                    saveBtn.disabled = false;
                    saveBtn.innerHTML = originalHTML;
                    saveBtn.style.background = '';
                }, 3000);
            });
        }

        // Funciones de utilidad
        function showLoadingSpinner(message) {
            var spinner = document.createElement('div');
            spinner.id = 'loading-spinner';
            spinner.style.cssText = `
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.7);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 10001;
                backdrop-filter: blur(5px);
            `;
            
            spinner.innerHTML = `
                <div style="background: white; padding: 30px; border-radius: 15px; text-align: center; box-shadow: 0 10px 30px rgba(0,0,0,0.3);">
                    <div style="font-size: 2rem; margin-bottom: 15px;">
                        <i class="fas fa-spinner fa-spin" style="color: #667eea;"></i>
                    </div>
                    <div style="color: #333; font-weight: 600;">${message!"Error desconocido"}</div>
                </div>
            `;
            
            document.body.appendChild(spinner);
        }

        function hideLoadingSpinner() {
            var spinner = document.getElementById('loading-spinner');
            if (spinner) {
                spinner.remove();
            }
        }

        function showSuccessMessage(message) {
            var notification = document.createElement('div');
            notification.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                background: linear-gradient(135deg, #51cf66 0%, #40c057 100%);
                color: white;
                padding: 15px 25px;
                border-radius: 15px;
                z-index: 10002;
                font-weight: 600;
                box-shadow: 0 8px 25px rgba(81, 207, 102, 0.3);
                transform: translateX(120%);
                transition: transform 0.4s ease;
            `;
            
            notification.innerHTML = `<i class="fas fa-check-circle"></i> ${message}`;
            document.body.appendChild(notification);
            
            setTimeout(() => notification.style.transform = 'translateX(0)', 100);
            
            setTimeout(() => {
                notification.style.transform = 'translateX(120%)';
                setTimeout(() => notification.remove(), 400);
            }, 3000);
        }

        // Event listeners globales
        document.addEventListener('keydown', function(e) {
            if (isModalOpen && e.key === 'Escape') {
                closeEditModal();
            }
        });

        // Prevenir cierre accidental de la página con cambios sin guardar
        window.addEventListener('beforeunload', function(e) {
            if (isModalOpen && hasUnsavedChanges()) {
                e.preventDefault();
                e.returnValue = '';
            }
        });
    </script>
</body>
</html>