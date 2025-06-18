// crear-alojamiento.js - JavaScript para la página de crear alojamiento

// Estado global de la aplicación
const appState = {
    images: [],
    mainImageIndex: 0,
    selectedAmenities: [],
    formData: {},
    isSubmitting: false
};

// Inicializar la aplicación
document.addEventListener('DOMContentLoaded', function() {
    initializeForm();
    initializeImageUpload();
    initializeAmenities();
    initializeValidation();
    initializePreview();
    initializeProgressTracking();
    updateProgress();
});

// Inicializar formulario
function initializeForm() {
    const form = document.getElementById('crear-alojamiento-form');
    if (!form) return;

    // Agregar listeners a todos los inputs
    const inputs = form.querySelectorAll('input, textarea, select');
    inputs.forEach(input => {
        input.addEventListener('input', handleInputChange);
        input.addEventListener('blur', validateField);
    });

    // Prevenir envío normal del formulario
    form.addEventListener('submit', handleFormSubmit);
}

// Manejar cambios en inputs
function handleInputChange(event) {
    const { name, value, type } = event.target;
    
    // Actualizar estado
    if (type === 'number') {
        appState.formData[name] = parseFloat(value) || 0;
    } else {
        appState.formData[name] = value;
    }

    // Actualizar preview
    updatePreview();
    updateProgress();
    
    // Limpiar errores al escribir
    clearFieldError(event.target);
}

// Validar campo individual
function validateField(event) {
    const field = event.target;
    const value = field.value.trim();
    const name = field.name;

    let isValid = true;
    let errorMessage = '';

    // Validaciones específicas por campo
    switch (name) {
        case 'titulo':
            if (!value) {
                errorMessage = 'El título es obligatorio';
                isValid = false;
            } else if (value.length < 10) {
                errorMessage = 'El título debe tener al menos 10 caracteres';
                isValid = false;
            }
            break;

        case 'descripcion':
            if (!value) {
                errorMessage = 'La descripción es obligatoria';
                isValid = false;
            } else if (value.length < 50) {
                errorMessage = 'La descripción debe tener al menos 50 caracteres';
                isValid = false;
            }
            break;

        case 'precioNoche':
            const precio = parseFloat(value);
            if (!precio || precio <= 0) {
                errorMessage = 'El precio debe ser mayor a 0';
                isValid = false;
            } else if (precio > 10000) {
                errorMessage = 'El precio no puede superar los 10,000€';
                isValid = false;
            }
            break;

        case 'capacidad':
        case 'habitaciones':
        case 'camas':
        case 'banos':
            const num = parseInt(value);
            if (!num || num <= 0) {
                errorMessage = 'Debe ser un número mayor a 0';
                isValid = false;
            } else if (num > 50) {
                errorMessage = 'El valor es demasiado alto';
                isValid = false;
            }
            break;

        case 'ciudad':
        case 'pais':
            if (!value) {
                errorMessage = 'Este campo es obligatorio';
                isValid = false;
            } else if (value.length < 2) {
                errorMessage = 'Debe tener al menos 2 caracteres';
                isValid = false;
            }
            break;

        case 'direccion':
            if (!value) {
                errorMessage = 'La dirección es obligatoria';
                isValid = false;
            } else if (value.length < 10) {
                errorMessage = 'La dirección debe ser más específica';
                isValid = false;
            }
            break;
    }

    // Mostrar/ocultar error
    if (isValid) {
        showFieldSuccess(field);
    } else {
        showFieldError(field, errorMessage);
    }

    return isValid;
}

// Mostrar error en campo
function showFieldError(field, message) {
    field.classList.add('error');
    field.classList.remove('success');
    
    let errorDiv = field.parentNode.querySelector('.error-message');
    if (!errorDiv) {
        errorDiv = document.createElement('div');
        errorDiv.className = 'error-message';
        field.parentNode.appendChild(errorDiv);
    }
    errorDiv.textContent = message;
}

// Mostrar éxito en campo
function showFieldSuccess(field) {
    field.classList.add('success');
    field.classList.remove('error');
    clearFieldError(field);
}

// Limpiar error de campo
function clearFieldError(field) {
    field.classList.remove('error');
    const errorDiv = field.parentNode.querySelector('.error-message');
    if (errorDiv) {
        errorDiv.remove();
    }
}

// Inicializar subida de imágenes
function initializeImageUpload() {
    const uploadArea = document.getElementById('image-upload-area');
    const fileInput = document.getElementById('image-input');

    if (!uploadArea || !fileInput) return;

    // Click en área de subida
    uploadArea.addEventListener('click', () => fileInput.click());

    // Drag and drop
    uploadArea.addEventListener('dragover', handleDragOver);
    uploadArea.addEventListener('dragleave', handleDragLeave);
    uploadArea.addEventListener('drop', handleDrop);

    // Selección de archivos
    fileInput.addEventListener('change', handleFileSelect);
}

// Manejar drag over
function handleDragOver(event) {
    event.preventDefault();
    event.currentTarget.classList.add('drag-over');
}

// Manejar drag leave
function handleDragLeave(event) {
    event.currentTarget.classList.remove('drag-over');
}

// Manejar drop
function handleDrop(event) {
    event.preventDefault();
    event.currentTarget.classList.remove('drag-over');
    
    const files = Array.from(event.dataTransfer.files);
    processImageFiles(files);
}

// Manejar selección de archivos
function handleFileSelect(event) {
    const files = Array.from(event.target.files);
    processImageFiles(files);
}

// Procesar archivos de imagen
function processImageFiles(files) {
    const imageFiles = files.filter(file => file.type.startsWith('image/'));
    
    if (imageFiles.length === 0) {
        alert('⚠️ Por favor selecciona solo archivos de imagen');
        return;
    }

    if (appState.images.length + imageFiles.length > 10) {
        alert('⚠️ Máximo 10 imágenes permitidas');
        return;
    }

    imageFiles.forEach(file => {
        if (file.size > 5 * 1024 * 1024) { // 5MB
            alert(`⚠️ La imagen ${file.name} es demasiado grande (máximo 5MB)`);
            return;
        }

        const reader = new FileReader();
        reader.onload = function(e) {
            const imageData = {
                file: file,
                url: e.target.result,
                name: file.name,
                isMain: appState.images.length === 0 // Primera imagen es principal
            };
            
            appState.images.push(imageData);
            renderImagePreviews();
            updateProgress();
        };
        reader.readAsDataURL(file);
    });
}

// Renderizar previsualizaciones de imágenes
function renderImagePreviews() {
    const container = document.getElementById('image-preview-grid');
    if (!container) return;

    container.innerHTML = '';

    appState.images.forEach((image, index) => {
        const previewDiv = document.createElement('div');
        previewDiv.className = 'image-preview';
        previewDiv.innerHTML = `
            <img src="${image.url}" alt="${image.name}" class="preview-img">
            <div class="image-controls">
                <button type="button" class="control-btn main-btn" onclick="setMainImage(${index})" title="Imagen principal">
                    <i class="fas fa-star"></i>
                </button>
                <button type="button" class="control-btn delete-btn" onclick="removeImage(${index})" title="Eliminar">
                    <i class="fas fa-trash"></i>
                </button>
            </div>
            ${image.isMain ? '<div class="main-badge">Principal</div>' : ''}
        `;
        container.appendChild(previewDiv);
    });

    // Actualizar preview
    updatePreview();
}

// Establecer imagen principal
function setMainImage(index) {
    appState.images.forEach((img, i) => {
        img.isMain = i === index;
    });
    appState.mainImageIndex = index;
    renderImagePreviews();
    updatePreview();
}

// Remover imagen
function removeImage(index) {
    if (confirm('¿Eliminar esta imagen?')) {
        const wasMain = appState.images[index].isMain;
        appState.images.splice(index, 1);
        
        // Si era la principal, hacer principal la primera
        if (wasMain && appState.images.length > 0) {
            appState.images[0].isMain = true;
            appState.mainImageIndex = 0;
        }
        
        renderImagePreviews();
        updateProgress();
    }
}

// Inicializar comodidades
function initializeAmenities() {
    const amenityCheckboxes = document.querySelectorAll('.amenity-checkbox');
    
    amenityCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('click', function() {
            const input = this.querySelector('.checkbox-input');
            const amenityValue = input.value;
            
            input.checked = !input.checked;
            this.classList.toggle('selected', input.checked);
            
            if (input.checked) {
                appState.selectedAmenities.push(amenityValue);
            } else {
                const index = appState.selectedAmenities.indexOf(amenityValue);
                if (index > -1) {
                    appState.selectedAmenities.splice(index, 1);
                }
            }
            
            updatePreview();
            updateProgress();
        });
    });
}

// Inicializar validación
function initializeValidation() {
    // Validación en tiempo real ya está en handleInputChange
}

// Inicializar preview
function initializePreview() {
    updatePreview();
}

// Actualizar preview
function updatePreview() {
    const previewTitle = document.getElementById('preview-title');
    const previewLocation = document.getElementById('preview-location');
    const previewCapacidad = document.getElementById('preview-capacidad');
    const previewHabitaciones = document.getElementById('preview-habitaciones');
    const previewCamas = document.getElementById('preview-camas');
    const previewBanos = document.getElementById('preview-banos');
    const previewPrecio = document.getElementById('preview-precio');

    if (previewTitle) {
        previewTitle.textContent = appState.formData.titulo || 'Tu increíble alojamiento';
    }
    
    if (previewLocation) {
        const ciudad = appState.formData.ciudad || 'Ciudad';
        const pais = appState.formData.pais || 'País';
        previewLocation.textContent = `${ciudad}, ${pais}`;
    }

    if (previewCapacidad) {
        previewCapacidad.textContent = appState.formData.capacidad || '0';
    }

    if (previewHabitaciones) {
        previewHabitaciones.textContent = appState.formData.habitaciones || '0';
    }

    if (previewCamas) {
        previewCamas.textContent = appState.formData.camas || '0';
    }

    if (previewBanos) {
        previewBanos.textContent = appState.formData.banos || '0';
    }

    if (previewPrecio) {
        previewPrecio.textContent = appState.formData.precioNoche || '0';
    }
}

// Inicializar seguimiento de progreso
function initializeProgressTracking() {
    updateProgress();
}

// Actualizar barra de progreso
function updateProgress() {
    const progressFill = document.getElementById('progress-fill');
    const progressText = document.getElementById('progress-text');
    
    if (!progressFill || !progressText) return;

    let completedSteps = 0;
    const totalSteps = 7;

    // Información básica
    if (appState.formData.titulo && appState.formData.descripcion) {
        completedSteps++;
    }

    // Tipo y ubicación
    if (appState.formData.tipoAlojamiento && appState.formData.ciudad && appState.formData.pais) {
        completedSteps++;
    }

    // Dirección
    if (appState.formData.direccion) {
        completedSteps++;
    }

    // Capacidad
    if (appState.formData.capacidad && appState.formData.habitaciones && 
        appState.formData.camas && appState.formData.banos) {
        completedSteps++;
    }

    // Precio
    if (appState.formData.precioNoche && appState.formData.precioNoche > 0) {
        completedSteps++;
    }

    // Imágenes
    if (appState.images.length > 0) {
        completedSteps++;
    }

    // Comodidades
    if (appState.selectedAmenities.length > 0) {
        completedSteps++;
    }

    const percentage = (completedSteps / totalSteps) * 100;
    progressFill.style.width = `${percentage}%`;
    progressText.textContent = `Progreso: ${Math.round(percentage)}% completado (${completedSteps}/${totalSteps} secciones)`;
}

// Validar formulario completo
function validateForm() {
    const form = document.getElementById('crear-alojamiento-form');
    const requiredFields = form.querySelectorAll('[required]');
    let isValid = true;
    
    requiredFields.forEach(field => {
        if (!validateField({ target: field })) {
            isValid = false;
        }
    });

    // Validaciones adicionales
    if (appState.images.length === 0) {
        showNotification('⚠️ Debes subir al menos una imagen', 'error');
        isValid = false;
    }

    // No requerir servicios como obligatorios, pero dar aviso
    if (appState.selectedAmenities.length === 0) {
        showNotification('ℹ️ Considera añadir algunas comodidades para hacer tu alojamiento más atractivo', 'info');
        // No marcar como inválido, solo informativo
    }

    return isValid;
}

// Manejar envío del formulario
async function handleFormSubmit(event) {
    event.preventDefault();
    
    if (appState.isSubmitting) return;
    
    if (!validateForm()) {
        alert('⚠️ Por favor completa todos los campos obligatorios');
        return;
    }

    const userEmail = localStorage.getItem('userEmail');
    if (!userEmail) {
        alert('⚠️ Debes iniciar sesión para crear un alojamiento');
        window.location.href = '/login';
        return;
    }

    appState.isSubmitting = true;
    updateSubmitButton(true);

    try {
        // Crear alojamiento directamente (sin subir imágenes por separado)
        const result = await createAccommodation(userEmail);
        
        console.log('Respuesta del servidor:', result);
        
        if (result.includes('correctamente')) {
            // Éxito
            showSuccess();
            
            // Limpiar localStorage
            localStorage.removeItem('alojamiento_draft');
        } else {
            throw new Error(result);
        }
        
    } catch (error) {
        console.error('Error al crear alojamiento:', error);
        alert('❌ Error al crear el alojamiento: ' + error.message);
    } finally {
        appState.isSubmitting = false;
        updateSubmitButton(false);
    }
}

// Subir imágenes
async function uploadImages() {
    if (appState.images.length === 0) return [];

    const imageUrls = [];
    
    for (const image of appState.images) {
        try {
            // Simular subida de imagen (aquí implementarías la subida real)
            const formData = new FormData();
            formData.append('image', image.file);
            formData.append('isMain', image.isMain);
            
            // Por ahora simulamos URLs
            const simulatedUrl = `/uploads/images/${Date.now()}_${image.name}`;
            imageUrls.push({
                url: simulatedUrl,
                isMain: image.isMain,
                description: image.name
            });
            
        } catch (error) {
            console.error('Error subiendo imagen:', error);
            throw new Error(`Error al subir la imagen ${image.name}`);
        }
    }
    
    return imageUrls;
}

// Crear alojamiento
async function createAccommodation(userEmail) {
    const formData = new FormData();
    
    // Datos básicos del formulario
    Object.keys(appState.formData).forEach(key => {
        if (appState.formData[key] !== undefined && appState.formData[key] !== '') {
            formData.append(key, appState.formData[key]);
        }
    });
    
    // Email del propietario
    formData.append('emailPropietario', userEmail);
    
    // Comodidades (enviar como string separado por comas)
    if (appState.selectedAmenities.length > 0) {
        formData.append('servicios', appState.selectedAmenities.join(','));
    }
    
    // Agregar archivos de imagen
    if (appState.images.length > 0) {
        appState.images.forEach((imageData, index) => {
            formData.append('imagenes', imageData.file);
        });
    }

    const response = await fetch('/alojamiento/add', {
        method: 'POST',
        body: formData
    });

    if (!response.ok) {
        const errorText = await response.text();
        throw new Error(errorText || 'Error del servidor');
    }

    return response.text();
}

// Mostrar éxito
function showSuccess() {
    // Crear modal de éxito
    const modal = document.createElement('div');
    modal.className = 'success-modal';
    modal.innerHTML = `
        <div class="success-content">
            <div class="success-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <h2>¡Alojamiento creado con éxito! 🎉</h2>
            <p>Tu alojamiento ha sido publicado y ya está disponible para reservas.</p>
            <div class="success-actions">
                <button onclick="goToListing()" class="btn-primary">Ver mi alojamiento</button>
                <button onclick="goToHome()" class="btn-secondary">Ir al inicio</button>
            </div>
        </div>
    `;
    
    // Estilos del modal
    modal.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.8);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 10000;
    `;
    
    const content = modal.querySelector('.success-content');
    content.style.cssText = `
        background: white;
        padding: 40px;
        border-radius: 20px;
        text-align: center;
        max-width: 500px;
        margin: 20px;
    `;
    
    const icon = modal.querySelector('.success-icon');
    icon.style.cssText = `
        font-size: 4rem;
        color: #51cf66;
        margin-bottom: 20px;
    `;
    
    const actions = modal.querySelector('.success-actions');
    actions.style.cssText = `
        display: flex;
        gap: 15px;
        margin-top: 30px;
    `;
    
    document.body.appendChild(modal);
}

// Ir al listado
function goToListing() {
    // Aquí necesitarías el ID del alojamiento creado
    window.location.href = '/';
}

// Ir al inicio
function goToHome() {
    window.location.href = '/';
}

// Actualizar botón de envío
function updateSubmitButton(isLoading) {
    const submitBtn = document.getElementById('submit-btn');
    const previewBtn = document.getElementById('preview-btn');
    
    if (!submitBtn) return;
    
    if (isLoading) {
        submitBtn.innerHTML = '<span class="spinner"></span> Creando alojamiento...';
        submitBtn.disabled = true;
        if (previewBtn) previewBtn.disabled = true;
    } else {
        submitBtn.innerHTML = '<i class="fas fa-home"></i> Crear alojamiento';
        submitBtn.disabled = false;
        if (previewBtn) previewBtn.disabled = false;
    }
}

// Guardar borrador
function saveDraft() {
    const draftData = {
        formData: appState.formData,
        selectedAmenities: appState.selectedAmenities,
        timestamp: new Date().toISOString()
    };
    
    localStorage.setItem('alojamiento_draft', JSON.stringify(draftData));
    
    // Mostrar notificación
    showNotification('💾 Borrador guardado', 'success');
}

// Cargar borrador
function loadDraft() {
    const draftData = localStorage.getItem('alojamiento_draft');
    if (!draftData) return;
    
    try {
        const data = JSON.parse(draftData);
        
        if (confirm('Se encontró un borrador guardado. ¿Deseas cargarlo?')) {
            appState.formData = data.formData || {};
            appState.selectedAmenities = data.selectedAmenities || [];
            
            // Rellenar formulario
            Object.keys(appState.formData).forEach(key => {
                const field = document.querySelector(`[name="${key}"]`);
                if (field) {
                    field.value = appState.formData[key];
                }
            });
            
            // Marcar comodidades
            appState.selectedAmenities.forEach(amenity => {
                const checkbox = document.querySelector(`input[value="${amenity}"]`);
                if (checkbox) {
                    checkbox.checked = true;
                    checkbox.closest('.amenity-checkbox').classList.add('selected');
                }
            });
            
            updatePreview();
            updateProgress();
            
            showNotification('📂 Borrador cargado', 'success');
        }
    } catch (error) {
        console.error('Error cargando borrador:', error);
    }
}

// Mostrar notificación
function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `notification ${type}`;
    notification.textContent = message;
    
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: ${type === 'success' ? '#51cf66' : type === 'error' ? '#ff6b6b' : '#667eea'};
        color: white;
        padding: 15px 20px;
        border-radius: 10px;
        z-index: 10000;
        font-weight: 600;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        transform: translateX(100%);
        transition: transform 0.3s ease;
    `;
    
    document.body.appendChild(notification);
    
    // Animar entrada
    setTimeout(() => {
        notification.style.transform = 'translateX(0)';
    }, 100);
    
    // Remover después de 3 segundos
    setTimeout(() => {
        notification.style.transform = 'translateX(100%)';
        setTimeout(() => {
            if (notification.parentNode) {
                notification.parentNode.removeChild(notification);
            }
        }, 300);
    }, 3000);
}

// Vista previa
function previewAccommodation() {
    if (!validateForm()) {
        alert('⚠️ Por favor completa todos los campos para ver la vista previa');
        return;
    }
    
    // Crear modal de vista previa
    const modal = document.createElement('div');
    modal.className = 'preview-modal';
    modal.innerHTML = createPreviewHTML();
    
    modal.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.9);
        z-index: 10000;
        overflow-y: auto;
        padding: 20px;
    `;
    
    document.body.appendChild(modal);
    
    // Cerrar modal
    modal.addEventListener('click', function(e) {
        if (e.target === modal) {
            document.body.removeChild(modal);
        }
    });
}

// Crear HTML de vista previa
function createPreviewHTML() {
    const mainImage = appState.images.find(img => img.isMain) || appState.images[0];
    
    return `
        <div class="preview-container" style="max-width: 800px; margin: 0 auto; background: white; border-radius: 20px; overflow: hidden;">
            <div class="preview-header" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; text-align: center;">
                <h1 style="font-size: 2.5rem; margin-bottom: 10px;">${appState.formData.titulo || 'Sin título'}</h1>
                <p style="font-size: 1.2rem; opacity: 0.9;">${appState.formData.ciudad || 'Ciudad'}, ${appState.formData.pais || 'País'}</p>
                <span style="background: rgba(255,255,255,0.2); padding: 8px 16px; border-radius: 20px; font-size: 1rem; margin-top: 10px; display: inline-block;">
                    ${appState.formData.tipoAlojamiento || 'Tipo de alojamiento'}
                </span>
            </div>
            
            ${mainImage ? `<img src="${mainImage.url}" style="width: 100%; height: 300px; object-fit: cover;">` : '<div style="height: 300px; background: #f0f0f0; display: flex; align-items: center; justify-content: center; color: #999;">Sin imagen principal</div>'}
            
            <div style="padding: 30px;">
                <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 30px;">
                    <div style="text-align: center; padding: 20px; background: #f8f9fa; border-radius: 15px;">
                        <div style="font-size: 2rem; margin-bottom: 10px;">👥</div>
                        <div style="font-weight: 600;">${appState.formData.capacidad || 0} huéspedes</div>
                    </div>
                    <div style="text-align: center; padding: 20px; background: #f8f9fa; border-radius: 15px;">
                        <div style="font-size: 2rem; margin-bottom: 10px;">🛏️</div>
                        <div style="font-weight: 600;">${appState.formData.habitaciones || 0} habitaciones</div>
                    </div>
                    <div style="text-align: center; padding: 20px; background: #f8f9fa; border-radius: 15px;">
                        <div style="font-size: 2rem; margin-bottom: 10px;">🛌</div>
                        <div style="font-weight: 600;">${appState.formData.camas || 0} camas</div>
                    </div>
                    <div style="text-align: center; padding: 20px; background: #f8f9fa; border-radius: 15px;">
                        <div style="font-size: 2rem; margin-bottom: 10px;">🚿</div>
                        <div style="font-weight: 600;">${appState.formData.banos || 0} baños</div>
                    </div>
                </div>
                
                <div style="margin-bottom: 30px;">
                    <h3 style="font-size: 1.5rem; margin-bottom: 15px; color: #333;">Descripción</h3>
                    <p style="line-height: 1.6; color: #666;">${appState.formData.descripcion || 'Sin descripción'}</p>
                </div>
                
                <div style="margin-bottom: 30px;">
                    <h3 style="font-size: 1.5rem; margin-bottom: 15px; color: #333;">Comodidades</h3>
                    <div style="display: flex; flex-wrap: wrap; gap: 10px;">
                        ${appState.selectedAmenities.map(amenity => `
                            <span style="background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%); padding: 8px 16px; border-radius: 20px; font-size: 0.9rem; font-weight: 500;">
                                ${amenity}
                            </span>
                        `).join('')}
                    </div>
                </div>
                
                <div style="text-align: center; padding: 30px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 15px; color: white;">
                    <div style="font-size: 3rem; font-weight: 700; margin-bottom: 10px;">${appState.formData.precioNoche || 0}€</div>
                    <div style="font-size: 1.2rem; opacity: 0.9;">por noche</div>
                </div>
                
                <div style="text-align: center; margin-top: 30px;">
                    <button onclick="document.body.removeChild(document.querySelector('.preview-modal'))" style="background: #667eea; color: white; border: none; padding: 15px 30px; border-radius: 10px; font-size: 1.1rem; font-weight: 600; cursor: pointer;">
                        Cerrar vista previa
                    </button>
                </div>
            </div>
        </div>
    `;
}

// Auto-guardar borrador cada 30 segundos
setInterval(() => {
    if (Object.keys(appState.formData).length > 0) {
        saveDraft();
    }
}, 30000);

// Cargar borrador al iniciar
document.addEventListener('DOMContentLoaded', function() {
    setTimeout(loadDraft, 1000);
});

// Prevenir pérdida de datos
window.addEventListener('beforeunload', function(e) {
    if (Object.keys(appState.formData).length > 0 && !appState.isSubmitting) {
        e.preventDefault();
        e.returnValue = '¿Estás seguro de que quieres salir? Los cambios no guardados se perderán.';
        saveDraft();
    }
});

// Exportar funciones globales
window.crearAlojamientoApp = {
    setMainImage,
    removeImage,
    saveDraft,
    loadDraft,
    previewAccommodation,
    goToHome,
    goToListing
};