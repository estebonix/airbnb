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
        </div>
        
        <button class="filters-button">
            <i class="fas fa-sliders"></i>
            Filtros
        </button>
    </div>
    
    <!-- Listings -->
    <div id="listings" class="listings">
        <!-- Los alojamientos se cargarán aquí -->
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

    <script>
        // Funciones API básicas
        async function getAlojamientos() {
            try {
                const response = await fetch("http://localhost:8080/alojamiento/getAll");
                if (!response.ok) {
                    throw new Error('Error en la respuesta de la API');
                }
                return await response.json();
            } catch (error) {
                console.error('Error al obtener alojamientos:', error);
                return [];
            }
        }

        async function getMainImage(alojamientoId) {
            try {
                const response = await fetch("http://localhost:8080/alojamiento/imagenes/mainImagen/" + alojamientoId);
                if (!response.ok) {
                    return '/img/default-property.jpg';
                }
                return await response.text();
            } catch (error) {
                console.error('Error al obtener imagen:', error);
                return '/img/default-property.jpg';
            }
        }

        async function getValoracionMedia(alojamientoId) {
            try {
                const response = await fetch("http://localhost:8080/alojamiento/valoraciones/media/" + alojamientoId);
                if (!response.ok) {
                    return 0;
                }
                const valoracion = await response.json();
                return valoracion || 0;
            } catch (error) {
                console.error('Error al obtener valoración:', error);
                return 0;
            }
        }

        // Función para mostrar alojamientos
        async function mostrarAlojamientos() {
            const listings = document.getElementById('listings');
            let alojamientos = await getAlojamientos();

            console.log('Alojamientos obtenidos:', alojamientos.length);
            listings.innerHTML = "";
            
            if (alojamientos.length > 0) {
                for (const alojamiento of alojamientos) {
                    try {
                        let mainImageUrl = await getMainImage(alojamiento.id);
                        let valoracionMedia = await getValoracionMedia(alojamiento.id);
                        
                        listings.innerHTML += `
                            <div class="listing" onclick="window.location.href='/alojamiento/${alojamiento.id}/page'">
                                <div class="listing-images">
                                    <img src="${mainImageUrl}" alt="${alojamiento.titulo}" class="listing-image">
                                    <button class="like-button">
                                        <i class="far fa-heart"></i>
                                    </button>
                                </div>
                                <div class="listing-info">
                                    <div class="listing-location">
                                        <div>${alojamiento.ciudad}, ${alojamiento.pais}</div>
                                        <div class="listing-rating">
                                            <i class="fas fa-star"></i>
                                            <span>${valoracionMedia}</span>
                                        </div>
                                    </div>
                                    <div class="listing-details">${alojamiento.titulo}</div>
                                    <div class="listing-details">${alojamiento.capacidad} huéspedes · ${alojamiento.habitaciones} habitaciones</div>
                                    <div class="listing-price"><span>${alojamiento.precioNoche}€</span> por noche</div>
                                </div>
                            </div>
                        `;
                    } catch (error) {
                        console.error('Error al mostrar alojamiento:', error);
                    }
                }
            } else {
                listings.innerHTML = '<div style="text-align: center; padding: 50px; color: #666;">No se encontraron alojamientos</div>';
            }
        }

        // Inicializar cuando se carga la página
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Página cargada, iniciando...');
            mostrarAlojamientos();

            // Configurar botón publicar
            const btnPublicar = document.getElementById('abrirModal');
            if (btnPublicar) {
                btnPublicar.addEventListener('click', function(e) {
                    e.preventDefault();
                    window.location.href = '/crear-alojamiento';
                });
            }

            // Configurar perfil de usuario
            const userProfile = document.querySelector('.user-profile');
            if (userProfile) {
                userProfile.addEventListener('click', function(e) {
                    e.preventDefault();
                    window.location.href = '/profile';
                });
            }

            // Funcionalidad básica de categorías
            document.querySelectorAll('.category').forEach(category => {
                category.addEventListener('click', function() {
                    document.querySelectorAll('.category').forEach(c => c.classList.remove('active'));
                    this.classList.add('active');
                    mostrarAlojamientos(); // Por ahora muestra todos
                });
            });

            // Funcionalidad de me gusta
            document.addEventListener('click', function(e) {
                if (e.target.closest('.like-button')) {
                    e.stopPropagation();
                    const button = e.target.closest('.like-button');
                    const icon = button.querySelector('i');
                    if (icon.classList.contains('far')) {
                        icon.classList.remove('far');
                        icon.classList.add('fas');
                        icon.style.color = '#ff385c';
                    } else {
                        icon.classList.remove('fas');
                        icon.classList.add('far');
                        icon.style.color = '';
                    }
                }
            });
        });
    </script>
    
    <!-- Cargar session manager si existe -->
    <script src="/js/session-manager.js"></script>
</body>
</html>