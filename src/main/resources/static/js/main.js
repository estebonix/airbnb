async function mostrarAlojamientos(tipo, servicio){
    const listings = document.getElementById('listings');
    let alojamientos = await getAlojamientos();
    
    listings.innerHTML = "";
    if (alojamientos.length > 0) {
        for (const alojamiento of alojamientos) {
            if (alojamiento.tipoAlojamiento === tipo || tipo === 'todos'){
                let servicios = await getServiciosByAlojamientoId(alojamiento.id);
                if (servicio === 'none' || servicios.includes(servicio)) {
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
                }
            }
        }
    }
}

function getAlojamientos(){
    return fetch("http://localhost:8080/alojamiento/getAll")
        .then(response => {
            if (!response.ok) {
                throw new Error('Error en la respuesta de la API para obtener los alojamientos');
            } else {
                return response.json();
            }
        });
}

function getMainImage(alojamientoId){
    return fetch("http://localhost:8080/alojamiento/imagenes/mainImagen/" + alojamientoId)
        .then(response => {
            if (!response.ok) {
                throw new Error('Error en la respuesta de la API para obtener la imagen principal del alojamiento');
            } else {
                return response.text();
            }
        });
}

function getValoracionMedia(alojamientoId) {
    return fetch("http://localhost:8080/alojamiento/valoraciones/media/" + alojamientoId)
        .then(response => {
            if (!response.ok) {
                throw new Error('Error en la respuesta de la API para obtener la valoración media del alojamiento');
            } else {
                return response.json();
            }
        });
        
}

function getServiciosByAlojamientoId(alojamientoId) {
    return fetch("http://localhost:8080/servicios?alojamientoId=" + alojamientoId)
        .then(response => {
            if (!response.ok) {
                throw new Error('Error en la respuesta de la API para obtener los servicios del alojamiento');
            } else {
                return response.json();
            }
        });
}