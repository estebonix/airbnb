<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Airbnb</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: #f8f9fa;
            margin: 0;
            padding: 50px 20px;
            text-align: center;
        }
        .error-container {
            max-width: 500px;
            margin: 0 auto;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .error-icon {
            font-size: 48px;
            margin-bottom: 20px;
        }
        .error-title {
            font-size: 24px;
            color: #dc3545;
            margin-bottom: 16px;
        }
        .error-message {
            color: #666;
            margin-bottom: 30px;
            line-height: 1.5;
        }
        .btn {
            background: #FF385C;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            display: inline-block;
            margin: 0 10px;
        }
        .btn:hover {
            background: #e31c5f;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">😕</div>
        <h1 class="error-title">Oops! Algo salió mal</h1>
        <p class="error-message">
            Ha ocurrido un error inesperado. Por favor, intenta de nuevo.
        </p>
        <a href="/" class="btn">Volver al inicio</a>
        <a href="/login" class="btn">Iniciar sesión</a>
    </div>
</body>
</html>