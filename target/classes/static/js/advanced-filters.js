// advanced-filters.js
// Funciones adicionales para el sistema de filtros avanzados

// Función para obtener sugerencias de ubicación
async function getLocationSuggestions(query) {
    if (query.length < 2) return [];
    
    try {
        // Simular API de ubicaciones - podrías integrar con una API real
        const mockLocations = [
            'Madrid, España',
            'Barcelona, España',
            'Valencia, España',
            'Sevilla, España',
            'Bilbao, España',
            'París, Francia',
            'Lisboa, Portugal',
            'Roma, Italia',
            'Londres, Reino Unido',
            'Berlín, Alemania'
        ];
        
        return mockLocations.filter(location => 
            location.toLowerCase().includes(query.toLowerCase())
        ).slice(0, 5);
    } catch (error) {
        console.error('Error al obtener sugerencias de ubicación:', error);
        return [];
    }
}

// Función para crear autocompletado de ubicación
function setupLocationAutocomplete() {
    const locationInput = document.getElementById('locationFilter');
    if (!locationInput) return;
    
    let suggestionBox = null;
    
    locationInput.addEventListener('input', async function() {
        const query = this.value;
        
        // Remover caja de sugerencias existente
        if (suggestionBox) {
            suggestionBox.remove();
            suggestionBox = null;
        }
        
        if (query.length < 2) return;
        
        const suggestions = await getLocationSuggestions(query);
        if (suggestions.length === 0) return;
        
        // Crear caja de sugerencias
        suggestionBox = document.createElement('div');
        suggestionBox.className = 'location-suggestions';
        suggestionBox.style.cssText = `
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: white;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            z-index: 1000;
            max-height: 200px;
            overflow-y: auto;
        `;
        
        suggestions.forEach(suggestion => {
            const item = document.createElement('div');
            item.className = 'suggestion-item';
            item.textContent = suggestion;
            item.style.cssText = `
                padding: 12px 16px;
                cursor: pointer;
                border-bottom: 1px solid #f0f0f0;
                transition: background-color 0.2s ease;
            `;
            
            item.addEventListener('mouseenter', function() {
                this.style.backgroundColor = '#f8f9fa';
            });
            
            item.addEventListener('mouseleave', function() {
                this.style.backgroundColor = 'transparent';
            });
            
            item.addEventListener('click', function() {
                locationInput.value = suggestion;
                suggestionBox.remove();
                suggestionBox = null;
                applyAdvancedFilters();
            });
            
            suggestionBox.appendChild(item);
        });
        
        // Posicionar la caja de sugerencias
        const inputContainer = locationInput.closest('.filter-group');
        inputContainer.style.position = 'relative';
        inputContainer.appendChild(suggestionBox);
    });
    
    // Cerrar sugerencias al hacer clic fuera
    document.addEventListener('click', function(e) {
        if (!locationInput.contains(e.target) && suggestionBox && !suggestionBox.contains(e.target)) {
            suggestionBox.remove();
            suggestionBox = null;
        }
    });
}

// Función para validar rangos de precio
function validatePriceRange() {
    const minPrice = document.getElementById('minPrice');
    const maxPrice = document.getElementById('maxPrice');
    
    if (!minPrice || !maxPrice) return;
    
    minPrice.addEventListener('input', function() {
        const min = parseFloat(this.value);
        const max = parseFloat(maxPrice.value);
        
        if (min < 0) {
            this.value = 0;
        }
        
        if (max && min > max) {
            maxPrice.value = min;
        }
    });
    
    maxPrice.addEventListener('input', function() {
        const min = parseFloat(minPrice.value);
        const max = parseFloat(this.value);
        
        if (max < 0) {
            this.value = 0;
        }
        
        if (min && max < min) {
            minPrice.value = max;
        }
    });
}

// Función para guardar filtros en localStorage
function saveFiltersToStorage() {
    const filterState = {
        searchText: document.getElementById('searchText')?.value || '',
        location: document.getElementById('locationFilter')?.value || '',
        minPrice: document.getElementById('minPrice')?.value || '',
        maxPrice: document.getElementById('maxPrice')?.value || '',
        rooms: document.getElementById('roomsFilter')?.value || '',
        type: document.getElementById('typeFilter')?.value || '',
        capacity: document.querySelector('.capacity-btn.active')?.dataset.capacity || null,
        categories: Array.from(document.querySelectorAll('.category.active')).map(cat => 
            cat.querySelector('.category-name').textContent.trim()
        )
    };
    
    localStorage.setItem('airbnb_filters', JSON.stringify(filterState));
}

// Función para cargar filtros desde localStorage
function loadFiltersFromStorage() {
    try {
        const savedFilters = localStorage.getItem('airbnb_filters');
        if (!savedFilters) return;
        
        const filterState = JSON.parse(savedFilters);
        
        // Restaurar valores de inputs
        if (filterState.searchText) {
            const searchInput = document.getElementById('searchText');
            if (searchInput) searchInput.value = filterState.searchText;
        }
        
        if (filterState.location) {
            const locationInput = document.getElementById('locationFilter');
            if (locationInput) locationInput.value = filterState.location;
        }
        
        if (filterState.minPrice) {
            const minPriceInput = document.getElementById('minPrice');
            if (minPriceInput) minPriceInput.value = filterState.minPrice;
        }
        
        if (filterState.maxPrice) {
            const maxPriceInput = document.getElementById('maxPrice');
            if (maxPriceInput) maxPriceInput.value = filterState.maxPrice;
        }
        
        if (filterState.rooms) {
            const roomsSelect = document.getElementById('roomsFilter');
            if (roomsSelect) roomsSelect.value = filterState.rooms;
        }
        
        if (filterState.type) {
            const typeSelect = document.getElementById('typeFilter');
            if (typeSelect) typeSelect.value = filterState.type;
        }
        
        if (filterState.capacity) {
            const capacityBtn = document.querySelector(`[data-capacity="${filterState.capacity}"]`);
            if (capacityBtn) {
                document.querySelectorAll('.capacity-btn').forEach(btn => btn.classList.remove('active'));
                capacityBtn.classList.add('active');
            }
        }
        
        // Restaurar categorías (esto se maneja en el código principal)
        
    } catch (error) {
        console.error('Error al cargar filtros guardados:', error);
    }
}

// Función para exportar resultados de búsqueda
function exportSearchResults() {
    if (filteredAlojamientos.length === 0) {
        alert('No hay resultados para exportar');
        return;
    }
    
    const csvContent = generateCSV(filteredAlojamientos);
    downloadCSV(csvContent, 'alojamientos_filtrados.csv');
}

// Función para generar CSV
function generateCSV(alojamientos) {
    const headers = ['Título', 'Tipo', 'Ciudad', 'País', 'Precio/Noche', 'Capacidad', 'Habitaciones', 'Baños'];
    
    const rows = alojamientos.map(alojamiento => [
        alojamiento.titulo,
        alojamiento.tipoAlojamiento,
        alojamiento.ciudad,
        alojamiento.pais,
        alojamiento.precioNoche,
        alojamiento.capacidad,
        alojamiento.habitaciones,
        alojamiento.banos
    ]);
    
    const csvContent = [headers, ...rows]
        .map(row => row.map(field => `"${field}"`).join(','))
        .join('\n');
    
    return csvContent;
}

// Función para descargar CSV
function downloadCSV(content, filename) {
    const blob = new Blob([content], { type: 'text/csv;charset=utf-8;' });
    const link = document.createElement('a');
    
    if (link.download !== undefined) {
        const url = URL.createObjectURL(blob);
        link.setAttribute('href', url);
        link.setAttribute('download', filename);
        link.style.visibility = 'hidden';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }
}

// Función para compartir búsqueda
function shareSearch() {
    const url = new URL(window.location.href);
    
    // Agregar parámetros de filtros a la URL
    if (currentFilters.searchText) url.searchParams.set('search', currentFilters.searchText);
    if (currentFilters.location) url.searchParams.set('location', currentFilters.location);
    if (currentFilters.minPrice) url.searchParams.set('minPrice', currentFilters.minPrice);
    if (currentFilters.maxPrice) url.searchParams.set('maxPrice', currentFilters.maxPrice);
    if (currentFilters.capacity) url.searchParams.set('capacity', currentFilters.capacity);
    if (currentFilters.rooms) url.searchParams.set('rooms', currentFilters.rooms);
    if (currentFilters.type) url.searchParams.set('type', currentFilters.type);
    
    // Copiar al portapapeles
    navigator.clipboard.writeText(url.toString()).then(() => {
        showNotification('🔗 Enlace copiado al portapapeles', 'success');
    }).catch(() => {
        // Fallback para navegadores que no soportan clipboard API
        const textArea = document.createElement('textarea');
        textArea.value = url.toString();
        document.body.appendChild(textArea);
        textArea.select();
        document.execCommand('copy');
        document.body.removeChild(textArea);
        showNotification('🔗 Enlace copiado', 'success');
    });
}

// Función para mostrar notificaciones
function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `notification ${type}`;
    notification.textContent = message;
    
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: ${type === 'success' ? '#51cf66' : type === 'error' ? '#ff6b6b' : '#667eea'};
        color: white;
        padding: 15px 20px;
        border-radius: 10px;
        z-index: 10000;
        font-weight: 600;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        transform: translateX(100%);
        transition: transform 0.3s ease;
    `;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        notification.style.transform = 'translateX(0)';
    }, 100);
    
    setTimeout(() => {
        notification.style.transform = 'translateX(100%)';
        setTimeout(() => {
            if (notification.parentNode) {
                notification.parentNode.removeChild(notification);
            }
        }, 300);
    }, 3000);
}

// Función para analizar estadísticas de búsqueda
function getSearchStats() {
    if (filteredAlojamientos.length === 0) return null;
    
    const precios = filteredAlojamientos.map(a => a.precioNoche);
    const capacidades = filteredAlojamientos.map(a => a.capacidad);
    
    return {
        total: filteredAlojamientos.length,
        precioPromedio: (precios.reduce((a, b) => a + b, 0) / precios.length).toFixed(2),
        precioMin: Math.min(...precios),
        precioMax: Math.max(...precios),
        capacidadPromedio: (capacidades.reduce((a, b) => a + b, 0) / capacidades.length).toFixed(1),
        tiposMasComunes: getMostCommonTypes(),
        ciudadesMasComunes: getMostCommonCities()
    };
}

// Función para obtener tipos más comunes
function getMostCommonTypes() {
    const tipos = {};
    filteredAlojamientos.forEach(a => {
        tipos[a.tipoAlojamiento] = (tipos[a.tipoAlojamiento] || 0) + 1;
    });
    
    return Object.entries(tipos)
        .sort(([,a], [,b]) => b - a)
        .slice(0, 3)
        .map(([tipo, count]) => ({ tipo, count }));
}

// Función para obtener ciudades más comunes
function getMostCommonCities() {
    const ciudades = {};
    filteredAlojamientos.forEach(a => {
        const ciudad = `${a.ciudad}, ${a.pais}`;
        ciudades[ciudad] = (ciudades[ciudad] || 0) + 1;
    });
    
    return Object.entries(ciudades)
        .sort(([,a], [,b]) => b - a)
        .slice(0, 3)
        .map(([ciudad, count]) => ({ ciudad, count }));
}

// Función para mostrar estadísticas
function showSearchStats() {
    const stats = getSearchStats();
    if (!stats) {
        alert('No hay datos para mostrar estadísticas');
        return;
    }
    
    const statsModal = document.createElement('div');
    statsModal.className = 'stats-modal';
    statsModal.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.8);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 10000;
    `;
    
    statsModal.innerHTML = `
        <div style="background: white; padding: 30px; border-radius: 20px; max-width: 500px; width: 90%;">
            <h3 style="margin-bottom: 20px; color: #333;">📊 Estadísticas de búsqueda</h3>
            <div style="margin-bottom: 15px;"><strong>Total de alojamientos:</strong> ${stats.total}</div>
            <div style="margin-bottom: 15px;"><strong>Precio promedio:</strong> ${stats.precioPromedio}€/noche</div>
            <div style="margin-bottom: 15px;"><strong>Rango de precios:</strong> ${stats.precioMin}€ - ${stats.precioMax}€</div>
            <div style="margin-bottom: 15px;"><strong>Capacidad promedio:</strong> ${stats.capacidadPromedio} huéspedes</div>
            
            <h4 style="margin: 20px 0 10px 0;">Tipos más populares:</h4>
            ${stats.tiposMasComunes.map(item => `<div>• ${item.tipo}: ${item.count} alojamientos</div>`).join('')}
            
            <h4 style="margin: 20px 0 10px 0;">Destinos más populares:</h4>
            ${stats.ciudadesMasComunes.map(item => `<div>• ${item.ciudad}: ${item.count} alojamientos</div>`).join('')}
            
            <button onclick="this.closest('.stats-modal').remove()" 
                    style="margin-top: 20px; background: #667eea; color: white; border: none; padding: 10px 20px; border-radius: 10px; cursor: pointer;">
                Cerrar
            </button>
        </div>
    `;
    
    document.body.appendChild(statsModal);
    
    statsModal.addEventListener('click', function(e) {
        if (e.target === statsModal) {
            statsModal.remove();
        }
    });
}

// Inicializar funciones adicionales cuando se carga la página
document.addEventListener('DOMContentLoaded', function() {
    setupLocationAutocomplete();
    validatePriceRange();
    loadFiltersFromStorage();
    
    // Guardar filtros cuando cambien
    document.addEventListener('input', saveFiltersToStorage);
    document.addEventListener('change', saveFiltersToStorage);
});

// Función para cargar filtros desde URL (para enlaces compartidos)
function loadFiltersFromURL() {
    const urlParams = new URLSearchParams(window.location.search);
    
    const searchText = urlParams.get('search');
    const location = urlParams.get('location');
    const minPrice = urlParams.get('minPrice');
    const maxPrice = urlParams.get('maxPrice');
    const capacity = urlParams.get('capacity');
    const rooms = urlParams.get('rooms');
    const type = urlParams.get('type');
    
    if (searchText) document.getElementById('searchText').value = searchText;
    if (location) document.getElementById('locationFilter').value = location;
    if (minPrice) document.getElementById('minPrice').value = minPrice;
    if (maxPrice) document.getElementById('maxPrice').value = maxPrice;
    if (rooms) document.getElementById('roomsFilter').value = rooms;
    if (type) document.getElementById('typeFilter').value = type;
    
    if (capacity) {
        const capacityBtn = document.querySelector(`[data-capacity="${capacity}"]`);
        if (capacityBtn) {
            document.querySelectorAll('.capacity-btn').forEach(btn => btn.classList.remove('active'));
            capacityBtn.classList.add('active');
            currentFilters.capacity = capacity;
        }
    }
    
    // Aplicar filtros si hay alguno en la URL
    if (searchText || location || minPrice || maxPrice || capacity || rooms || type) {
        setTimeout(() => {
            applyAdvancedFilters();
            document.getElementById('advancedFilters').classList.add('show');
        }, 500);
    }
}

// Cargar filtros desde URL al inicializar
document.addEventListener('DOMContentLoaded', loadFiltersFromURL);