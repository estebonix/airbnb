<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alojamientos - Encuentra casas, apartamentos y experiencias únicas</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/main.css">
</head>
<body>
    <!-- Header -->
    <header>
        <div class="header-content">
            <a href="#" class="logo">
                <i class="fa-brands fa-airbnb"></i>
                airbnb
            </a>
            
            <div class="search-bar">
                <button class="search-button search-anywhere">Cualquier lugar</button>
                <div class="search-divider"></div>
                <button class="search-button search-dates">Cualquier semana</button>
                <div class="search-divider"></div>
                <button class="search-button search-guests">Añadir huéspedes</button>
                <div class="search-icon">
                    <i class="fas fa-search fa-sm"></i>
                </div>
            </div>
            
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
    
    <!-- Filters -->
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
                    <i class="fas fa-house"></i>
                </div>
                <div class="category-name">Casas</div>
            </div>
            <div class="category">
                <div class="category-icon">
                    <i class="fas fa-door-open"></i>
                </div>
                <div class="category-name">Estudio</div>
            </div>
            <div class="category">
                <div class="category-icon">
                    <i class="fas fa-building"></i>
                </div>
                <div class="category-name">Apartamentos</div>
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
                <div class="category-name">Estacionamiento gratuito</div>
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
            <div class="category">
                <div class="category-icon">
                    <i class="fas fa-fire"></i>
                </div>
                <div class="category-name">Calefacción</div>
            </div>
            <div class="category">
                <div class="category-icon">
                    <i class="fas fa-soap"></i>
                </div>
                <div class="category-name">Lavadora</div>
            </div>
            <div class="category">
                <div class="category-icon">
                    <i class="fas fa-tshirt"></i>
                </div>
                <div class="category-name">Secadora</div>
            </div>
            <div class="category">
                <div class="category-icon">
                    <i class="fas fa-tv"></i>
                </div>
                <div class="category-name">TV</div>
            </div>
        </div>
        
        <button class="filters-button">
            <i class="fas fa-sliders"></i>
            Filtros
        </button>
    </div>
    
    <!-- Listings -->
    <div id="listings" class="listings">
        <!-- Los alojamientos se generaran aquí -->
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

    <!-- Modal para publicar alojamiento -->
    <div id="modalAlojamiento">
        <div class="modal-contenido">
            <span class="cerrar" id="cerrarModal">&times;</span>

            <h1>Publicar nuevo alojamiento</h1>

            <label for="titulo">Título</label>
            <input type="text" id="titulo" name="titulo" required>

            <label for="descripcion">Descripción</label>
            <textarea id="descripcion" name="descripcion" rows="4" placeholder="Describe tu alojamiento..."></textarea>

            <label for="tipo_alojamiento">Tipo de Alojamiento</label>
            <select id="tipo_alojamiento" name="tipo_alojamiento" required>
                <option value="">Seleccione</option>
                <option value="Apartamento">Apartamento</option>
                <option value="Casa">Casa</option>
                <option value="Estudio">Estudio</option>
            </select>

            <label for="capacidad">Capacidad</label>
            <input type="number" id="capacidad" name="capacidad" required>

            <label for="habitaciones">Habitaciones</label>
            <input type="number" id="habitaciones" name="habitaciones" required>

            <label for="camas">Camas</label>
            <input type="number" id="camas" name="camas" min=1 required>

            <label for="banos">Baños</label>
            <input type="number" id="banos" name="banos" min=1 required>

            <label for="precio_noche">Precio por Noche (€)</label>
            <input type="number" step="0.01" id="precio_noche" name="precio_noche" required>

            <label for="direccion">Dirección</label>
            <input type="text" id="direccion" name="direccion" required>

            <label for="ciudad">Ciudad</label>
            <input type="text" id="ciudad" name="ciudad" required>

            <label for="pais">País</label>
            <input type="text" id="pais" name="pais" required>

            <label for="codigo_postal">Código Postal</label>
            <input type="text" id="codigo_postal" name="codigo_postal">

            <label>Servicios incluidos</label>
            <div class="checkbox-group">
                <label><input type="checkbox" name="wifi" value="1"> WiFi</label>
                <label><input type="checkbox" name="cocina" value="1"> Cocina</label>
                <label><input type="checkbox" name="estacionamiento" value="1"> Estacionamiento</label>
                <label><input type="checkbox" name="piscina" value="1"> Piscina</label>
            </div>

            <label for="disponible">¿Disponible?</label>
            <select id="disponible" name="disponible">
                <option value="1" selected>Sí</option>
                <option value="0">No</option>
            </select>

            <label for="imagen">Imagenes del alojamiento</label>
            <input type="file" id="imagen" name="imagen" accept="image/*" multiple>

            <button onclick="createAlojamiento()">Publicar Alojamiento</button>
        </div>
    </div>

    <script src="js/main.js"></script>
    <script src="js/newAlojamiento.js"></script>
    <script>
        mostrarAlojamientos("todos", "none");

        // Script para controlar el modal
        const modal = document.getElementById("modalAlojamiento");
        const btn = document.getElementById("abrirModal");
        const span = document.getElementById("cerrarModal");

        btn.onclick = () => modal.style.display = "block";
        span.onclick = () => modal.style.display = "none";
        window.onclick = (event) => {
            if (event.target === modal) {
            modal.style.display = "none";
            }
        };

        // Agregar funcionalidad de me gusta
        document.querySelectorAll('.like-button').forEach(button => {
            button.addEventListener('click', function(e) {
                e.stopPropagation();
                const icon = this.querySelector('i');
                if (icon.classList.contains('far')) {
                    icon.classList.remove('far');
                    icon.classList.add('fas');
                    icon.style.color = '#ff385c';
                } else {
                    icon.classList.remove('fas');
                    icon.classList.add('far');
                    icon.style.color = '';
                }
            });
        });
        
        let tipo = [];
        let servicio = [];
        // Funcionalidad de categorías
        document.querySelectorAll('.category').forEach(category => {
            category.addEventListener('click', function() {
                this.classList.toggle('active');
                if(this.classList.contains('active')){
                    const nombreCategoria = this.querySelector('.category-name').textContent.trim();
                    const categoriaTodos = document.querySelector('#categoriaTodos');
                    if (nombreCategoria !== 'Todos') {
                        categoriaTodos.classList.remove('active');
                        if(tipo.includes('todos')) {
                            tipo = [];
                        }
                        if(servicio.includes('none')) {
                            servicio = [];
                        }
                    }   
                    switch (nombreCategoria) {
                    case 'Todos':
                        document.querySelectorAll('.category').forEach(c => { c.classList.remove('active') });
                        this.classList.add('active');
                        tipo = [];
                        servicio = [];
                        servicio.push('none');
                        tipo.push('todos');
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
                    case 'Estacionamiento gratuito':
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
                    case 'Calefacción':
                        servicio.push('Calefacción');
                        break;
                    case 'Lavadora':
                        tipo.push('Lavadora');
                        break;
                    case 'Secadora':
                        servicio.push('Secadora');
                        break;
                    case 'TV':
                        servicio.push('TV');
                        break;
                    default:
                        tipo = ['todos'];
                    }
                }else{
                    const nombreCategoria = this.querySelector('.category-name').textContent.trim();
                    switch (nombreCategoria) {
                        case 'Casas':
                            tipo = tipo.filter(t => t !== 'Casa');
                            break;
                        case 'Estudio':
                            tipo = tipo.filter(t => t !== 'Estudio');
                            break;
                        case 'Apartamentos':
                            tipo = tipo.filter(t => t !== 'Apartamento');
                            break;
                        case 'Conectados':
                            servicio = servicio.filter(s => s !== 'WiFi');
                            break;
                        case 'Cocina equipada':
                            servicio = servicio.filter(s => s !== 'Cocina');
                            break;
                        case 'Estacionamiento gratuito':
                            servicio = servicio.filter(s => s !== 'Estacionamiento gratuito');
                            break;
                        case 'Piscinas':
                            servicio = servicio.filter(s => s !== 'Piscina');
                            break;
                        case 'Jacuzzi':
                            servicio = servicio.filter(s => s !== 'Jacuzzi');
                            break;
                        case 'Aire Acondicionado':
                            servicio = servicio.filter(s => s !== 'Aire acondicionado');
                            break;
                        case 'Calefacción':
                            servicio = servicio.filter(s => s !== 'Calefacción');
                            break;
                        case 'Lavadora':
                            tipo = tipo.filter(t => t !== 'Lavadora');
                            break;
                        case 'Secadora':
                            servicio = servicio.filter(s => s !== 'Secadora');
                            break;
                        case 'TV':
                            servicio = servicio.filter(s => s !== 'TV');
                            break;
                    }
                }
                if (servicio.length == 0) {
                    servicio.push("none");
                }
                if (tipo.length == 0) {
                    tipo.push("todos");
                }

                mostrarAlojamientos(tipo, servicio);
            });
        });
    </script>
</body>
</html>