<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alojamientos - Encuentra casas, apartamentos y experiencias únicas</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/css/main.css">
</head>
<body>
    <!-- Header -->
    <header>
        <div class="header-content">
            <a href="#" class="logo">
                <i class="fa-brands fa-airbnb"></i>
                airbnb
            </a>
            
            <div class="user-menu">
                <button id="abrirModal" class="btn-publicar become-host">Publicar Alojamiento</button>
                <div class="globe-icon">
                    <i class="fas fa-globe"></i>
                </div>
                <div class="user-profile">
                    <i class="fas fa-bars"></i>
                    <div class="user-avatar">
                        <i class="fas fa-user"></i>
                    </div>
                </div>
            </div>
        </div>
    </header>
    
    <!-- Filters Container -->
    <div class="filters-container">
        <!-- Categories Filter -->
        <div class="filters">
            <div class="filter-categories">
                <div id="categoriaTodos" class="category active">
                    <div class="category-icon">
                        <i class="fas fa-th"></i>
                    </div>
                    <div class="category-name">Todos</div>
                </div>
                <div class="category">
                    <div class="category-icon">
                        <i class="fas fa-wifi"></i>
                    </div>
                    <div class="category-name">Conectados</div>
                </div>
                <div class="category">
                    <div class="category-icon">
                        <i class="fas fa-utensils"></i>
                    </div>
                    <div class="category-name">Cocina equipada</div>
                </div>
                <div class="category">
                    <div class="category-icon">
                        <i class="fas fa-square-parking"></i>
                    </div>
                    <div class="category-name">Estacionamiento</div>
                </div>
                <div class="category">
                    <div class="category-icon">
                        <i class="fas fa-water-ladder"></i>
                    </div>
                    <div class="category-name">Piscinas</div>
                </div>
                <div class="category">
                    <div class="category-icon">
                        <i class="fas fa-hot-tub"></i>
                    </div>
                    <div class="category-name">Jacuzzi</div>
                </div>
                <div class="category">
                    <div class="category-icon">
                        <i class="fas fa-wind"></i>
                    </div>
                    <div class="category-name">Aire Acondicionado</div>
                </div>
            </div>
            
            <button class="toggle-filters-btn" id="toggleFilters">
                <i class="fas fa-sliders"></i>
                Filtros avanzados
                <i class="fas fa-chevron-down"></i>
            </button>
        </div>

        <!-- Advanced Filters -->
        <div class="advanced-filters" id="advancedFilters">
            <div class="filters-header">
                <h2 class="filters-title">
                    <i class="fas fa-filter"></i>
                    Filtros avanzados
                </h2>
                <div class="filters-actions">
                    <button class="stats-btn" onclick="showSearchStats()" title="Ver estadísticas">
                        <i class="fas fa-chart-bar"></i>
                        Estadísticas
                    </button>
                    <button class="export-btn" title="Exportar resultados">
                        <i class="fas fa-download"></i>
                        Exportar
                    </button>
                    <button class="share-btn" title="Compartir búsqueda">
                        <i class="fas fa-share"></i>
                        Compartir
                    </button>
                    <button class="clear-filters-btn" onclick="clearAllFilters()">
                        <i class="fas fa-times"></i>
                        Limpiar filtros
                    </button>
                </div>
            </div>

            <div class="filters-grid">
                <!-- Búsqueda por texto -->
                <div class="filter-group">
                    <label class="filter-label">
                        <i class="fas fa-search"></i>
                        Buscar por nombre o descripción
                    </label>
                    <input 
                        type="text" 
                        id="searchText" 
                        class="filter-input" 
                        placeholder="Ej: apartamento moderno, casa con jardín..."
                    >
                </div>

                <!-- Filtro de ubicación -->
                <div class="filter-group" style="position: relative;">
                    <label class="filter-label">
                        <i class="fas fa-map-marker-alt"></i>
                        Ubicación
                    </label>
                    <input 
                        type="text" 
                        id="locationFilter" 
                        class="filter-input" 
                        placeholder="Ej: Madrid, Barcelona, Valencia..."
                    >
                </div>

                <!-- Rango de precios -->
                <div class="filter-group">
                    <label class="filter-label">
                        <i class="fas fa-euro-sign"></i>
                        Precio por noche
                    </label>
                    <div class="price-range">
                        <input 
                            type="number" 
                            id="minPrice" 
                            class="filter-input" 
                            placeholder="Mín. €"
                            min="0"
                        >
                        <span class="price-separator">—</span>
                        <input 
                            type="number" 
                            id="maxPrice" 
                            class="filter-input" 
                            placeholder="Máx. €"
                            min="0"
                        >
                    </div>
                </div>

                <!-- Número de habitaciones -->
                <div class="filter-group">
                    <label class="filter-label">
                        <i class="fas fa-bed"></i>
                        Habitaciones
                    </label>
                    <select id="roomsFilter" class="filter-select">
                        <option value="">Cualquier número</option>
                        <option value="1">1 habitación</option>
                        <option value="2">2 habitaciones</option>
                        <option value="3">3 habitaciones</option>
                        <option value="4">4 habitaciones</option>
                        <option value="5">5+ habitaciones</option>
                    </select>
                </div>

                <!-- Tipo de alojamiento -->
                <div class="filter-group">
                    <label class="filter-label">
                        <i class="fas fa-home"></i>
                        Tipo de alojamiento
                    </label>
                    <select id="typeFilter" class="filter-select">
                        <option value="">Todos los tipos</option>
                        <option value="Apartamento">Apartamento</option>
                        <option value="Casa">Casa</option>
                        <option value="Estudio">Estudio</option>
                        <option value="Villa">Villa</option>
                        <option value="Loft">Loft</option>
                        <option value="Cabaña">Cabaña</option>
                    </select>
                </div>

                <!-- Capacidad de huéspedes -->
                <div class="filter-group">
                    <label class="filter-label">
                        <i class="fas fa-users"></i>
                        Número de huéspedes
                    </label>
                    <div class="capacity-selector">
                        <div class="capacity-btn" data-capacity="1">1</div>
                        <div class="capacity-btn" data-capacity="2">2</div>
                        <div class="capacity-btn" data-capacity="3">3</div>
                        <div class="capacity-btn" data-capacity="4">4</div>
                        <div class="capacity-btn" data-capacity="5">5</div>
                        <div class="capacity-btn" data-capacity="6">6+</div>
                    </div>
                </div>
            </div>

            <div class="search-actions">
                <button class="search-btn" onclick="applyAdvancedFilters()">
                    <i class="fas fa-search"></i>
                    Aplicar filtros
                </button>
                <div class="results-counter" id="resultsCounter">
                    <i class="fas fa-home"></i>
                    <span id="resultCount">0</span> alojamientos encontrados
                </div>
            </div>
        </div>
    </div>
    
    <!-- Listings -->
    <div id="listings" class="listings">
        <!-- Los alojamientos se generaran aquí -->
    </div>

    <!-- No Results State -->
    <div id="noResults" class="no-results" style="display: none;">
        <div class="no-results-icon">
            <i class="fas fa-search"></i>
        </div>
        <h3 class="no-results-title">No se encontraron alojamientos</h3>
        <p class="no-results-text">
            Prueba ajustando tus filtros o ampliando los criterios de búsqueda para encontrar más opciones.
        </p>
        <button class="modify-search-btn" onclick="clearAllFilters()">
            <i class="fas fa-redo"></i>
            Modificar búsqueda
        </button>
    </div>
    
    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <div class="footer-left">
                <span>© 2025 Alojamientos, Inc.</span>
                <span class="dot"></span>
                <a href="#" class="footer-link">Privacidad</a>
                <span class="dot"></span>
                <a href="#" class="footer-link">Términos</a>
                <span class="dot"></span>
                <a href="#" class="footer-link">Mapa del sitio</a>
            </div>
            
            <div class="footer-right">
                <div class="langcurrency">
                    <i class="fas fa-globe"></i>
                    <span>Español (ES)</span>
                </div>
                <div class="langcurrency">
                    <span>€ EUR</span>
                </div>
                <a href="#" class="footer-link">Soporte y recursos</a>
            </div>
        </div>
    </footer>

    <!-- JavaScript -->
    <script src="/js/main.js"></script>
    <script src="/js/session-manager.js"></script>

    <script>
        // Estado global de la aplicación
        var allAlojamientos = [];
        var filteredAlojamientos = [];
        var currentFilters = {
            searchText: '',
            location: '',
            minPrice: null,
            maxPrice: null,
            rooms: null,
            type: null,
            capacity: null,
            categories: ['todos'],
            services: ['none']
        };

        // Inicialización de la aplicación
        document.addEventListener('DOMContentLoaded', function() {
            initializeApp();
            setupEventListeners();
            loadAlojamientos();
            loadFiltersFromURL();
        });

        function initializeApp() {
            console.log('🚀 Inicializando aplicación de filtros avanzados...');
            
            // Configurar autocompletado de ubicación
            setupLocationAutocomplete();
            
            // Configurar validación de rangos de precio
            setupPriceValidation();
            
            // Cargar filtros guardados
            loadSavedFilters();
            
            // Actualizar contador inicial
            updateResultsCounter(0);
        }

        function setupEventListeners() {
            // Toggle de filtros avanzados
            document.getElementById('toggleFilters').addEventListener('click', toggleAdvancedFilters);
            
            // Búsqueda en tiempo real
            document.getElementById('searchText').addEventListener('input', debounce(handleSearchInput, 300));
            document.getElementById('locationFilter').addEventListener('input', debounce(handleLocationInput, 300));
            
            // Filtros de precio
            document.getElementById('minPrice').addEventListener('input', debounce(handlePriceInput, 500));
            document.getElementById('maxPrice').addEventListener('input', debounce(handlePriceInput, 500));
            
            // Selects
            document.getElementById('roomsFilter').addEventListener('change', handleSelectChange);
            document.getElementById('typeFilter').addEventListener('change', handleSelectChange);
            
            // Botones de capacidad
            document.querySelectorAll('.capacity-btn').forEach(function(btn) {
                btn.addEventListener('click', handleCapacityClick);
            });
            
            // Categorías (mantener funcionalidad existente)
            setupCategoryFilters();
            
            // Teclas de acceso rápido
            document.addEventListener('keydown', handleKeyboardShortcuts);
        }

        // Cargar alojamientos desde el servidor
        function loadAlojamientos() {
            console.log('📡 Cargando alojamientos desde el servidor...');
            showLoadingState();
            
            fetch("/alojamiento/getAll")
                .then(function(response) {
                    if (!response.ok) {
                        throw new Error('Error en la respuesta de la API');
                    }
                    return response.json();
                })
                .then(function(data) {
                    allAlojamientos = data;
                    filteredAlojamientos = allAlojamientos.slice();
                    
                    console.log('✅ ' + allAlojamientos.length + ' alojamientos cargados');
                    
                    // Mostrar todos los alojamientos inicialmente
                    return renderAlojamientos(filteredAlojamientos);
                })
                .then(function() {
                    updateResultsCounter(filteredAlojamientos.length);
                    hideLoadingState();
                })
                .catch(function(error) {
                    console.error('❌ Error al cargar alojamientos:', error);
                    showErrorState(error.message);
                });
        }

        // Renderizar alojamientos en el DOM
        function renderAlojamientos(alojamientos) {
            var listings = document.getElementById('listings');
            var noResults = document.getElementById('noResults');
            
            if (alojamientos.length === 0) {
                listings.style.display = 'none';
                noResults.style.display = 'block';
                return Promise.resolve();
            }
            
            listings.style.display = 'grid';
            noResults.style.display = 'none';
            listings.innerHTML = "";
            
            // Renderizar cada alojamiento
            var promises = alojamientos.map(function(alojamiento) {
                return Promise.all([
                    getMainImage(alojamiento.id),
                    getValoracionMedia(alojamiento.id),
                    getServiciosByAlojamientoId(alojamiento.id)
                ]).then(function(results) {
                    var mainImageUrl = results[0];
                    var valoracionMedia = results[1];
                    var servicios = results[2];
                    
                    var listingHTML = createListingHTML(alojamiento, mainImageUrl, valoracionMedia);
                    listings.innerHTML += listingHTML;
                }).catch(function(error) {
                    console.error('Error al renderizar alojamiento ' + alojamiento.id + ':', error);
                });
            });
            
            return Promise.all(promises).then(function() {
                // Agregar animaciones
                animateListings();
            });
        }

        function createListingHTML(alojamiento, mainImageUrl, valoracionMedia) {
            return '<div class="listing" onclick="window.location.href=\'/alojamiento/' + alojamiento.id + '/page\'" data-id="' + alojamiento.id + '">' +
                '<div class="listing-images">' +
                    '<img src="' + mainImageUrl + '" alt="' + alojamiento.titulo + '" class="listing-image" loading="lazy">' +
                    '<button class="like-button" onclick="event.stopPropagation(); toggleLike(this)">' +
                        '<i class="far fa-heart"></i>' +
                    '</button>' +
                '</div>' +
                '<div class="listing-info">' +
                    '<div class="listing-location">' +
                        '<div>' + alojamiento.ciudad + ', ' + alojamiento.pais + '</div>' +
                        '<div class="listing-rating">' +
                            '<i class="fas fa-star"></i>' +
                            '<span>' + valoracionMedia.toFixed(1) + '</span>' +
                        '</div>' +
                    '</div>' +
                    '<div class="listing-details">' + alojamiento.titulo + '</div>' +
                    '<div class="listing-details">' + alojamiento.tipoAlojamiento + ' • ' + alojamiento.capacidad + ' huéspedes • ' + alojamiento.habitaciones + ' habitaciones</div>' +
                    '<div class="listing-price"><span>' + alojamiento.precioNoche + '€</span> por noche</div>' +
                '</div>' +
            '</div>';
        }

        // Aplicar filtros avanzados
        function applyAdvancedFilters() {
            console.log('🔍 Aplicando filtros avanzados...');
            showFilterLoadingState();
            
            // Recopilar valores de los filtros
            currentFilters.searchText = document.getElementById('searchText').value.toLowerCase().trim();
            currentFilters.location = document.getElementById('locationFilter').value.toLowerCase().trim();
            currentFilters.minPrice = parseFloat(document.getElementById('minPrice').value) || null;
            currentFilters.maxPrice = parseFloat(document.getElementById('maxPrice').value) || null;
            currentFilters.rooms = document.getElementById('roomsFilter').value || null;
            currentFilters.type = document.getElementById('typeFilter').value || null;
            
            var activeCapacityBtn = document.querySelector('.capacity-btn.active');
            currentFilters.capacity = activeCapacityBtn ? activeCapacityBtn.dataset.capacity : null;
            
            console.log('📋 Filtros aplicados:', currentFilters);
            
            // Aplicar filtros
            filterAlojamientos(allAlojamientos, currentFilters).then(function(filtered) {
                filteredAlojamientos = filtered;
                
                // Renderizar resultados
                return renderAlojamientos(filteredAlojamientos);
            }).then(function() {
                updateResultsCounter(filteredAlojamientos.length);
                
                // Guardar filtros
                saveFiltersToLocalStorage();
                
                hideFilterLoadingState();
                
                // Mostrar notificación
                showNotification('🔍 ' + filteredAlojamientos.length + ' alojamientos encontrados', 'success');
            });
        }

        // Filtrar alojamientos según criterios
        function filterAlojamientos(alojamientos, filters) {
            var filtered = alojamientos.slice();
            
            // Filtro por texto (título y descripción)
            if (filters.searchText) {
                filtered = filtered.filter(function(alojamiento) {
                    return alojamiento.titulo.toLowerCase().indexOf(filters.searchText) !== -1 ||
                           alojamiento.descripcion.toLowerCase().indexOf(filters.searchText) !== -1;
                });
            }
            
            // Filtro por ubicación
            if (filters.location) {
                filtered = filtered.filter(function(alojamiento) {
                    var ciudadPais = alojamiento.ciudad + ', ' + alojamiento.pais;
                    return alojamiento.ciudad.toLowerCase().indexOf(filters.location) !== -1 ||
                           alojamiento.pais.toLowerCase().indexOf(filters.location) !== -1 ||
                           ciudadPais.toLowerCase().indexOf(filters.location) !== -1;
                });
            }
            
            // Filtro por precio
            if (filters.minPrice !== null) {
                filtered = filtered.filter(function(alojamiento) {
                    return alojamiento.precioNoche >= filters.minPrice;
                });
            }
            if (filters.maxPrice !== null) {
                filtered = filtered.filter(function(alojamiento) {
                    return alojamiento.precioNoche <= filters.maxPrice;
                });
            }
            
            // Filtro por habitaciones
            if (filters.rooms) {
                var roomsNum = parseInt(filters.rooms);
                if (roomsNum === 5) {
                    filtered = filtered.filter(function(alojamiento) {
                        return alojamiento.habitaciones >= 5;
                    });
                } else {
                    filtered = filtered.filter(function(alojamiento) {
                        return alojamiento.habitaciones === roomsNum;
                    });
                }
            }
            
            // Filtro por tipo
            if (filters.type) {
                filtered = filtered.filter(function(alojamiento) {
                    return alojamiento.tipoAlojamiento === filters.type;
                });
            }
            
            // Filtro por capacidad
            if (filters.capacity) {
                var capacityNum = parseInt(filters.capacity);
                if (capacityNum === 6) {
                    filtered = filtered.filter(function(alojamiento) {
                        return alojamiento.capacidad >= 6;
                    });
                } else {
                    filtered = filtered.filter(function(alojamiento) {
                        return alojamiento.capacidad >= capacityNum;
                    });
                }
            }
            
            // Filtros por categorías y servicios (mantener lógica existente)
            return filterByCategories(filtered, filters.categories, filters.services);
        }

        // Filtrar por categorías y servicios
        function filterByCategories(alojamientos, tipos, servicios) {
            var filtered = [];
            var promises = [];
            
            alojamientos.forEach(function(alojamiento) {
                var matchesTipo = tipos.indexOf('todos') !== -1 || tipos.indexOf(alojamiento.tipoAlojamiento) !== -1;
                
                if (matchesTipo && servicios.indexOf('none') !== -1) {
                    filtered.push(alojamiento);
                    return;
                }
                
                if (matchesTipo && servicios.indexOf('none') === -1) {
                    var promise = getServiciosByAlojamientoId(alojamiento.id)
                        .then(function(alojamientoServicios) {
                            var hasRequiredService = servicios.some(function(servicio) {
                                return alojamientoServicios.indexOf(servicio) !== -1;
                            });
                            
                            if (hasRequiredService) {
                                filtered.push(alojamiento);
                            }
                        })
                        .catch(function(error) {
                            console.error('Error al obtener servicios para alojamiento ' + alojamiento.id + ':', error);
                        });
                    
                    promises.push(promise);
                }
            });
            
            return Promise.all(promises).then(function() {
                return filtered;
            });
        }

        // Configurar autocompletado de ubicación
        function setupLocationAutocomplete() {
            var locationInput = document.getElementById('locationFilter');
            var suggestionBox = null;
            
            locationInput.addEventListener('input', function() {
                var query = this.value.trim();
                
                // Remover caja de sugerencias existente
                if (suggestionBox) {
                    suggestionBox.remove();
                    suggestionBox = null;
                }
                
                if (query.length < 2) return;
                
                getLocationSuggestions(query).then(function(suggestions) {
                    if (suggestions.length === 0) return;
                    
                    // Crear caja de sugerencias
                    suggestionBox = createSuggestionBox(suggestions, locationInput);
                });
            });
            
            // Cerrar sugerencias al hacer clic fuera
            document.addEventListener('click', function(e) {
                if (!locationInput.contains(e.target) && suggestionBox && !suggestionBox.contains(e.target)) {
                    suggestionBox.remove();
                    suggestionBox = null;
                }
            });
        }

        // Obtener sugerencias de ubicación
        function getLocationSuggestions(query) {
            return new Promise(function(resolve) {
                try {
                    // Obtener ubicaciones únicas de los alojamientos cargados
                    var locations = new Set();
                    allAlojamientos.forEach(function(alojamiento) {
                        locations.add(alojamiento.ciudad);
                        locations.add(alojamiento.pais);
                        locations.add(alojamiento.ciudad + ', ' + alojamiento.pais);
                    });
                    
                    // Filtrar por coincidencias
                    var filtered = Array.from(locations)
                        .filter(function(location) {
                            return location.toLowerCase().indexOf(query.toLowerCase()) !== -1;
                        })
                        .sort()
                        .slice(0, 5);
                    
                    resolve(filtered);
                } catch (error) {
                    console.error('Error al obtener sugerencias:', error);
                    resolve([]);
                }
            });
        }

        // Crear caja de sugerencias
        function createSuggestionBox(suggestions, input) {
            var suggestionBox = document.createElement('div');
            suggestionBox.className = 'location-suggestions';
            
            suggestions.forEach(function(suggestion) {
                var item = document.createElement('div');
                item.className = 'suggestion-item';
                item.innerHTML = '<i class="fas fa-map-marker-alt" style="margin-right: 10px; color: #667eea;"></i>' + suggestion;
                
                item.addEventListener('click', function() {
                    input.value = suggestion;
                    suggestionBox.remove();
                    applyAdvancedFilters();
                });
                
                suggestionBox.appendChild(item);
            });
            
            // Posicionar la caja
            var inputContainer = input.closest('.filter-group');
            inputContainer.style.position = 'relative';
            inputContainer.appendChild(suggestionBox);
            
            return suggestionBox;
        }

        // Configurar validación de precios
        function setupPriceValidation() {
            var minPrice = document.getElementById('minPrice');
            var maxPrice = document.getElementById('maxPrice');
            
            minPrice.addEventListener('input', function() {
                validatePriceInput(this);
                var min = parseFloat(this.value);
                var max = parseFloat(maxPrice.value);
                
                if (min < 0) {
                    this.value = 0;
                }
                
                if (max && min > max) {
                    maxPrice.value = min;
                    validatePriceInput(maxPrice);
                }
            });
            
            maxPrice.addEventListener('input', function() {
                validatePriceInput(this);
                var min = parseFloat(minPrice.value);
                var max = parseFloat(this.value);
                
                if (max < 0) {
                    this.value = 0;
                }
                
                if (min && max < min) {
                    minPrice.value = max;
                    validatePriceInput(minPrice);
                }
            });
        }

        function validatePriceInput(input) {
            var value = parseFloat(input.value);
            input.classList.remove('invalid', 'valid');
            
            if (input.value === '') {
                return;
            }
            
            if (isNaN(value) || value < 0) {
                input.classList.add('invalid');
            } else {
                input.classList.add('valid');
            }
        }

        // Manejar eventos de entrada
        function handleSearchInput(event) {
            var value = event.target.value.trim();
            if (value.length >= 2 || value.length === 0) {
                applyAdvancedFilters();
            }
        }

        function handleLocationInput(event) {
            var value = event.target.value.trim();
            if (value.length >= 2 || value.length === 0) {
                applyAdvancedFilters();
            }
        }

        function handlePriceInput() {
            applyAdvancedFilters();
        }

        function handleSelectChange() {
            applyAdvancedFilters();
        }

        function handleCapacityClick(event) {
            var btn = event.currentTarget;
            var isActive = btn.classList.contains('active');
            
            // Remover activo de todos los botones
            document.querySelectorAll('.capacity-btn').forEach(function(b) {
                b.classList.remove('active');
            });
            
            // Si no estaba activo, activarlo
            if (!isActive) {
                btn.classList.add('active');
            }
            
            applyAdvancedFilters();
        }

        // Toggle filtros avanzados
        function toggleAdvancedFilters() {
            var filters = document.getElementById('advancedFilters');
            var toggleBtn = document.getElementById('toggleFilters');
            
            filters.classList.toggle('show');
            toggleBtn.classList.toggle('active');
            
            if (filters.classList.contains('show')) {
                filters.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        }

        // Configurar filtros de categorías (mantener funcionalidad existente)
        function setupCategoryFilters() {
            var tipo = ['todos'];
            var servicio = ['none'];
            
            document.querySelectorAll('.category').forEach(function(category) {
                category.addEventListener('click', function() {
                    this.classList.toggle('active');
                    
                    if (this.classList.contains('active')) {
                        var nombreCategoria = this.querySelector('.category-name').textContent.trim();
                        var categoriaTodos = document.querySelector('#categoriaTodos');
                        
                        if (nombreCategoria !== 'Todos') {
                            categoriaTodos.classList.remove('active');
                            if (tipo.indexOf('todos') !== -1) {
                                tipo = [];
                            }
                            if (servicio.indexOf('none') !== -1) {
                                servicio = [];
                            }
                        }
                        
                        // Lógica de categorías
                        switch (nombreCategoria) {
                            case 'Todos':
                                document.querySelectorAll('.category').forEach(function(c) {
                                    c.classList.remove('active');
                                });
                                this.classList.add('active');
                                tipo = ['todos'];
                                servicio = ['none'];
                                break;
                            case 'Casas':
                                tipo.push('Casa');
                                break;
                            case 'Estudio':
                                tipo.push('Estudio');
                                break;
                            case 'Apartamentos':
                                tipo.push('Apartamento');
                                break;
                            case 'Conectados':
                                servicio.push('WiFi');
                                break;
                            case 'Cocina equipada':
                                servicio.push('Cocina');
                                break;
                            case 'Estacionamiento':
                                servicio.push('Estacionamiento gratuito');
                                break;
                            case 'Piscinas':
                                servicio.push('Piscina');
                                break;
                            case 'Jacuzzi':
                                servicio.push('Jacuzzi');
                                break;
                            case 'Aire Acondicionado':
                                servicio.push('Aire acondicionado');
                                break;
                        }
                    } else {
                        // Lógica para remover categorías
                        var nombreCategoria = this.querySelector('.category-name').textContent.trim();
                        switch (nombreCategoria) {
                            case 'Casas':
                                tipo = tipo.filter(function(t) { return t !== 'Casa'; });
                                break;
                            case 'Estudio':
                                tipo = tipo.filter(function(t) { return t !== 'Estudio'; });
                                break;
                            case 'Apartamentos':
                                tipo = tipo.filter(function(t) { return t !== 'Apartamento'; });
                                break;
                            case 'Conectados':
                                servicio = servicio.filter(function(s) { return s !== 'WiFi'; });
                                break;
                            case 'Cocina equipada':
                                servicio = servicio.filter(function(s) { return s !== 'Cocina'; });
                                break;
                            case 'Estacionamiento':
                                servicio = servicio.filter(function(s) { return s !== 'Estacionamiento gratuito'; });
                                break;
                            case 'Piscinas':
                                servicio = servicio.filter(function(s) { return s !== 'Piscina'; });
                                break;
                            case 'Jacuzzi':
                                servicio = servicio.filter(function(s) { return s !== 'Jacuzzi'; });
                                break;
                            case 'Aire Acondicionado':
                                servicio = servicio.filter(function(s) { return s !== 'Aire acondicionado'; });
                                break;
                        }
                    }
                    
                    if (servicio.length === 0) {
                        servicio.push('none');
                    }
                    if (tipo.length === 0) {
                        tipo.push('todos');
                    }
                    
                    // Actualizar filtros globales
                    currentFilters.categories = tipo;
                    currentFilters.services = servicio;
                    
                    applyAdvancedFilters();
                });
            });
        }

        // Limpiar todos los filtros
        function clearAllFilters() {
            // Limpiar inputs
            document.getElementById('searchText').value = '';
            document.getElementById('locationFilter').value = '';
            document.getElementById('minPrice').value = '';
            document.getElementById('maxPrice').value = '';
            document.getElementById('roomsFilter').value = '';
            document.getElementById('typeFilter').value = '';
            
            // Limpiar capacidad
            document.querySelectorAll('.capacity-btn').forEach(function(btn) {
                btn.classList.remove('active');
            });
            
            // Limpiar categorías
            document.querySelectorAll('.category').forEach(function(c) {
                c.classList.remove('active');
            });
            document.getElementById('categoriaTodos').classList.add('active');
            
            // Limpiar validaciones
            document.querySelectorAll('.filter-input').forEach(function(input) {
                input.classList.remove('invalid', 'valid');
            });
            
            // Resetear filtros
            currentFilters = {
                searchText: '',
                location: '',
                minPrice: null,
                maxPrice: null,
                rooms: null,
                type: null,
                capacity: null,
                categories: ['todos'],
                services: ['none']
            };
            
            // Mostrar todos los alojamientos
            filteredAlojamientos = allAlojamientos.slice();
            renderAlojamientos(filteredAlojamientos);
            updateResultsCounter(filteredAlojamientos.length);
            
            showNotification('🧹 Filtros limpiados', 'success');
        }

        // Funciones de utilidad
        function updateResultsCounter(count) {
            var counter = document.getElementById('resultCount');
            var container = document.getElementById('resultsCounter');
            
            if (counter) {
                counter.textContent = count;
                container.classList.add('updating');
                setTimeout(function() {
                    container.classList.remove('updating');
                }, 500);
            }
        }

        function showLoadingState() {
            var listings = document.getElementById('listings');
            listings.innerHTML = '<div class="filter-loading" style="grid-column: 1/-1; text-align: center; padding: 50px;">Cargando alojamientos...</div>';
        }

        function hideLoadingState() {
            // Se maneja automáticamente al renderizar
        }

        function showFilterLoadingState() {
            var searchBtn = document.querySelector('.search-btn');
            searchBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Buscando...';
            searchBtn.disabled = true;
        }

        function hideFilterLoadingState() {
            var searchBtn = document.querySelector('.search-btn');
            searchBtn.innerHTML = '<i class="fas fa-search"></i> Aplicar filtros';
            searchBtn.disabled = false;
        }

        function showErrorState(message) {
            var listings = document.getElementById('listings');
            listings.innerHTML = '<div style="grid-column: 1/-1; text-align: center; padding: 50px; color: #ff6b6b;">' +
                '<i class="fas fa-exclamation-triangle" style="font-size: 3rem; margin-bottom: 20px;"></i>' +
                '<h3>Error al cargar alojamientos</h3>' +
                '<p>' + message + '</p>' +
                '<button onclick="location.reload()" class="modify-search-btn" style="margin-top: 20px;">' +
                    'Intentar de nuevo' +
                '</button>' +
            '</div>';
        }

        function animateListings() {
            var listings = document.querySelectorAll('.listing');
            listings.forEach(function(listing, index) {
                listing.style.opacity = '0';
                listing.style.transform = 'translateY(20px)';
                setTimeout(function() {
                    listing.style.transition = 'all 0.4s ease';
                    listing.style.opacity = '1';
                    listing.style.transform = 'translateY(0)';
                }, index * 50);
            });
        }

        function toggleLike(button) {
            var icon = button.querySelector('i');
            if (icon.classList.contains('far')) {
                icon.classList.remove('far');
                icon.classList.add('fas');
                icon.style.color = '#ff385c';
                showNotification('❤️ Añadido a favoritos', 'success');
            } else {
                icon.classList.remove('fas');
                icon.classList.add('far');
                icon.style.color = '';
                showNotification('💔 Eliminado de favoritos', 'info');
            }
        }

        // Funciones de utilidad avanzadas
        function debounce(func, wait) {
            var timeout;
            return function executedFunction() {
                var context = this;
                var args = arguments;
                var later = function() {
                    clearTimeout(timeout);
                    func.apply(context, args);
                };
                clearTimeout(timeout);
                timeout = setTimeout(later, wait);
            };
        }

        function saveFiltersToLocalStorage() {
            try {
                localStorage.setItem('airbnb_filters', JSON.stringify(currentFilters));
            } catch (error) {
                console.error('Error guardando filtros:', error);
            }
        }

        function loadSavedFilters() {
            try {
                var saved = localStorage.getItem('airbnb_filters');
                if (saved) {
                    var filters = JSON.parse(saved);
                    
                    // Restaurar valores en los inputs
                    if (filters.searchText) document.getElementById('searchText').value = filters.searchText;
                    if (filters.location) document.getElementById('locationFilter').value = filters.location;
                    if (filters.minPrice) document.getElementById('minPrice').value = filters.minPrice;
                    if (filters.maxPrice) document.getElementById('maxPrice').value = filters.maxPrice;
                    if (filters.rooms) document.getElementById('roomsFilter').value = filters.rooms;
                    if (filters.type) document.getElementById('typeFilter').value = filters.type;
                    
                    if (filters.capacity) {
                        var capacityBtn = document.querySelector('[data-capacity="' + filters.capacity + '"]');
                        if (capacityBtn) capacityBtn.classList.add('active');
                    }
                    
                    // Merge con filtros actuales
                    Object.keys(filters).forEach(function(key) {
                        currentFilters[key] = filters[key];
                    });
                }
            } catch (error) {
                console.error('Error al cargar filtros guardados:', error);
            }
        }

        function loadFiltersFromURL() {
            var urlParams = new URLSearchParams(window.location.search);
            
            // Cargar parámetros de la URL si existen
            var searchText = urlParams.get('search');
            var location = urlParams.get('location');
            var minPrice = urlParams.get('minPrice');
            var maxPrice = urlParams.get('maxPrice');
            var capacity = urlParams.get('capacity');
            var rooms = urlParams.get('rooms');
            var type = urlParams.get('type');
            
            if (searchText) document.getElementById('searchText').value = searchText;
            if (location) document.getElementById('locationFilter').value = location;
            if (minPrice) document.getElementById('minPrice').value = minPrice;
            if (maxPrice) document.getElementById('maxPrice').value = maxPrice;
            if (rooms) document.getElementById('roomsFilter').value = rooms;
            if (type) document.getElementById('typeFilter').value = type;
            
            if (capacity) {
                var capacityBtn = document.querySelector('[data-capacity="' + capacity + '"]');
                if (capacityBtn) {
                    document.querySelectorAll('.capacity-btn').forEach(function(btn) {
                        btn.classList.remove('active');
                    });
                    capacityBtn.classList.add('active');
                }
            }
            
            // Aplicar filtros si hay alguno en la URL
            if (searchText || location || minPrice || maxPrice || capacity || rooms || type) {
                setTimeout(function() {
                    applyAdvancedFilters();
                    document.getElementById('advancedFilters').classList.add('show');
                    document.getElementById('toggleFilters').classList.add('active');
                }, 500);
            }
        }

        function handleKeyboardShortcuts(event) {
            // Ctrl + F para abrir filtros
            if (event.ctrlKey && event.key === 'f') {
                event.preventDefault();
                document.getElementById('searchText').focus();
            }
            
            // Escape para cerrar filtros
            if (event.key === 'Escape') {
                var filters = document.getElementById('advancedFilters');
                if (filters.classList.contains('show')) {
                    toggleAdvancedFilters();
                }
            }
            
            // Ctrl + K para limpiar filtros
            if (event.ctrlKey && event.key === 'k') {
                event.preventDefault();
                clearAllFilters();
            }
        }

        function showSearchStats() {
            if (filteredAlojamientos.length === 0) {
                showNotification('📊 No hay datos para mostrar estadísticas', 'error');
                return;
            }
            
            var stats = calculateSearchStats();
            displayStatsModal(stats);
        }

        function calculateSearchStats() {
            var precios = filteredAlojamientos.map(function(a) { return a.precioNoche; });
            var capacidades = filteredAlojamientos.map(function(a) { return a.capacidad; });
            var habitaciones = filteredAlojamientos.map(function(a) { return a.habitaciones; });
            
            // Calcular estadísticas básicas
            var precioPromedio = precios.reduce(function(a, b) { return a + b; }, 0) / precios.length;
            var precioMin = Math.min.apply(Math, precios);
            var precioMax = Math.max.apply(Math, precios);
            
            var capacidadPromedio = capacidades.reduce(function(a, b) { return a + b; }, 0) / capacidades.length;
            var habitacionesPromedio = habitaciones.reduce(function(a, b) { return a + b; }, 0) / habitaciones.length;
            
            // Tipos más comunes
            var tipos = {};
            filteredAlojamientos.forEach(function(a) {
                tipos[a.tipoAlojamiento] = (tipos[a.tipoAlojamiento] || 0) + 1;
            });
            
            var tiposMasComunes = Object.keys(tipos).map(function(key) {
                return [key, tipos[key]];
            }).sort(function(a, b) {
                return b[1] - a[1];
            }).slice(0, 3);
            
            // Ciudades más comunes
            var ciudades = {};
            filteredAlojamientos.forEach(function(a) {
                var ciudad = a.ciudad + ', ' + a.pais;
                ciudades[ciudad] = (ciudades[ciudad] || 0) + 1;
            });
            
            var ciudadesMasComunes = Object.keys(ciudades).map(function(key) {
                return [key, ciudades[key]];
            }).sort(function(a, b) {
                return b[1] - a[1];
            }).slice(0, 3);
            
            return {
                total: filteredAlojamientos.length,
                precioPromedio: precioPromedio.toFixed(2),
                precioMin: precioMin,
                precioMax: precioMax,
                capacidadPromedio: capacidadPromedio.toFixed(1),
                habitacionesPromedio: habitacionesPromedio.toFixed(1),
                tiposMasComunes: tiposMasComunes,
                ciudadesMasComunes: ciudadesMasComunes
            };
        }

        function displayStatsModal(stats) {
            var modal = document.createElement('div');
            modal.className = 'stats-modal';
            modal.style.cssText = 'position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.8); backdrop-filter: blur(5px); display: flex; align-items: center; justify-content: center; z-index: 10000; animation: fadeIn 0.3s ease;';
            
            var tiposHTML = stats.tiposMasComunes.map(function(item) {
                return '<div style="display: flex; justify-content: space-between; margin-bottom: 8px; padding: 5px 0;"><span>' + item[0] + '</span><span style="font-weight: 600; color: #667eea;">' + item[1] + '</span></div>';
            }).join('');
            
            var ciudadesHTML = stats.ciudadesMasComunes.map(function(item) {
                return '<div style="display: flex; justify-content: space-between; margin-bottom: 8px; padding: 5px 0;"><span style="font-size: 0.9rem;">' + item[0] + '</span><span style="font-weight: 600; color: #667eea;">' + item[1] + '</span></div>';
            }).join('');
            
            modal.innerHTML = '<div style="background: linear-gradient(135deg, rgba(255, 255, 255, 0.95), rgba(248, 249, 250, 0.95)); backdrop-filter: blur(15px); padding: 40px; border-radius: 25px; max-width: 600px; width: 90%; max-height: 80vh; overflow-y: auto; box-shadow: 0 25px 70px rgba(0, 0, 0, 0.3); border: 1px solid rgba(255, 255, 255, 0.2);">' +
                '<div style="text-align: center; margin-bottom: 30px;">' +
                    '<h2 style="font-size: 2rem; font-weight: 700; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; margin-bottom: 10px;">📊 Estadísticas de búsqueda</h2>' +
                    '<p style="color: #666; font-size: 1.1rem;">Análisis de ' + stats.total + ' alojamientos encontrados</p>' +
                '</div>' +
                
                '<div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 30px;">' +
                    '<div style="background: rgba(102, 126, 234, 0.1); padding: 20px; border-radius: 15px; text-align: center;"><div style="font-size: 2rem; font-weight: 700; color: #667eea; margin-bottom: 5px;">' + stats.total + '</div><div style="color: #333; font-weight: 600;">Alojamientos</div></div>' +
                    '<div style="background: rgba(255, 107, 107, 0.1); padding: 20px; border-radius: 15px; text-align: center;"><div style="font-size: 2rem; font-weight: 700; color: #ff6b6b; margin-bottom: 5px;">' + stats.precioPromedio + '€</div><div style="color: #333; font-weight: 600;">Precio promedio</div></div>' +
                    '<div style="background: rgba(81, 207, 102, 0.1); padding: 20px; border-radius: 15px; text-align: center;"><div style="font-size: 2rem; font-weight: 700; color: #51cf66; margin-bottom: 5px;">' + stats.capacidadPromedio + '</div><div style="color: #333; font-weight: 600;">Huéspedes promedio</div></div>' +
                    '<div style="background: rgba(255, 212, 59, 0.1); padding: 20px; border-radius: 15px; text-align: center;"><div style="font-size: 2rem; font-weight: 700; color: #ffd43b; margin-bottom: 5px;">' + stats.habitacionesPromedio + '</div><div style="color: #333; font-weight: 600;">Habitaciones promedio</div></div>' +
                '</div>' +
                
                '<div style="background: rgba(255, 255, 255, 0.8); padding: 25px; border-radius: 20px; margin-bottom: 20px;">' +
                    '<h3 style="margin-bottom: 15px; color: #333; font-size: 1.3rem;">💰 Rango de precios</h3>' +
                    '<div style="display: flex; justify-content: space-between; align-items: center;">' +
                        '<span style="font-weight: 600;">Mínimo: ' + stats.precioMin + '€</span>' +
                        '<span style="color: #667eea;">━━━━━━━</span>' +
                        '<span style="font-weight: 600;">Máximo: ' + stats.precioMax + '€</span>' +
                    '</div>' +
                '</div>' +
                
                '<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 30px;">' +
                    '<div style="background: rgba(255, 255, 255, 0.8); padding: 20px; border-radius: 15px;"><h4 style="margin-bottom: 15px; color: #333;">🏠 Tipos más populares</h4>' + tiposHTML + '</div>' +
                    '<div style="background: rgba(255, 255, 255, 0.8); padding: 20px; border-radius: 15px;"><h4 style="margin-bottom: 15px; color: #333;">📍 Destinos populares</h4>' + ciudadesHTML + '</div>' +
                '</div>' +
                
                '<div style="text-align: center;">' +
                    '<button onclick="this.closest(\'.stats-modal\').remove()" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; padding: 15px 30px; border-radius: 25px; font-weight: 600; cursor: pointer; font-size: 16px; box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform=\'translateY(-3px)\'" onmouseout="this.style.transform=\'translateY(0)\'"><i class="fas fa-check" style="margin-right: 8px;"></i>Cerrar estadísticas</button>' +
                '</div>' +
            '</div>';
            
            document.body.appendChild(modal);
            
            // Cerrar modal al hacer clic fuera
            modal.addEventListener('click', function(e) {
                if (e.target === modal) {
                    modal.remove();
                }
            });
            
            // Cerrar con Escape
            var closeHandler = function(e) {
                if (e.key === 'Escape') {
                    modal.remove();
                    document.removeEventListener('keydown', closeHandler);
                }
            };
            document.addEventListener('keydown', closeHandler);
        }

        function showNotification(message, type) {
            type = type || 'info';
            var notification = document.createElement('div');
            notification.className = 'notification ' + type;
            notification.textContent = message;
            
            var colors = {
                success: '#51cf66',
                error: '#ff6b6b',
                info: '#667eea',
                warning: '#ffd43b'
            };
            
            notification.style.cssText = 'position: fixed; top: 20px; right: 20px; background: ' + (colors[type] || colors.info) + '; color: ' + (type === 'warning' ? '#333' : 'white') + '; padding: 15px 25px; border-radius: 15px; z-index: 10000; font-weight: 600; box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2); transform: translateX(120%); transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1); backdrop-filter: blur(10px); font-size: 14px; max-width: 300px;';
            
            document.body.appendChild(notification);
            
            // Animar entrada
            setTimeout(function() {
                notification.style.transform = 'translateX(0)';
            }, 100);
            
            // Remover después de 4 segundos
            setTimeout(function() {
                notification.style.transform = 'translateX(120%)';
                setTimeout(function() {
                    if (notification.parentNode) {
                        notification.parentNode.removeChild(notification);
                    }
                }, 400);
            }, 4000);
            
            // Remover al hacer clic
            notification.addEventListener('click', function() {
                notification.style.transform = 'translateX(120%)';
                setTimeout(function() {
                    if (notification.parentNode) {
                        notification.parentNode.removeChild(notification);
                    }
                }, 400);
            });
        }

        // Funciones API existentes (mantener compatibilidad)
        function getAlojamientos() {
            return fetch("http://localhost:8080/alojamiento/getAll")
                .then(function(response) {
                    if (!response.ok) {
                        throw new Error('Error en la respuesta de la API para obtener los alojamientos');
                    }
                    return response.json();
                });
        }

        function getMainImage(alojamientoId) {
            return fetch("http://localhost:8080/alojamiento/imagenes/mainImagen/" + alojamientoId)
                .then(function(response) {
                    if (!response.ok) {
                        return '/img/default-property.jpg';
                    }
                    return response.text();
                })
                .catch(function(error) {
                    console.error('Error al obtener imagen:', error);
                    return '/img/default-property.jpg';
                });
        }

        function getValoracionMedia(alojamientoId) {
            return fetch("http://localhost:8080/alojamiento/valoraciones/media/" + alojamientoId)
                .then(function(response) {
                    if (!response.ok) {
                        return 0;
                    }
                    return response.json();
                })
                .catch(function(error) {
                    console.error('Error al obtener valoración:', error);
                    return 0;
                });
        }

        function getServiciosByAlojamientoId(alojamientoId) {
            return fetch("http://localhost:8080/servicios?alojamientoId=" + alojamientoId)
                .then(function(response) {
                    if (!response.ok) {
                        return [];
                    }
                    return response.json();
                })
                .catch(function(error) {
                    console.error('Error al obtener servicios:', error);
                    return [];
                });
        }

        // Configuración inicial para botones y funcionalidad existente
        document.addEventListener('DOMContentLoaded', function() {
            // Funcionalidad del botón "Publicar Alojamiento"
            var btnPublicar = document.getElementById('abrirModal');
            if (btnPublicar) {
                btnPublicar.addEventListener('click', function(e) {
                    e.preventDefault();
                    
                    // Verificar si el usuario está logueado
                    if (typeof sessionManager === 'undefined' || !sessionManager.checkSession()) {
                        window.location.href = '/login';
                        return;
                    }
                    
                    // Redirigir a la nueva página de crear alojamiento
                    window.location.href = '/crear-alojamiento';
                });
            }

            // Funcionalidad del perfil de usuario
            var userProfile = document.querySelector('.user-profile');
            if (userProfile) {
                userProfile.addEventListener('click', function(e) {
                    e.preventDefault();
                    
                    if (typeof sessionManager === 'undefined' || !sessionManager.checkSession()) {
                        window.location.href = '/login';
                    }
                });
            }
        });

        console.log('🎉 Sistema de filtros avanzados inicializado correctamente');
    </script>
</body>
</html>