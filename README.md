Aquí tienes una versión del README sin las configuraciones adicionales en formato de copia:

# 🏡 Sistema de Inmuebles

## Descripción del Proyecto

El **Sistema de Inmuebles** es una aplicación móvil desarrollada en Flutter, diseñada para facilitar la búsqueda y visualización de propiedades inmobiliarias. Con una interfaz intuitiva y moderna, esta aplicación permite a los usuarios explorar un catálogo de propiedades y ver detalles específicos.

## Estudiantes

- **Alessandro Daniel Morales Sandoval** - *20190652*
- **Fernando José Gómez Martínez** - *20190369*
- **Josué Emiliano Valdés Jacobo** - *20190010*
- **Adriana Elizabeth Orellana Aguilar** - *20220287*
- **José Alejandro Sánchez Henríquez** - *20220141*

## Características Principales

- 🏠 **Catálogo de Inmuebles**: Visualiza una amplia gama de propiedades con imágenes y descripciones detalladas.
- 🌐 **Integración con Google Maps**: Encuentra la ubicación exacta de las propiedades en un mapa interactivo.
- 🔄 **Animaciones y Transiciones**: Navegación fluida y atractiva entre vistas con animaciones modernas.
- 📸 **Visualización de Imágenes**: Ampliación y desplazamiento de imágenes de alta calidad para una mejor visualización.
- 📏 **Diseño Responsivo**: Adaptación perfecta a diferentes tamaños de pantalla y dispositivos.

## Estilo de Código

- 🐫 Se utiliza el estilo `camelCase` para los nombres de variables y métodos.
- 🐍 Se emplea el formato `snake_case` para los nombres de archivos.
- 🏛️ Se utiliza el estilo `PascalCase` para los nombres de clases.


## Dependencias

Este proyecto utiliza las siguientes dependencias de Flutter:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6: Iconos del estilo iOS para Flutter.
  animated_bottom_navigation_bar: 1.3.3: Barra de navegación inferior con animaciones personalizables.
  flutter_animate: ^4.5.0: Herramienta para crear animaciones simples en Flutter.
  go_router: ^14.1.4: Paquete para gestionar la navegación en Flutter de manera declarativa.
  page_transition: ^2.0.8: Proporciona animaciones de transición entre páginas.
  animations: ^2.0.0: Colección de animaciones predefinidas en Flutter.
  get: ^4.6.5: Paquete de gestión de estado y dependencias en Flutter.
  lottie: ^3.1.2: Muestra animaciones Lottie en Flutter.
  flutter_screenutil: ^5.9.3: Maneja el diseño responsivo según el tamaño de la pantalla.
  google_maps_flutter: ^2.6.1: Implementa Google Maps en aplicaciones Flutter.
  geocoding: ^3.0.0: Proporciona servicios de geocodificación (convertir direcciones en coordenadas y viceversa).
  photo_view: ^0.15.0: Para ver imágenes con zoom y desplazamiento.
  animated_splash_screen: ^1.3.0: Crea pantallas de carga animadas.
  smooth_page_indicator: ^1.1.0: Indicador de página personalizable para carruseles.
  flutter_secure_storage: ^9.2.2: Almacenamiento seguro para datos confidenciales en Flutter.
  http: ^1.2.2: Maneja peticiones HTTP.
  crypto: ^3.0.3: Proporciona funciones criptográficas (hashing, HMAC, etc.).
  provider: ^6.1.2: Paquete para la gestión de estado en Flutter.
  animated_toggle_switch: ^0.8.2: Interruptor toggle con animaciones.
  intl: ^0.19.0: Para la internacionalización y localización.
  carousel_slider: ^5.0.0: Crea carruseles de imágenes u otros widgets.
  rive: ^0.13.13: Permite usar animaciones interactivas de Rive en Flutter.
  shared_preferences: ^2.2.3: Almacena datos simples localmente en la app.
  geolocator: ^13.0.1: Proporciona servicios de geolocalización.
  permission_handler: ^11.3.1: Maneja permisos en las aplicaciones Flutter.
  flutter_card_swiper: ^7.0.1: Implementa un swiper (deslizador) de tarjetas.
```

## Configuraciones adicionales

Para el correcto funcionamiento de la aplicación, sea realizo configuraciones adicionales:

1. **Permisos de ubicación**: se configuro los permisos de ubicación en el archivo `AndroidManifest.xml`.
2. **Configuración de Google Maps**: 
   - Para habilitar la funcionalidad de mapas, fue necesario obtener una API Key de Google Maps y agregarla en los archivos de configuración de Android (`AndroidManifest.xml`).
3. **Animaciones Rive**: Si utilizo animaciones con Rive, donde se aseguro de que los archivos `.riv` estén correctamente añadidos a al proyecto y referenciados en el código.

Estas configuraciones son esenciales para que la aplicación funcione correctamente tanto en dispositivos Android como iOS.
