<!DOCTYPE html>
<html lang="es" xmlns:th="http://www.thymeleaf.org">
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
                <img src="${picture!'/img/default-avatar.jpg'}" 
                     alt="${name!'Usuario'}" 
                     class="user-avatar">
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
                <img src="${picture!'/default-avatar.png'}" 
                     alt="${name!'Usuario'}" 
                     class="profile-image">
                
                <h2 class="profile-name">${name!username!'Usuario'}</h2>
                
                <div class="profile-verified">
                    <span class="verification-badge">✓</span>
                    Identidad verificada
                </div>

                <div class="profile-stats">
                    <div class="stat-item">
                        <span class="stat-icon">⭐</span>
                        <span>4.9 estrellas (23 reseñas)</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-icon">🏠</span>
                        <span>Anfitrión desde 2023</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-icon">📍</span>
                        <span>España</span>
                    </div>
                </div>

                <button class="edit-button" style="margin-top: 24px;">
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
                            <span class="info-value">${name!'No especificado'}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Email</span>
                            <span class="info-value">${email!'No especificado'}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Teléfono</span>
                            <span class="info-value no-data">No especificado</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Fecha de nacimiento</span>
                            <span class="info-value no-data">No especificado</span>
                        </div>
                    </div>
                </section>

                <!-- Acerca de mí -->
                <section class="section">
                    <h3 class="section-title">Acerca de mí</h3>
                    <p class="bio-text">
                        ¡Hola! Soy un viajero apasionado que ama conocer nuevos lugares y culturas. 
                        Me encanta la hospitalidad y crear experiencias memorables para otros viajeros. 
                        Cuando no estoy viajando, disfruto de la cocina local y el arte.
                    </p>
                    <button class="secondary-button" style="margin-top: 16px;">
                        Editar descripción
                    </button>
                </section>

                <!-- Verificaciones -->
                <section class="section">
                    <h3 class="section-title">Verificaciones</h3>
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">✓ Email verificado</span>
                            <span class="info-value">${email!'email@ejemplo.com'}</span>
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
                            <span class="info-label">✓ Perfil de redes sociales</span>
                            <span class="info-value">Google</span>
                        </div>
                    </div>
                </section>

                <!-- Reseñas -->
                <section class="section">
                    <h3 class="section-title">Reseñas sobre ti</h3>
                    <div class="reviews-grid">
                        <div class="review-card">
                            <div class="review-header">
                                <div class="reviewer-avatar"></div>
                                <div class="reviewer-info">
                                    <div class="reviewer-name">María García</div>
                                    <div class="review-date">Marzo 2024</div>
                                </div>
                            </div>
                            <p class="review-text">
                                "Excelente anfitrión, muy comunicativo y servicial. 
                                La estancia fue perfecta y el lugar exactamente como se describía."
                            </p>
                        </div>
                        
                        <div class="review-card">
                            <div class="review-header">
                                <div class="reviewer-avatar"></div>
                                <div class="reviewer-info">
                                    <div class="reviewer-name">Carlos Mendoza</div>
                                    <div class="review-date">Febrero 2024</div>
                                </div>
                            </div>
                            <p class="review-text">
                                "Muy recomendable. Atención al detalle excepcional y 
                                siempre dispuesto a ayudar con recomendaciones locales."
                            </p>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </main>

    <script>
        // Funcionalidad básica para los botones
        document.querySelectorAll('.edit-button, .secondary-button').forEach(button => {
            button.addEventListener('click', function() {
                // Aquí puedes agregar la lógica para editar el perfil
                console.log('Botón clickeado:', this.textContent);
                // Por ejemplo, redirigir a una página de edición:
                // window.location.href = '/profile/edit';
            });
        });

        // Animación suave al cargar
        document.addEventListener('DOMContentLoaded', function() {
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
    </script>
</body>