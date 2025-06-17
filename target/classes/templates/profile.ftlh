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

        <#if needsEmailFromJS?? && needsEmailFromJS>
            <!-- Loading State - JavaScript manejará la carga -->
            <div id="loading-state" style="text-align: center; padding: 50px;">
                <div style="font-size: 18px; color: #666;">Cargando perfil...</div>
            </div>

            <!-- Error State -->
            <div id="error-state" style="display: none; text-align: center; padding: 50px;">
                <div style="font-size: 18px; color: #dc3545; margin-bottom: 20px;">
                    <#if error??>
                        ${error}
                    <#else>
                        Error al cargar el perfil
                    </#if>
                </div>
                <button onclick="location.reload()" class="edit-button">
                    Intentar de nuevo
                </button>
                <button onclick="cerrarSesion()" class="secondary-button" style="margin-left: 10px;">
                    Cerrar Sesión
                </button>
            </div>

        <#else>
            <!-- Profile Content - Datos desde el servidor -->
            <div class="profile-content">
                <!-- Sidebar -->
                <aside class="profile-sidebar">
                    <img src="/img/default-avatar.jpg" 
                         alt="${nombreCompleto!'Usuario'}" 
                         class="profile-image">
                    
                    <h2 class="profile-name">${nombreCompleto!'Usuario'}</h2>
                    
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
                            <span>
                                <#if añoRegistro??>
                                    Miembro desde ${añoRegistro}
                                <#else>
                                    Miembro desde 2024
                                </#if>
                            </span>
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
                                <span class="info-value">
                                    <#if nombreCompleto?? && nombreCompleto?trim != "" && nombreCompleto != "Usuario">
                                        ${nombreCompleto}
                                    <#else>
                                        <span class="no-data">No especificado</span>
                                    </#if>
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Email</span>
                                <span class="info-value">
                                    <#if email??>
                                        ${email}
                                    <#else>
                                        <span class="no-data">No especificado</span>
                                    </#if>
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Teléfono</span>
                                <span class="info-value">
                                    <#if telefono?? && telefono?trim != "">
                                        ${telefono}
                                    <#else>
                                        <span class="no-data">No especificado</span>
                                    </#if>
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Fecha de nacimiento</span>
                                <span class="info-value">
                                    <#if fechaNacimiento??>
                                        <#-- Formatear fecha de nacimiento si existe -->
                                        ${fechaNacimiento?string("dd 'de' MMMM 'de' yyyy")}
                                    <#else>
                                        <span class="no-data">No especificado</span>
                                    </#if>
                                </span>
                            </div>
                        </div>
                    </section>

                    <!-- Acerca de mí -->
                    <section class="section">
                        <h3 class="section-title">Acerca de mí</h3>
                        <p class="bio-text">
                            <#if biografia?? && biografia?trim != "">
                                ${biografia}
                            <#else>
                                No hay biografía disponible.
                            </#if>
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
                                <span class="info-value">
                                    <#if email??>
                                        ${email}
                                    <#else>
                                        No verificado
                                    </#if>
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">
                                    <#if telefono?? && telefono?trim != "">
                                        ✓ Teléfono verificado
                                    <#else>
                                        ⏳ Teléfono
                                    </#if>
                                </span>
                                <span class="info-value">
                                    <#if telefono?? && telefono?trim != "">
                                        ${telefono}
                                    <#else>
                                        <span class="no-data">Pendiente de verificación</span>
                                    </#if>
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">⏳ Documento de identidad</span>
                                <span class="info-value no-data">Pendiente de verificación</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">✓ Perfil completo</span>
                                <span class="info-value">
                                    <#if completitudPerfil??>
                                        ${completitudPerfil}% completado
                                    <#else>
                                        En progreso
                                    </#if>
                                </span>
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
                                        <div class="review-date">
                                            <#if añoRegistro??>
                                                ${añoRegistro}
                                            <#else>
                                                2024
                                            </#if>
                                        </div>
                                    </div>
                                </div>
                                <p class="review-text">
                                    ¡Bienvenido a Airbnb! Tu perfil está 
                                    <#if completitudPerfil?? && (completitudPerfil >= 80)>
                                        casi completo.
                                    <#elseif completitudPerfil?? && (completitudPerfil >= 50)>
                                        en progreso. Completa más información para una mejor experiencia.
                                    <#else>
                                        iniciado. Completa tu información personal para tener acceso a todas las funcionalidades.
                                    </#if>
                                </p>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </#if>
    </main>

    <script>
        // Función para cerrar sesión
        function cerrarSesion() {
            if (confirm('¿Estás seguro de que quieres cerrar sesión?')) {
                localStorage.removeItem('userEmail');
                localStorage.removeItem('usuarioLogueado');
                window.location.href = '/login';
            }
        }

        // Función para editar perfil
        function editarPerfil() {
            alert('Funcionalidad de edición en desarrollo. Próximamente disponible.');
        }

        // Función para editar biografía
        function editarBiografia() {
            const biografiaActual = '${biografia!""}';
            const nuevaBiografia = prompt('Introduce tu nueva biografía:', biografiaActual);
            if (nuevaBiografia !== null) {
                // Aquí se haría una llamada al servidor para actualizar la biografía
                alert('Funcionalidad de edición en desarrollo. Próximamente disponible.');
            }
        }

        // Solo ejecutar JavaScript si necesitamos obtener el email desde localStorage
        <#if needsEmailFromJS?? && needsEmailFromJS>
        document.addEventListener('DOMContentLoaded', function() {
            console.log('=== CARGANDO PERFIL DESDE JAVASCRIPT ===');
            
            // Verificar sesión
            const usuarioLogueado = localStorage.getItem('usuarioLogueado');
            const userEmail = localStorage.getItem('userEmail');
            
            console.log('Usuario logueado:', usuarioLogueado);
            console.log('Email guardado:', userEmail);
            
            if (usuarioLogueado !== 'true' || !userEmail) {
                console.log('Sesión inválida, mostrando error...');
                document.getElementById('loading-state').style.display = 'none';
                document.getElementById('error-state').style.display = 'block';
                
                // Redirigir después de 3 segundos
                setTimeout(() => {
                    window.location.href = '/login';
                }, 3000);
                return;
            }
            
            // Redirigir con el email como parámetro
            console.log('Redirigiendo con email:', userEmail);
            window.location.href = '/profile?email=' + encodeURIComponent(userEmail);
        });
        </#if>

        // Verificación periódica de sesión
        setInterval(function() {
            const usuarioLogueado = localStorage.getItem('usuarioLogueado');
            if (usuarioLogueado !== 'true') {
                window.location.href = '/login';
            }
        }, 60000); // Verificar cada minuto

        // Debug: Mostrar información del usuario en consola
        <#if !needsEmailFromJS?? || !needsEmailFromJS>
        console.log('=== DATOS DEL PERFIL CARGADOS ===');
        console.log('Nombre:', '${nombreCompleto!"No disponible"}');
        console.log('Email:', '${email!"No disponible"}');
        console.log('Teléfono:', '${telefono!"No disponible"}');
        console.log('Completitud:', '${completitudPerfil!0}%');
        </#if>
    </script>
</body>
</html>