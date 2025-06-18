function createAlojamiento() {
    // Verificar que el usuario esté logueado
    const userEmail = localStorage.getItem('userEmail');
    const usuarioLogueado = localStorage.getItem('usuarioLogueado');

    if (usuarioLogueado !== 'true' || !userEmail) {
        alert('Debes iniciar sesión para publicar un alojamiento');
        window.location.href = '/login';
        return;
    }

    // Obtener datos del formulario
    const titulo = document.getElementById("titulo").value;
    const descripcion = document.getElementById("descripcion").value;
    const tipoAlojamiento = document.getElementById("tipo_alojamiento").value;
    const capacidad = document.getElementById("capacidad").value;
    const habitaciones = document.getElementById("habitaciones").value;
    const camas = document.getElementById("camas").value;
    const banos = document.getElementById("banos").value;
    const precioNoche = document.getElementById("precio_noche").value;
    const direccion = document.getElementById("direccion").value;
    const direccionDescripcion = document.getElementById("direccion_descripcion") ?
        document.getElementById("direccion_descripcion").value : direccion;
    const ciudad = document.getElementById("ciudad").value;
    const pais = document.getElementById("pais").value;
    const codigoPostal = document.getElementById("codigo_postal").value;

    // Servicios opcionales
    const wifi = document.querySelector('input[name="wifi"]') ?
        document.querySelector('input[name="wifi"]').checked : false;
    const cocina = document.querySelector('input[name="cocina"]') ?
        document.querySelector('input[name="cocina"]').checked : false;
    const estacionamiento = document.querySelector('input[name="estacionamiento"]') ?
        document.querySelector('input[name="estacionamiento"]').checked : false;
    const piscina = document.querySelector('input[name="piscina"]') ?
        document.querySelector('input[name="piscina"]').checked : false;

    // Validaciones básicas
    if (!titulo || !descripcion || !tipoAlojamiento || !capacidad || !habitaciones ||
        !camas || !banos || !precioNoche || !direccion || !ciudad || !pais) {
        alert('Por favor, completa todos los campos obligatorios');
        return;
    }

    if (parseInt(capacidad) < 1 || parseInt(habitaciones) < 1 ||
        parseInt(camas) < 1 || parseInt(banos) < 1) {
        alert('Los valores numéricos deben ser mayores a 0');
        return;
    }

    if (parseFloat(precioNoche) <= 0) {
        alert('El precio por noche debe ser mayor a 0');
        return;
    }

    // Crear la URL con parámetros incluyendo el email del propietario
    const params = new URLSearchParams({
        titulo: titulo,
        descripcion: descripcion,
        tipoAlojamiento: tipoAlojamiento,
        capacidad: capacidad,
        habitaciones: habitaciones,
        camas: camas,
        banos: banos,
        precioNoche: precioNoche,
        direccion: direccion,
        direccionDescripcion: direccionDescripcion,
        ciudad: ciudad,
        pais: pais,
        codigoPostal: codigoPostal,
        emailPropietario: userEmail // Incluir el email del propietario
    });

    const url = `http://localhost:8080/alojamiento/add?${params.toString()}`;

    // Deshabilitar el botón de envío
    const submitButton = document.querySelector('#modalAlojamiento button[onclick="createAlojamiento()"]');
    if (submitButton) {
        submitButton.disabled = true;
        submitButton.textContent = 'Creando...';
    }

    fetch(url, {
        method: "POST",
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        }
    })
        .then(response => {
            if (response.ok) {
                return response.text();
            } else {
                throw new Error("Error al crear el alojamiento");
            }
        })
        .then(data => {
            console.log('Respuesta del servidor:', data);

            if (data.includes('correctamente')) {
                alert("¡Alojamiento creado con éxito! Serás redirigido a la página principal.");

                // Limpiar el formulario
                document.getElementById("titulo").value = '';
                document.getElementById("descripcion").value = '';
                document.getElementById("tipo_alojamiento").value = '';
                document.getElementById("capacidad").value = '';
                document.getElementById("habitaciones").value = '';
                document.getElementById("camas").value = '';
                document.getElementById("banos").value = '';
                document.getElementById("precio_noche").value = '';
                document.getElementById("direccion").value = '';
                if (document.getElementById("direccion_descripcion")) {
                    document.getElementById("direccion_descripcion").value = '';
                }
                document.getElementById("ciudad").value = '';
                document.getElementById("pais").value = '';
                document.getElementById("codigo_postal").value = '';

                // Cerrar modal
                const modal = document.getElementById("modalAlojamiento");
                if (modal) {
                    modal.style.display = "none";
                }

                // Redirigir después de un breve delay
                setTimeout(() => {
                    window.location.href = "/";
                }, 1500);
            } else {
                alert("Error: " + data);
            }
        })
        .catch(error => {
            console.error("Error:", error);
            alert("No se pudo crear el alojamiento. Por favor, inténtelo de nuevo.");
        })
        .finally(() => {
            // Rehabilitar el botón
            if (submitButton) {
                submitButton.disabled = false;
                submitButton.textContent = 'Publicar Alojamiento';
            }
        });
}

// Función para obtener alojamientos del usuario actual
async function getMisAlojamientos() {
    const userEmail = localStorage.getItem('userEmail');
    const usuarioLogueado = localStorage.getItem('usuarioLogueado');

    if (usuarioLogueado !== 'true' || !userEmail) {
        console.log('Usuario no logueado');
        return [];
    }

    try {
        const response = await fetch(`/alojamiento/propietario/email/${encodeURIComponent(userEmail)}`);
        if (response.ok) {
            const alojamientos = await response.json();
            console.log('Mis alojamientos:', alojamientos);
            return alojamientos;
        } else {
            console.error('Error al obtener mis alojamientos');
            return [];
        }
    } catch (error) {
        console.error('Error:', error);
        return [];
    }
}

// Función para verificar si el usuario es propietario de un alojamiento
async function esPropietarioDeAlojamiento(alojamientoId) {
    const userEmail = localStorage.getItem('userEmail');

    if (!userEmail) {
        return false;
    }

    try {
        const response = await fetch(`/alojamiento/${alojamientoId}/es-propietario?email=${encodeURIComponent(userEmail)}`);
        if (response.ok) {
            return await response.json();
        }
        return false;
    } catch (error) {
        console.error('Error verificando propietario:', error);
        return false;
    }
}

// Función para mostrar opciones de propietario en listings
function mostrarOpcionesPropietario() {
    // Esta función se puede llamar después de cargar los alojamientos
    // para mostrar opciones de edición/eliminación en los propios alojamientos
    const listings = document.querySelectorAll('.listing');

    listings.forEach(async (listing) => {
        const alojamientoId = listing.getAttribute('data-id');
        if (alojamientoId) {
            const esPropietario = await esPropietarioDeAlojamiento(alojamientoId);
            if (esPropietario) {
                // Agregar indicador de propiedad
                const ownerBadge = document.createElement('div');
                ownerBadge.className = 'owner-badge';
                ownerBadge.innerHTML = '👤 Tu alojamiento';
                ownerBadge.style.cssText = `
                    position: absolute;
                    top: 8px;
                    left: 8px;
                    background: rgba(255, 90, 95, 0.9);
                    color: white;
                    padding: 4px 8px;
                    border-radius: 12px;
                    font-size: 12px;
                    font-weight: 600;
                    z-index: 2;
                `;

                const listingImages = listing.querySelector('.listing-images');
                if (listingImages) {
                    listingImages.style.position = 'relative';
                    listingImages.appendChild(ownerBadge);
                }
            }
        }
    });
}

// Llamar esta función después de cargar los alojamientos en la página principal
// Se puede integrar en el main.js existente