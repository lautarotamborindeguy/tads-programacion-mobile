# WelcomeScreen

## Archivo
- `lib/screens/welcome_screen.dart`

## Objetivo
Pantalla posterior al inicio de sesión para registrar datos del usuario y mostrar una confirmación visual de bienvenida.

## Responsabilidades
- Mostrar un mensaje de bienvenida con el nombre de usuario recibido en la navegación.
- Mostrar campos de registro: nombre, dirección, curso, ciudad y país.
- Permitir guardar datos y mostrar el contenido ingresado en un `AlertDialog`.
- Permitir volver a la pantalla de inicio de sesión.

## Estructura principal
- `WelcomeScreen`: `StatefulWidget`
- `_WelcomeScreenState`: estado de la pantalla y controladores de los campos.

## Propiedades
- `username` (`String`): nombre de usuario recibido desde la pantalla de inicio de sesión.

## Métodos importantes
- `_saveData()`:
  - Lee los valores ingresados.
  - Muestra un `AlertDialog` con los datos informados.

## Componentes reutilizados
- `AppTextField` en `lib/widgets/app_text_field.dart`.

## Dependencias
- `package:flutter/material.dart`
- `package:first_app/widgets/app_text_field.dart`

## Observaciones
- Los controladores se liberan en `dispose()`.
- El botón Volver usa `Navigator.pop(context)` para regresar a la pantalla anterior.
