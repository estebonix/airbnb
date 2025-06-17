<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/profile.css">
    <title>Perfil - Airbnb</title>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-content">
            <a href="/" class="logo">airbnb</a>
            <div class="user-menu">
                <img src="/img/default-avatar.jpg" 
                     alt="Usuario" 
                     class="user-avatar" id="header-avatar">
                <button onclick="cerrarSesion()" class="edit-button" style="margin-left: 10px;">
                    Cerrar Sesión
                </button>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-container">
        <!-- Profile Header -->
        <div class="profile-header">
            <div class="breadcrumb">
                <a href="/">Inicio</a> > Cuenta > Perfil personal
            </div>
            <h1 class="profile-title">Perfil personal</h1>
            <p class="profile-subtitle">Esta es tu información personal de Airbnb</p>
        </div>

        <!-- Profile Content -->
        <div class="profile-content">
            <!-- Sidebar -->
            <aside class="profile-sidebar">
                <img src="/img/default-avatar.jpg" 
                     alt="Usuario" 
                     class="profile-image" id="profile-image">
                
                <h2 class="profile-name" id="profile-name">Cargando...</h2>
                
                <div class="profile-verified">
                    <span class="verification-badge">✓</span>
                    Identidad verificada
                </div>

                <div class="profile-stats">
                    <div class="stat-item">
                        <span class="stat-icon">⭐</span>
                        <span>Nuevo usuario</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-icon">🏠</span>
                        <span id="fecha-registro">Miembro desde</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-icon">📍</span>
                        <span>España</span>
                    </div>
                </div>

                <button class="edit-button" style="margin-top: 24px;" onclick="editarPerfil()">
                    Editar perfil
                </button>
            </aside>

            <!-- Main Profile Info -->
            <div class="profile-main">
                <!-- Información Personal -->
                <section class="section">
                    <h3 class="section-title">Información personal</h3>
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">Nombre completo</span>
                            <span class="info-value" id="nombre-completo">No especificado</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Email</span>
                            <span class="info-value" id="email-usuario">No especificado</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Teléfono</span>
                            <span class="info-value" id="telefono-usuario">No especificado</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Fecha de nacimiento</span>
                            <span class="info-value" id="fecha-nacimiento">No especificado</span>
                        </div>
                    </div>
                </section>

                <!-- Acerca de mí -->
                <section class="section">
                    <h3 class="section-title">Acerca de mí</h3>
                    <p class="bio-text" id="biografia-usuario">
                        No hay biografía disponible.
                    </p>
                    <button class="secondary-button" style="margin-top: 16px;" onclick="editarBiografia()">
                        Editar descripción
                    </button>
                </section>

                <!-- Verificaciones -->
                <section class="section">
                    <h3 class="section-title">Verificaciones</h3>
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">✓ Email verificado</span>
                            <span class="info-value" id="email-verificado">No verificado</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">⏳ Teléfono</span>
                            <span class="info-value no-data">Pendiente de verificación</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">⏳ Documento de identidad</span>
                            <span class="info-value no-data">Pendiente de verificación</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">✓ Perfil completo</span>
                            <span class="info-value" id="perfil-completado">En progreso</span>
                        </div>
                    </div>
                </section>

                <!-- Actividad reciente -->
                <section class="section">
                    <h3 class="section-title">Actividad reciente</h3>
                    <div class="reviews-grid">
                        <div class="review-card">
                            <div class="review-header">
                                <div class="reviewer-avatar"></div>
                                <div class="reviewer-info">
                                    <div class="reviewer-name">Sistema</div>
                                    <div class="review-date">Hoy</div>
                                </div>
                            </div>
                            <p class="review-text">
                                "¡Bienvenido a Airbnb! Completa tu perfil para tener una mejor experiencia."
                            </p>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </main>

    <script>
        // Función para cargar datos del usuario
        function cargarDatosUsuario() {
            // Verificar si hay un usuario logueado
            const usuarioLogueado = localStorage.getItem('usuarioLogueado');
            const datosUsuario = localStorage.getItem('usuario');

            if (usuarioLogueado === 'true' && datosUsuario) {
                try {
                    const usuario = JSON.parse(datosUsuario);
                    console.log('Datos del usuario:', usuario);

                    // Actualizar nombre
                    const nombreCompleto = usuario.nombre && usuario.apellido 
                        ? `${usuario.nombre} ${usuario.apellido}`.trim()
                        : usuario.nombre || 'Usuario';
                    
                    document.getElementById('profile-name').textContent = nombreCompleto;
                    document.getElementById('nombre-completo').textContent = nombreCompleto;

                    // Actualizar email
                    if (usuario.email) {
                        document.getElementById('email-usuario').textContent = usuario.email;
                        document.getElementById('email-verificado').textContent = usuario.email;
                    }

                    // Actualizar teléfono
                    const telefonoElement = document.getElementById('telefono-usuario');
                    if (usuario.telefono && usuario.telefono.trim() !== '') {
                        telefonoElement.textContent = usuario.telefono;
                        telefonoElement.className = 'info-value';
                    } else {
                        telefonoElement.textContent = 'No especificado';
                        telefonoElement.className = 'info-value no-data';
                    }

                    // Actualizar fecha de nacimiento
                    if (usuario.fechaNacimiento) {
                        const fecha = new Date(usuario.fechaNacimiento);
                        const fechaFormateada = fecha.toLocaleDateString('es-ES', {
                            year: 'numeric',
                            month: 'long',
                            day: 'numeric'
                        });
                        document.getElementById('fecha-nacimiento').textContent = fechaFormateada;
                        document.getElementById('fecha-nacimiento').className = 'info-value';
                    }

                    // Actualizar biografía
                    const biografiaElement = document.getElementById('biografia-usuario');
                    if (usuario.biografia && usuario.biografia.trim() !== '') {
                        biografiaElement.textContent = usuario.biografia;
                    } else {
                        biografiaElement.textContent = 'No hay biografía disponible.';
                    }

                    // Actualizar fecha de registro
                    if (usuario.fecha_registro) {
                        const fechaRegistro = new Date(usuario.fecha_registro);
                        const año = fechaRegistro.getFullYear();
                        document.getElementById('fecha-registro').textContent = `Miembro desde ${año}`;
                    }

                    // Calcular completitud del perfil
                    let completitud = 0;
                    const campos = [usuario.nombre, usuario.apellido, usuario.email, usuario.telefono, usuario.biografia];
                    campos.forEach(campo => {
                        if (campo && campo.toString().trim() !== '') {
                            completitud += 20;
                        }
                    });

                    document.getElementById('perfil-completado').textContent = `${completitud}% completado`;

                } catch (error) {
                    console.error('Error al parsear datos del usuario:', error);
                    mostrarErrorSesion();
                }
            } else {
                console.log('No hay usuario logueado, redirigiendo...');
                // Redirigir al login si no hay usuario logueado
                window.location.href = '/login';
            }
        }

        // Función para mostrar error de sesión
        function mostrarErrorSesion() {
            document.getElementById('profile-name').textContent = 'Error de sesión';
            document.getElementById('nombre-completo').textContent = 'Error al cargar datos';
        }

        // Función para cerrar sesión
        function cerrarSesion() {
            if (confirm('¿Estás seguro de que quieres cerrar sesión?')) {
                localStorage.removeItem('usuario');
                localStorage.removeItem('usuarioLogueado');
                window.location.href = '/login';
            }
        }

        // Función para editar perfil (placeholder)
        function editarPerfil() {
            alert('Funcionalidad de edición en desarrollo. Próximamente disponible.');
        }

        // Función para editar biografía (placeholder)
        function editarBiografia() {
            const nuevaBiografia = prompt('Introduce tu nueva biografía:');
            if (nuevaBiografia !== null && nuevaBiografia.trim()) {
                // Aquí se haría la llamada al servidor para actualizar
                document.getElementById('biografia-usuario').textContent = nuevaBiografia.trim();
                
                // Actualizar también en localStorage
                const datosUsuario = localStorage.getItem('usuario');
                if (datosUsuario) {
                    const usuario = JSON.parse(datosUsuario);
                    usuario.biografia = nuevaBiografia.trim();
                    localStorage.setItem('usuario', JSON.stringify(usuario));
                }
                
                alert('Biografía actualizada (cambio local, en desarrollo la sincronización con servidor)');
            }
        }

        // Animación suave al cargar
        document.addEventListener('DOMContentLoaded', function() {
            // Cargar datos del usuario
            cargarDatosUsuario();

            const profileImage = document.querySelector('.profile-image');
            const sections = document.querySelectorAll('.section');
            
            // Fade in para la imagen de perfil
            if (profileImage) {
                profileImage.style.opacity = '0';
                profileImage.style.transform = 'scale(0.8)';
                setTimeout(() => {
                    profileImage.style.transition = 'all 0.5s ease';
                    profileImage.style.opacity = '1';
                    profileImage.style.transform = 'scale(1)';
                }, 100);
            }

            // Fade in para las secciones
            sections.forEach((section, index) => {
                section.style.opacity = '0';
                section.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    section.style.transition = 'all 0.5s ease';
                    section.style.opacity = '1';
                    section.style.transform = 'translateY(0)';
                }, 200 + (index * 100));
            });
        });

        // Verificar sesión periódicamente
        setInterval(function() {
            const usuarioLogueado = localStorage.getItem('usuarioLogueado');
            if (usuarioLogueado !== 'true') {
                window.location.href = '/login';
            }
        }, 30000); // Verificar cada 30 segundos
    </script>
</body>
</html>