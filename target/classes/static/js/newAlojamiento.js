function createAlojamiento() {
    const titulo = document.getElementById("titulo").value;
    const descripcion = document.getElementById("descripcion").value;
    const tipoAlojamiento = document.getElementById("tipo_alojamiento").value;
    const capacidad = document.getElementById("capacidad").value;
    const habitaciones = document.getElementById("habitaciones").value;
    const camas = document.getElementById("camas").value;
    const banos = document.getElementById("banos").value;
    const precioNoche = document.getElementById("precio_noche").value;
    const direccion = document.getElementById("direccion").value;
    const direccionDescripcion = document.getElementById("direccion_descripcion").value;
    const ciudad = document.getElementById("ciudad").value;
    const pais = document.getElementById("pais").value;
    const codigoPostal = document.getElementById("codigo_postal").value;
    const wifi = document.querySelector('input[name="wifi"]').checked;
    const cocina = document.querySelector('input[name="cocina"]').checked;
    const estacionamiento = document.querySelector('input[name="estacionamiento"]').checked;
    const piscina = document.querySelector('input[name="piscina"]').checked;
    const disponible = document.getElementById("disponible").value;

    fetch("http://localhost:8080/alojamiento/add?titulo="+titulo+"&descripcion="+descripcion+"&tipoAlojamiento="+tipoAlojamiento+"&capacidad="+capacidad+"&habitaciones="+habitaciones+"&camas="+camas+"&banos="+banos+"&precioNoche="+precioNoche+"&direccion="+direccion+"&direccionDescripcion="+direccionDescripcion+"&ciudad="+ciudad+"&pais="+pais+"&codigoPostal="+codigoPostal, {
        method: "POST",
        body: JSON.stringify({}),
    })
    .then(response => {
        if (response.ok) {
            return response.json();
        } else {
            throw new Error("Error al crear el alojamiento");
        }
    })
    .then(data => {
        alert("Alojamiento creado con éxito");
        window.location.href = "/";
    })
    .catch(error => {
        console.error("Error:", error);
        alert("No se pudo crear el alojamiento. Por favor, inténtelo de nuevo.");
    });
}