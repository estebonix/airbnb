// Script de diagnóstico para debuggear problemas de sesión
// Pegar esto en la consola del navegador para diagnosticar problemas

console.log('=== DIAGNÓSTICO DE SESIÓN ===');

// 1. Verificar localStorage
console.log('1. Verificando localStorage...');
const usuarioLogueado = localStorage.getItem('usuarioLogueado');
const datosUsuario = localStorage.getItem('usuario');

console.log('usuarioLogueado:', usuarioLogueado);
console.log('datosUsuario existe:', !!datosUsuario);

if (datosUsuario) {
    try {
        const usuario = JSON.parse(datosUsuario);
        console.log('Datos del usuario parseados:', usuario);
        console.log('- Nombre:', usuario.nombre);
        console.log('- Apellido:', usuario.apellido);
        console.log('- Email:', usuario.email);
        console.log('- Teléfono:', usuario.telefono);
        console.log('- Biografía:', usuario.biografia);
        console.log('- Fecha nacimiento:', usuario.fechaNacimiento);
        console.log('- Fecha registro:', usuario.fecha_registro);
    } catch (error) {
        console.error('Error al parsear datos del usuario:', error);
        console.log('Datos raw:', datosUsuario);
    }
} else {
    console.log('No hay datos de usuario en localStorage');
}

// 2. Verificar estado de la página
console.log('\n2. Verificando estado de la página...');
console.log('URL actual:', window.location.href);
console.log('Pathname:', window.location.pathname);

// 3. Verificar elementos DOM
console.log('\n3. Verificando elementos DOM...');
const elementosImportantes = [
    'profile-name',
    'nombre-completo',
    'email-usuario',
    'telefono-usuario',
    'biografia-usuario'
];

elementosImportantes.forEach(id => {
    const elemento = document.getElementById(id);
    console.log(`- ${id}:`, elemento ? 'Existe' : 'No existe');
    if (elemento) {
        console.log(`  Contenido: "${elemento.textContent}"`);
    }
});

// 4. Verificar errores de consola
console.log('\n4. Últimos errores de consola:');
// Los errores aparecerán naturalmente en la consola

// 5. Función para limpiar y recargar
console.log('\n5. Funciones de ayuda disponibles:');
console.log('- limpiarSesion(): Limpia localStorage y redirige al login');
console.log('- recargarPerfil(): Recarga los datos del perfil');
console.log('- crearUsuarioTest(): Crea un usuario de prueba en localStorage');

window.limpiarSesion = function () {
    localStorage.removeItem('usuario');
    localStorage.removeItem('usuarioLogueado');
    console.log('Sesión limpiada');
    window.location.href = '/login';
};

window.recargarPerfil = function () {
    if (typeof cargarDatosUsuario === 'function') {
        cargarDatosUsuario();
        console.log('Perfil recargado');
    } else {
        console.log('Función cargarDatosUsuario no disponible, recargando página...');
        location.reload();
    }
};

window.crearUsuarioTest = function () {
    const usuarioTest = {
        id: 999,
        nombre: "Usuario",
        apellido: "Prueba",
        email: "test@example.com",
        telefono: "+34 123 456 789",
        biografia: "Esta es una biografía de prueba para testing.",
        fechaNacimiento: "1990-01-01",
        fecha_registro: new Date().toISOString()
    };

    localStorage.setItem('usuario', JSON.stringify(usuarioTest));
    localStorage.setItem('usuarioLogueado', 'true');
    console.log('Usuario de prueba creado:', usuarioTest);

    if (typeof cargarDatosUsuario === 'function') {
        cargarDatosUsuario();
    } else {
        location.reload();
    }
};

console.log('\n=== FIN DEL DIAGNÓSTICO ===');
console.log('Si el problema persiste, comparte toda esta información.');

// Auto-ejecutar verificación básica
if (usuarioLogueado === 'true' && datosUsuario) {
    console.log('\n✅ Sesión parece válida');
} else {
    console.log('\n❌ Problema detectado con la sesión');
    console.log('Sugerencia: Ejecuta crearUsuarioTest() para probar con datos simulados');
}