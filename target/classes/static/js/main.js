async function mostrarAlojamientos(tipo, servicio) {
    const listings = document.getElementById('listings');
    let alojamientos = await getAlojamientos();

    listings.innerHTML = "";
    if (alojamientos.length > 0) {
        for (const alojamiento of alojamientos) {
            if (tipo.includes(alojamiento.tipoAlojamiento) || tipo.includes('todos')) {
                let servicios = await getServiciosByAlojamientoId(alojamiento.id);
                if (servicio.includes('none') || servicios.includes(servicio)) {
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

async function getAlojamientos() {
    const response = await fetch("http://localhost:8080/alojamiento/getAll");
    if (!response.ok) {
        throw new Error('Error en la respuesta de la API para obtener los alojamientos');
    } else {
        return response.json();
    }
}

async function getMainImage(alojamientoId) {
    const response = await fetch("http://localhost:8080/alojamiento/imagenes/mainImagen/" + alojamientoId);
    if (!response.ok) {
        throw new Error('Error en la respuesta de la API para obtener la imagen principal del alojamiento');
    } else {
        return response.text();
    } // TODO: MAYBE NO FUNCIONA PORQUE EL CONTROLLER DEVUELVE UN RESPONSEENTITY Y NO UN STRING
}

async function getValoracionMedia(alojamientoId) {
    const response = await fetch("http://localhost:8080/alojamiento/valoraciones/media/" + alojamientoId);
    if (!response.ok) {
        throw new Error('Error en la respuesta de la API para obtener la valoración media del alojamiento');
    } else {
        return response.json();
    }

}

async function getServiciosByAlojamientoId(alojamientoId) {
    const response = await fetch("http://localhost:8080/servicios?alojamientoId=" + alojamientoId);
    if (!response.ok) {
        throw new Error('Error en la respuesta de la API para obtener los servicios del alojamiento');
    } else {
        return response.json();
    }
}