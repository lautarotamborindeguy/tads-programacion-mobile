# AppTextField

## Archivo
- `lib/widgets/app_text_field.dart`

## Objetivo
Widget reutilizable para estandarizar campos de texto con un estilo consistente. Soporta iconos de prefijo y modo contraseña con visibilidad togglable.

## Responsabilidades
- Encapsular un `TextField` con:
  - `controller` obligatorio.
  - `label` obligatorio.
  - `OutlineInputBorder` como borde predeterminado.
  - Icono de prefijo opcional.
  - Modo contraseña opcional con botón para mostrar/ocultar el texto.

## Estructura principal
- `AppTextField`: `StatefulWidget`
- `_AppTextFieldState`: gestiona el estado de visibilidad de la contraseña.

## Parámetros
- `controller` (`TextEditingController`): controla el valor del campo.
- `label` (`String`): texto mostrado en la etiqueta del campo.
- `icon` (`IconData?`, opcional): icono mostrado al inicio del campo.
- `isPassword` (`bool`, opcional, default `false`): activa el modo contraseña con texto oculto y botón de visibilidad.

## Dependencias
- `package:flutter/material.dart`

## Beneficio de la componentización
- Reduce repetición de código en las pantallas.
- Facilita el mantenimiento visual y funcional de los campos.
- Centraliza la lógica de visibilidad de contraseña.
