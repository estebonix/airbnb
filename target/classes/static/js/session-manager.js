// session-manager.js
// Archivo para manejar la sesión del usuario en toda la aplicación

class SessionManager {
    constructor() {
        this.init();
    }

    init() {
        // Verificar si hay una sesión activa al cargar cualquier página
        this.checkSession();

        // Actualizar UI según el estado de la sesión
        this.updateUI();
    }

    // Verificar si hay una sesión activa
    checkSession() {
        const usuarioLogueado = localStorage.getItem('usuarioLogueado');
        const userEmail = localStorage.getItem('userEmail');

        return usuarioLogueado === 'true' && userEmail !== null;
    }

    // Obtener email del usuario actual
    getCurrentUserEmail() {
        return localStorage.getItem('userEmail');
    }

    // Obtener datos del usuario actual (desde el servidor)
    async getCurrentUser() {
        const email = this.getCurrentUserEmail();
        if (!email) return null;

        try {
            const response = await fetch(`/usuario/email/${encodeURIComponent(email)}`);
            if (response.ok) {
                return await response.json();
            }
        } catch (error) {
            console.error('Error al obtener datos del usuario:', error);
        }
        return null;
    }

    // Guardar sesión del usuario (solo email)
    saveSession(email) {
        localStorage.setItem('userEmail', email);
        localStorage.setItem('usuarioLogueado', 'true');
        this.updateUI();
    }

    // Cerrar sesión
    logout() {
        localStorage.removeItem('userEmail');
        localStorage.removeItem('usuarioLogueado');
        this.updateUI();

        // Redirigir al login si no estamos ya ahí
        if (!window.location.pathname.includes('login')) {
            window.location.href = '/login';
        }
    }

    // Actualizar interfaz según el estado de la sesión
    async updateUI() {
        const isLoggedIn = this.checkSession();

        if (isLoggedIn) {
            const currentUser = await this.getCurrentUser();
            this.updateNavigationButtons(isLoggedIn, currentUser);
            this.updateUserMenu(isLoggedIn, currentUser);
        } else {
            this.updateNavigationButtons(false, null);
            this.updateUserMenu(false, null);
        }
    }

    // Actualizar botones de navegación
    updateNavigationButtons(isLoggedIn, currentUser) {
        // Botón "Publicar Alojamiento"
        const publishButton = document.getElementById('abrirModal');
        if (publishButton) {
            if (isLoggedIn) {
                publishButton.textContent = 'Publicar Alojamiento';
                publishButton.onclick = null; // Restaurar función original
            } else {
                publishButton.textContent = 'Iniciar Sesión';
                publishButton.onclick = () => {
                    window.location.href = '/login';
                };
            }
        }

        // Enlaces de perfil
        const profileLinks = document.querySelectorAll('[href="/profile"]');
        profileLinks.forEach(link => {
            if (isLoggedIn) {
                link.href = '/profile';
            } else {
                link.href = '/login';
            }
        });
    }

    // Actualizar menú de usuario
    updateUserMenu(isLoggedIn, currentUser) {
        const userProfile = document.querySelector('.user-profile');
        if (userProfile && isLoggedIn && currentUser) {
            // Actualizar avatar con iniciales del usuario
            const userAvatar = userProfile.querySelector('.user-avatar');
            if (userAvatar && currentUser.nombre) {
                const initials = (currentUser.nombre.charAt(0) + (currentUser.apellido ? currentUser.apellido.charAt(0) : '')).toUpperCase();
                userAvatar.textContent = initials;
                userAvatar.title = `${currentUser.nombre} ${currentUser.apellido || ''}`.trim();
            }

            // Agregar menú desplegable si no existe
            this.addUserDropdownMenu(userProfile, currentUser);
        }
    }

    // Agregar menú desplegable al perfil de usuario
    addUserDropdownMenu(userProfile, currentUser) {
        // Verificar si ya existe el menú
        if (userProfile.querySelector('.user-dropdown')) {
            return;
        }

        // Crear menú desplegable
        const dropdown = document.createElement('div');
        dropdown.className = 'user-dropdown';
        dropdown.style.cssText = `
            position: absolute;
            top: 100%;
            right: 0;
            background: white;
            border: 1px solid #dddddd;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            min-width: 200px;
            display: none;
            z-index: 1000;
            margin-top: 8px;
        `;

        const nombreCompleto = `${currentUser.nombre || ''} ${currentUser.apellido || ''}`.trim();
        dropdown.innerHTML = `
            <div style="padding: 12px 16px; border-bottom: 1px solid #eeeeee;">
                <div style="font-weight: 600; font-size: 14px;">${nombreCompleto}</div>
                <div style="color: #717171; font-size: 12px;">${currentUser.email}</div>
            </div>
            <a href="/profile" style="display: block; padding: 12px 16px; text-decoration: none; color: #222222; border-bottom: 1px solid #eeeeee;">
                👤 Mi perfil
            </a>
            <a href="/" style="display: block; padding: 12px 16px; text-decoration: none; color: #222222; border-bottom: 1px solid #eeeeee;">
                🏠 Mis alojamientos
            </a>
            <a href="#" onclick="sessionManager.logout()" style="display: block; padding: 12px 16px; text-decoration: none; color: #222222;">
                🚪 Cerrar sesión
            </a>
        `;

        // Hacer el contenedor relativo
        userProfile.style.position = 'relative';
        userProfile.appendChild(dropdown);

        // Toggle del menú
        userProfile.addEventListener('click', (e) => {
            e.stopPropagation();
            const isVisible = dropdown.style.display === 'block';
            dropdown.style.display = isVisible ? 'none' : 'block';
        });

        // Cerrar menú al hacer click fuera
        document.addEventListener('click', () => {
            dropdown.style.display = 'none';
        });

        // Prevenir cierre al hacer click en el menú
        dropdown.addEventListener('click', (e) => {
            e.stopPropagation();
        });
    }

    // Proteger páginas que requieren autenticación
    requireAuth() {
        if (!this.checkSession()) {
            window.location.href = '/login';
            return false;
        }
        return true;
    }

    // Redirigir si ya está logueado (para páginas de login)
    redirectIfLoggedIn() {
        if (this.checkSession()) {
            window.location.href = '/';
            return true;
        }
        return false;
    }

    // Verificar sesión periódicamente
    startSessionCheck() {
        setInterval(() => {
            // Verificar si la sesión sigue siendo válida
            if (!this.checkSession() && !window.location.pathname.includes('login')) {
                this.logout();
            }
        }, 60000); // Verificar cada minuto
    }
}

// Crear instancia global del manejador de sesión
const sessionManager = new SessionManager();

// Iniciar verificación periódica de sesión
sessionManager.startSessionCheck();

// Funciones globales para facilitar el uso
function requireAuth() {
    return sessionManager.requireAuth();
}

function getCurrentUserEmail() {
    return sessionManager.getCurrentUserEmail();
}

function logout() {
    sessionManager.logout();
}

// Exportar para uso en módulos
if (typeof module !== 'undefined' && module.exports) {
    module.exports = SessionManager;
}