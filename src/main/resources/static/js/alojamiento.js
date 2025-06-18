// Function to change main image
function changeMainImage(src) {
    const mainImage = document.querySelector('.main-image');
    mainImage.style.transform = 'scale(0.95)';
    setTimeout(() => {
        mainImage.src = src;
        mainImage.style.transform = 'scale(1)';
    }, 150);
}

// Initialize page functionality
document.addEventListener('DOMContentLoaded', function() {
    initializeDateInputs();
    initializeOwnerActions();
    initializePriceCalculation();
    initializeScrollAnimations();
    initializeImageLoadingStates();
    initializeFormSubmission();
    initializeKeyboardNavigation();
});

// Set minimum date for booking and add validation
function initializeDateInputs() {
    const today = new Date().toISOString().split('T')[0];
    const checkinInput = document.querySelector('input[name="checkin"]');
    const checkoutInput = document.querySelector('input[name="checkout"]');
    
    if (checkinInput) checkinInput.min = today;
    if (checkoutInput) checkoutInput.min = today;

    // Update checkout min date when checkin changes
    if (checkinInput && checkoutInput) {
        checkinInput.addEventListener('change', function() {
            checkoutInput.min = this.value;
            if (checkoutInput.value && checkoutInput.value <= this.value) {
                checkoutInput.value = '';
            }
            updatePricing();
        });
        
        checkoutInput.addEventListener('change', updatePricing);
    }
}

// Initialize owner actions and permissions
function initializeOwnerActions() {
    console.log('=== INICIALIZANDO PÁGINA DE ALOJAMIENTO ===');
    
    // Get emails safely - these should be passed from the template
    const currentUserEmail = localStorage.getItem('userEmail');
    
    // Note: propietarioEmail should be passed from the FreeMarker template
    // This is a placeholder - in the actual template it would be: const propietarioEmail = '${(alojamiento.propietario.email)!""}';
    const propietarioEmail = window.propietarioEmail || '';
    
    console.log('Email usuario actual:', currentUserEmail);
    console.log('Email propietario:', propietarioEmail);
    
    // Only proceed if both emails exist
    if (currentUserEmail && propietarioEmail && currentUserEmail === propietarioEmail) {
        console.log('✅ Usuario es propietario del alojamiento');
        
        // Show owner options
        const ownerActions = document.getElementById('owner-actions');
        if (ownerActions) {
            ownerActions.style.display = 'flex';
            ownerActions.style.gap = '15px';
        }
        
        // Modify contact button
        const contactBtn = document.querySelector('.host-btn');
        if (contactBtn) {
            contactBtn.innerHTML = '<i class="fas fa-user"></i> Este es tu alojamiento';
            contactBtn.disabled = true;
            contactBtn.style.opacity = '0.6';
            contactBtn.style.cursor = 'not-allowed';
        }
    } else if (currentUserEmail && propietarioEmail) {
        console.log('ℹ️ Usuario no es propietario');
    } else {
        console.log('⚠️ Información de email incompleta');
    }
}

// Contact host function
function contactarAnfitrion(email) {
    console.log('Contactando anfitrión:', email);
    
    if (!email || email.trim() === '') {
        alert('Email del anfitrión no disponible');
        return;
    }
    
    // These should be passed from the template
    const propertyTitle = window.propertyTitle || 'alojamiento';
    
    const subject = `Consulta sobre: ${propertyTitle}`;
    const body = 'Hola, estoy interesado en tu alojamiento y me gustaría hacer una consulta.';
    const mailtoLink = `mailto:${email}?subject=${encodeURIComponent(subject)}&body=${encodeURIComponent(body)}`;
    
    try {
        window.location.href = mailtoLink;
    } catch (error) {
        console.error('Error al abrir cliente de email:', error);
        alert('No se pudo abrir el cliente de email. Email: ' + email);
    }
}

// Edit accommodation function
function editarAlojamiento(id) {
    console.log('Editando alojamiento:', id);
    alert('Funcionalidad de edición en desarrollo. ¡Próximamente disponible!');
}

// Delete accommodation function
function eliminarAlojamiento(id) {
    console.log('Eliminando alojamiento:', id);
    
    if (!confirm('⚠️ ¿Estás seguro de que quieres eliminar este alojamiento?\n\nEsta acción no se puede deshacer.')) {
        return;
    }
    
    const userEmail = localStorage.getItem('userEmail');
    if (!userEmail) {
        alert('Debes estar logueado para realizar esta acción');
        return;
    }
    
    console.log('Enviando solicitud de eliminación...');
    
    // Show loading in button
    const deleteBtn = event.target;
    const originalText = deleteBtn.innerHTML;
    deleteBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Eliminando...';
    deleteBtn.disabled = true;
    
    fetch(`/alojamiento/delete/${id}?emailPropietario=${encodeURIComponent(userEmail)}`, {
        method: 'DELETE'
    })
    .then(response => {
        console.log('Respuesta del servidor:', response.status);
        return response.text();
    })
    .then(result => {
        console.log('Resultado:', result);
        if (result.includes('correctamente')) {
            alert('✅ Alojamiento eliminado correctamente. Redirigiendo...');
            setTimeout(() => {
                window.location.href = '/';
            }, 1500);
        } else {
            alert('❌ ' + result);
            deleteBtn.innerHTML = originalText;
            deleteBtn.disabled = false;
        }
    })
    .catch(error => {
        console.error('Error en eliminación:', error);
        alert('❌ Error al eliminar el alojamiento: ' + error.message);
        deleteBtn.innerHTML = originalText;
        deleteBtn.disabled = false;
    });
}

// Open edit modal function
function openEditModal() {
    alert('🔧 Funcionalidad de edición en desarrollo.\n\n¡Próximamente podrás editar todos los detalles de tu alojamiento!');
}

// Smooth scroll animations
function initializeScrollAnimations() {
    const cards = document.querySelectorAll('.content-card, .detail-card, .amenity-item');
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    });

    cards.forEach(card => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(card);
    });
}

// Calculate price based on dates
function updatePricing() {
    const checkinInput = document.querySelector('input[name="checkin"]');
    const checkoutInput = document.querySelector('input[name="checkout"]');
    
    // This should be passed from the template
    const pricePerNight = window.pricePerNight || 0;
    
    if (checkinInput.value && checkoutInput.value) {
        const checkin = new Date(checkinInput.value);
        const checkout = new Date(checkoutInput.value);
        const nights = Math.ceil((checkout - checkin) / (1000 * 60 * 60 * 24));
        
        if (nights > 0) {
            const subtotal = pricePerNight * nights;
            const cleaningFee = 15;
            const serviceFee = 12;
            const total = subtotal + cleaningFee + serviceFee;
            
            // Update price breakdown
            const priceBreakdown = document.querySelector('.price-breakdown');
            if (priceBreakdown) {
                priceBreakdown.innerHTML = `
                    <div class="price-row">
                        <span>${pricePerNight}€ × ${nights} noche${nights > 1 ? 's' : ''}</span>
                        <span>${subtotal}€</span>
                    </div>
                    <div class="price-row">
                        <span>Tarifa de limpieza</span>
                        <span>${cleaningFee}€</span>
                    </div>
                    <div class="price-row">
                        <span>Tarifa de servicio</span>
                        <span>${serviceFee}€</span>
                    </div>
                    <div class="price-row total-price">
                        <span>Total</span>
                        <span>${total}€</span>
                    </div>
                `;
            }
        }
    }
}

// Initialize price calculation
function initializePriceCalculation() {
    const checkinInput = document.querySelector('input[name="checkin"]');
    const checkoutInput = document.querySelector('input[name="checkout"]');
    
    if (checkinInput) checkinInput.addEventListener('change', updatePricing);
    if (checkoutInput) checkoutInput.addEventListener('change', updatePricing);
}

// Form submission handler
function initializeFormSubmission() {
    const bookingForm = document.querySelector('.booking-form');
    if (!bookingForm) return;
    
    bookingForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        const checkin = document.querySelector('input[name="checkin"]').value;
        const checkout = document.querySelector('input[name="checkout"]').value;
        const guests = document.querySelector('select[name="guests"]').value;
        
        if (!checkin || !checkout) {
            alert('⚠️ Por favor selecciona las fechas de estancia');
            return;
        }
        
        if (new Date(checkout) <= new Date(checkin)) {
            alert('⚠️ La fecha de salida debe ser posterior a la fecha de entrada');
            return;
        }
        
        // Simulate booking process
        const bookBtn = document.querySelector('.book-button');
        const originalText = bookBtn.innerHTML;
        bookBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Procesando...';
        bookBtn.disabled = true;
        
        setTimeout(() => {
            alert(`🎉 ¡Reserva realizada con éxito!\n\n📅 Check-in: ${checkin}\n📅 Check-out: ${checkout}\n👥 Huéspedes: ${guests}\n\n¡Te enviaremos un email de confirmación!`);
            bookBtn.innerHTML = originalText;
            bookBtn.disabled = false;
        }, 2000);
    });
}

// Add keyboard navigation
function initializeKeyboardNavigation() {
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            // Close any modals or go back
            window.history.back();
        }
    });
}

// Add loading states for images
function initializeImageLoadingStates() {
    document.querySelectorAll('img').forEach(img => {
        img.addEventListener('load', function() {
            this.style.opacity = '1';
        });
        
        img.addEventListener('error', function() {
            this.src = '/img/default-property.jpg';
        });
    });
}

// Debug function
function debugAlojamientoData() {
    console.log('=== DEBUG: DATOS DEL ALOJAMIENTO ===');
    console.log('ID:', window.alojamientoId || 'NO_ID');
    console.log('Título:', window.propertyTitle || 'NO_TITULO');
    console.log('Email propietario:', window.propietarioEmail || 'NO_EMAIL');
    console.log('Usuario actual:', localStorage.getItem('userEmail'));
}

// Utility functions for external use
window.alojamientoApp = {
    changeMainImage,
    contactarAnfitrion,
    editarAlojamiento,
    eliminarAlojamiento,
    openEditModal,
    updatePricing,
    debugAlojamientoData
};