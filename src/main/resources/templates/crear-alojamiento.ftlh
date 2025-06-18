<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear nuevo alojamiento - Airbnb</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/css/crear-alojamiento.css">
</head>
<body>
    <div class="container">
        <!-- Navigation Bar -->
        <nav class="navbar">
            <div class="nav-buttons">
                <button class="nav-btn back-btn" onclick="window.history.back()">
                    <i class="fas fa-arrow-left"></i>
                    Volver atrás
                </button>
                <button class="nav-btn save-btn" onclick="saveDraft()">
                    <i class="fas fa-save"></i>
                    Guardar borrador
                </button>
            </div>
            <div class="brand">
                <i class="fab fa-airbnb" style="font-size: 2rem; color: #ff5a5f;"></i>
            </div>
        </nav>

        <!-- Progress Bar -->
        <div class="progress-section">
            <div class="progress-bar">
                <div class="progress-fill" id="progress-fill"></div>
            </div>
            <div class="progress-text" id="progress-text">Progreso: 0% completado</div>
        </div>

        <!-- Hero Section -->
        <header class="hero-section">
            <h1 class="property-title">Crear tu alojamiento</h1>
            <p class="property-subtitle">
                <i class="fas fa-home"></i>
                Comparte tu espacio con viajeros de todo el mundo
            </p>
        </header>

        <!-- Main Form -->
        <form id="crear-alojamiento-form" enctype="multipart/form-data">
            <div class="main-grid">
                <!-- Left Column - Form Fields -->
                <div class="content-card">
                    
                    <!-- Información Básica -->
                    <section class="form-section">
                        <h2 class="section-title">
                            <i class="fas fa-info-circle"></i>
                            Información básica
                        </h2>
                        
                        <div class="form-group">
                            <label for="titulo" class="form-label">Título del alojamiento *</label>
                            <input type="text" 
                                   id="titulo" 
                                   name="titulo" 
                                   class="form-input" 
                                   placeholder="Ej: Apartamento acogedor en el centro de la ciudad"
                                   required
                                   maxlength="100">
                        </div>

                        <div class="form-group">
                            <label for="descripcion" class="form-label">Descripción *</label>
                            <textarea id="descripcion" 
                                      name="descripcion" 
                                      class="form-textarea" 
                                      placeholder="Describe tu alojamiento: qué lo hace especial, qué pueden esperar los huéspedes, lugares de interés cercanos..."
                                      required
                                      maxlength="2000"></textarea>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="tipoAlojamiento" class="form-label">Tipo de alojamiento *</label>
                                <select id="tipoAlojamiento" name="tipoAlojamiento" class="form-select" required>
                                    <option value="">Selecciona el tipo</option>
                                    <option value="Apartamento">Apartamento</option>
                                    <option value="Casa">Casa</option>
                                    <option value="Estudio">Estudio</option>
                                    <option value="Loft">Loft</option>
                                    <option value="Villa">Villa</option>
                                    <option value="Cabaña">Cabaña</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="precioNoche" class="form-label">Precio por noche (€) *</label>
                                <input type="number" 
                                       id="precioNoche" 
                                       name="precioNoche" 
                                       class="form-input" 
                                       placeholder="50"
                                       min="1"
                                       max="10000"
                                       step="0.01"
                                       required>
                            </div>
                        </div>
                    </section>

                    <!-- Ubicación -->
                    <section class="form-section">
                        <h2 class="section-title">
                            <i class="fas fa-map-marker-alt"></i>
                            Ubicación
                        </h2>

                        <div class="form-group">
                            <label for="direccion" class="form-label">Dirección completa *</label>
                            <input type="text" 
                                   id="direccion" 
                                   name="direccion" 
                                   class="form-input" 
                                   placeholder="Calle, número, piso..."
                                   required>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="ciudad" class="form-label">Ciudad *</label>
                                <input type="text" 
                                       id="ciudad" 
                                       name="ciudad" 
                                       class="form-input" 
                                       placeholder="Madrid"
                                       required>
                            </div>

                            <div class="form-group">
                                <label for="pais" class="form-label">País *</label>
                                <input type="text" 
                                       id="pais" 
                                       name="pais" 
                                       class="form-input" 
                                       placeholder="España"
                                       required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="codigoPostal" class="form-label">Código postal</label>
                            <input type="text" 
                                   id="codigoPostal" 
                                   name="codigoPostal" 
                                   class="form-input" 
                                   placeholder="28001">
                        </div>

                        <div class="form-group">
                            <label for="direccionDescripcion" class="form-label">Descripción adicional de la ubicación</label>
                            <textarea id="direccionDescripcion" 
                                      name="direccionDescripcion" 
                                      class="form-textarea" 
                                      placeholder="Indicaciones especiales, referencias cercanas, instrucciones de acceso..."
                                      style="min-height: 80px;"></textarea>
                        </div>
                    </section>

                    <!-- Capacidad y Habitaciones -->
                    <section class="form-section">
                        <h2 class="section-title">
                            <i class="fas fa-users"></i>
                            Capacidad y distribución
                        </h2>

                        <div class="form-row four-cols">
                            <div class="form-group">
                                <label for="capacidad" class="form-label">Huéspedes *</label>
                                <input type="number" 
                                       id="capacidad" 
                                       name="capacidad" 
                                       class="form-input" 
                                       placeholder="4"
                                       min="1"
                                       max="50"
                                       required>
                            </div>

                            <div class="form-group">
                                <label for="habitaciones" class="form-label">Habitaciones *</label>
                                <input type="number" 
                                       id="habitaciones" 
                                       name="habitaciones" 
                                       class="form-input" 
                                       placeholder="2"
                                       min="1"
                                       max="20"
                                       required>
                            </div>

                            <div class="form-group">
                                <label for="camas" class="form-label">Camas *</label>
                                <input type="number" 
                                       id="camas" 
                                       name="camas" 
                                       class="form-input" 
                                       placeholder="2"
                                       min="1"
                                       max="30"
                                       required>
                            </div>

                            <div class="form-group">
                                <label for="banos" class="form-label">Baños *</label>
                                <input type="number" 
                                       id="banos" 
                                       name="banos" 
                                       class="form-input" 
                                       placeholder="1"
                                       min="1"
                                       max="10"
                                       required>
                            </div>
                        </div>
                    </section>

                    <!-- Imágenes -->
                    <section class="form-section">
                        <h2 class="section-title">
                            <i class="fas fa-camera"></i>
                            Imágenes del alojamiento
                        </h2>

                        <div class="image-upload-section">
                            <div class="image-upload-area" id="image-upload-area">
                                <div class="upload-icon">
                                    <i class="fas fa-cloud-upload-alt"></i>
                                </div>
                                <div class="upload-text">Sube las fotos de tu alojamiento</div>
                                <div class="upload-subtext">
                                    Arrastra y suelta las imágenes aquí o haz clic para seleccionar<br>
                                    <small>Máximo 10 imágenes • JPG, PNG • Máximo 5MB cada una</small>
                                </div>
                            </div>
                            <input type="file" 
                                   id="image-input" 
                                   class="file-input" 
                                   accept="image/*" 
                                   multiple>
                            
                            <div class="image-preview-grid" id="image-preview-grid">
                                <!-- Las previsualizaciones aparecerán aquí -->
                            </div>
                        </div>
                    </section>

                    <!-- Comodidades -->
                    <section class="form-section">
                        <h2 class="section-title">
                            <i class="fas fa-star"></i>
                            Comodidades y servicios
                        </h2>

                        <div class="amenities-grid">
                            <div class="amenity-checkbox">
                                <div class="amenity-icon">
                                    <i class="fas fa-wifi"></i>
                                </div>
                                <span>WiFi</span>
                                <input type="checkbox" class="checkbox-input" value="WiFi">
                            </div>

                            <div class="amenity-checkbox">
                                <div class="amenity-icon">
                                    <i class="fas fa-utensils"></i>
                                </div>
                                <span>Cocina</span>
                                <input type="checkbox" class="checkbox-input" value="Cocina">
                            </div>

                            <div class="amenity-checkbox">
                                <div class="amenity-icon">
                                    <i class="fas fa-car"></i>
                                </div>
                                <span>Estacionamiento gratuito</span>
                                <input type="checkbox" class="checkbox-input" value="Estacionamiento gratuito">
                            </div>

                            <div class="amenity-checkbox">
                                <div class="amenity-icon">
                                    <i class="fas fa-swimming-pool"></i>
                                </div>
                                <span>Piscina</span>
                                <input type="checkbox" class="checkbox-input" value="Piscina">
                            </div>

                            <div class="amenity-checkbox">
                                <div class="amenity-icon">
                                    <i class="fas fa-hot-tub"></i>
                                </div>
                                <span>Jacuzzi</span>
                                <input type="checkbox" class="checkbox-input" value="Jacuzzi">
                            </div>

                            <div class="amenity-checkbox">
                                <div class="amenity-icon">
                                    <i class="fas fa-wind"></i>
                                </div>
                                <span>Aire acondicionado</span>
                                <input type="checkbox" class="checkbox-input" value="Aire acondicionado">
                            </div>

                            <div class="amenity-checkbox">
                                <div class="amenity-icon">
                                    <i class="fas fa-fire"></i>
                                </div>
                                <span>Calefacción</span>
                                <input type="checkbox" class="checkbox-input" value="Calefacción">
                            </div>

                            <div class="amenity-checkbox">
                                <div class="amenity-icon">
                                    <i class="fas fa-soap"></i>
                                </div>
                                <span>Lavadora</span>
                                <input type="checkbox" class="checkbox-input" value="Lavadora">
                            </div>

                            <div class="amenity-checkbox">
                                <div class="amenity-icon">
                                    <i class="fas fa-tshirt"></i>
                                </div>
                                <span>Secadora</span>
                                <input type="checkbox" class="checkbox-input" value="Secadora">
                            </div>

                            <div class="amenity-checkbox">
                                <div class="amenity-icon">
                                    <i class="fas fa-tv"></i>
                                </div>
                                <span>TV</span>
                                <input type="checkbox" class="checkbox-input" value="TV">
                            </div>

                            <div class="amenity-checkbox">
                                <div class="amenity-icon">
                                    <i class="fas fa-dumbbell"></i>
                                </div>
                                <span>Gimnasio</span>
                                <input type="checkbox" class="checkbox-input" value="Gimnasio">
                            </div>

                            <div class="amenity-checkbox">
                                <div class="amenity-icon">
                                    <i class="fas fa-baby"></i>
                                </div>
                                <span>Apto para niños</span>
                                <input type="checkbox" class="checkbox-input" value="Apto para niños">
                            </div>

                            <div class="amenity-checkbox">
                                <div class="amenity-icon">
                                    <i class="fas fa-paw"></i>
                                </div>
                                <span>Se admiten mascotas</span>
                                <input type="checkbox" class="checkbox-input" value="Se admiten mascotas">
                            </div>

                            <div class="amenity-checkbox">
                                <div class="amenity-icon">
                                    <i class="fas fa-smoking-ban"></i>
                                </div>
                                <span>No se permite fumar</span>
                                <input type="checkbox" class="checkbox-input" value="No se permite fumar">
                            </div>

                            <div class="amenity-checkbox">
                                <div class="amenity-icon">
                                    <i class="fas fa-concierge-bell"></i>
                                </div>
                                <span>Servicio de limpieza</span>
                                <input type="checkbox" class="checkbox-input" value="Servicio de limpieza">
                            </div>

                            <div class="amenity-checkbox">
                                <div class="amenity-icon">
                                    <i class="fas fa-mountain"></i>
                                </div>
                                <span>Vista panorámica</span>
                                <input type="checkbox" class="checkbox-input" value="Vista panorámica">
                            </div>
                        </div>
                    </section>
                </div>

                <!-- Right Column - Preview -->
                <div class="preview-card">
                    <div class="preview-header">
                        <h3 class="preview-title" id="preview-title">Tu increíble alojamiento</h3>
                        <p class="preview-location" id="preview-location">Ciudad, País</p>
                    </div>

                    <div class="preview-details">
                        <div class="detail-row">
                            <span>👥 Huéspedes:</span>
                            <span id="preview-capacidad">0</span>
                        </div>
                        <div class="detail-row">
                            <span>🛏️ Habitaciones:</span>
                            <span id="preview-habitaciones">0</span>
                        </div>
                        <div class="detail-row">
                            <span>🛌 Camas:</span>
                            <span id="preview-camas">0</span>
                        </div>
                        <div class="detail-row">
                            <span>🚿 Baños:</span>
                            <span id="preview-banos">0</span>
                        </div>
                    </div>

                    <div class="preview-price">
                        <span class="price-amount" id="preview-precio">0€</span>
                        <span class="price-period">por noche</span>
                    </div>

                    <div class="action-buttons">
                        <button type="button" class="btn-secondary" id="preview-btn" onclick="previewAccommodation()">
                            <i class="fas fa-eye"></i>
                            Vista previa
                        </button>
                        <button type="submit" class="btn-primary" id="submit-btn">
                            <i class="fas fa-home"></i>
                            Crear alojamiento
                        </button>
                    </div>

                    <div style="margin-top: 20px; padding-top: 20px; border-top: 2px solid rgba(255, 255, 255, 0.2); text-align: center;">
                        <small style="opacity: 0.8;">
                            <i class="fas fa-info-circle"></i>
                            Los cambios se guardan automáticamente
                        </small>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <!-- JavaScript -->
    <script src="/js/crear-alojamiento.js"></script>
</body>
</html>