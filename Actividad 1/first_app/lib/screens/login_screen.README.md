# LoginScreen

## Archivo
- `lib/screens/login_screen.dart`

## Objetivo
Pantalla de autenticación de la aplicación.

## Responsabilidades
- Mostrar avatar centrado.
- Capturar nombre de usuario y contraseña.
- Permitir mostrar/ocultar contraseña con botón de visibilidad.
- Validar campos vacíos.
- Validar credenciales estáticas con IF/ELSE.
- Navegar a la pantalla de bienvenida cuando el inicio de sesión sea válido.
- Mostrar SnackBar cuando haya error de ingreso o credenciales incorrectas.

## Credenciales estáticas actuales
- Usuario: `professor`
- Contraseña: `123456`

## Estructura principal
- `LoginScreen`: `StatefulWidget`
- `_LoginScreenState`: estado de la pantalla, controladores y validación.

## Métodos importantes
- `_submitLogin()`:
  - Lee los campos.
  - Verifica si están vacíos.
  - Compara con las credenciales fijas.
  - Navega a `WelcomeScreen` en caso de éxito.
  - Muestra SnackBar en caso de error.

## Dependencias
- `package:flutter/material.dart`
- `package:first_app/screens/welcome_screen.dart`

## Observaciones
- Los controladores se liberan en `dispose()`.
- La lógica de autenticación es simple y local, adecuada para fines didácticos.
