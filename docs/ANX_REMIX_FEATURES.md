# Anx Remix: Mejoras e Historial de Desarrollo

Este documento detalla el historial de desarrollo, las mejoras implementadas y una comparación técnica de las características exclusivas de **Anx Remix** frente al proyecto base original (*ANX Reader*).

---

## Comparativa: Proyecto Base vs. Anx Remix

| Característica | Proyecto Base (ANX Reader) | Anx Remix (Nuestro Proyecto) |
| :--- | :--- | :--- |
| **Resaltado de Narrador TTS** | Color y opacidad estáticos y cableados en el código (`#39c5bc83`). Sin opción de personalización. | **Totalmente personalizable**. Ajuste dinámico de color mediante selector de color e intensidad de opacidad (0% - 100%) mediante control deslizante (Slider) en Ajustes. |
| **Diccionario Nativo Offline** | No tiene soporte para diccionarios locales ni offline. | **Soporte completo para MDict (`.mdx`)**. Importación física, gestión de múltiples archivos y almacenamiento seguro en el directorio de la aplicación. |
| **Búsqueda Inteligente (Stemming)** | No aplica. | **Algoritmo de conjugación y flexión**. Si una palabra no se encuentra (ej. "thinking"), busca automáticamente formas base ("think") en el diccionario. |
| **Resolución de Redirecciones** | No aplica. | **Soporte recursivo de redirecciones (`@@@LINK=`)** hasta 5 niveles para evitar definiciones vacías en diccionarios complejos. |
| **Búsqueda Online de Respaldo** | No aplica. | **Cliente REST API de Wiktionary** integrado. Filtra automáticamente las definiciones según el idioma del libro actual y ofrece inglés como respaldo. |
| **Menú Contextual (Un solo clic)** | Error conocido en Linux y Android donde al seleccionar una sola palabra no siempre se despliega el menú contextual del lector. | **Corrección del Bridge JS (Foliate)**. Eventos personalizados (`pointerup` y `selectionchange` con debounce) para forzar la aparición del menú al tocar una sola palabra. |
| **Navegación Interactiva** | No aplica. | **Enlaces interactivos en la definición**. Al tocar cualquier palabra con enlace (`entry://`) en el panel inferior, realiza una búsqueda recursiva inmediata en caliente. |
| **Identidad Visual / Rebranding** | Identificado como "ANX Reader" de manera genérica. | **Rebranded a "Anx Remix"**. Personalizado en las pantallas, barra de títulos de escritorio (Linux), recursos XML nativos de Android, Info.plist de iOS, y archivos de traducción (ARB). |

---

## Detalle de Mejoras Implementadas

### 1. Sistema de Narración TTS Personalizable
* **Control en Interfaz de Usuario**: Añadido un selector de color interactivo (`flutter_colorpicker`) y un `Slider` de opacidad en la sección *Ajustes de Narración*.
* **Puente de Datos (Dart-to-JS Bridge)**: Implementado el paso de variables dinámicas al inicializar el WebView y al modificar estilos al vuelo, propagando el color Hex y la opacidad decimal a la biblioteca Foliate-JS en tiempo real.
* **Inyección de CSS dinámico**: Modificada la lógica interna de `initTTS` en JavaScript para computar un color RGBA hexadecimal dinámico y aplicar el resaltado sobre el lienzo de lectura sin alterar el rendimiento.

### 2. Diccionario Offline MDict (.mdx) y Consulta Online
* **Integración del Lector MDict**: Añadido el paquete `dict_reader` en Dart para interpretar de manera nativa la estructura de compresión y los índices binarios de los archivos `.mdx`.
* **Migración de Base de Datos (v8)**: Diseñada y ejecutada la actualización de base de datos SQLite para incorporar la tabla `tb_dictionaries` que rastrea el nombre del archivo, su ruta interna y su estado activo.
* **Limpieza de Contenido HTML**:
  * Diseñado un limpiador regex para eliminar etiquetas de estilo CSS embebidas en los registros MDX (evitando que el código CSS crudo se renderice como texto plano).
  * Expandida la lista blanca de etiquetas HTML soportadas por el renderizador para preservar la estructura visual del diccionario (subrayados, bloques de citas, cursivas, etc.).
* **Flujo de Consulta de Palabras**:
  1. **Limpieza de Puntuación**: Expresión regular Unicode que remueve símbolos y signos de puntuación iniciales y finales, aislando la palabra limpia.
  2. **Búsqueda Exacta Offline**: Consulta directa en el diccionario MDict activo.
  3. **Algoritmo de Desconjugación**: Si no hay match, se prueban variantes flexionadas (tiempos verbales, plurales) usando una cola de fallbacks.
  4. **Fallback Online**: Si no hay diccionario o la palabra no existe localmente, consulta la REST API de Wiktionary filtrada por el idioma del libro.
  5. **Panel Inferior (Bottom Sheet)**: Muestra el resultado de forma elegante, tolerando errores de conexión y permitiendo recargar o navegar mediante hipervínculos dentro del panel.

### 3. Rebranding Completo a "Anx Remix"
Para consolidar este fork como una versión mejorada, modificamos los siguientes puntos de entrada sin romper la base de datos ni los identificadores de paquetes:
* `lib/main.dart` y `lib/utils/window_position_validator.dart` (Títulos de Flutter y Windows Manager).
* `android/app/src/main/res/values/strings.xml` y `values-zh/strings.xml` (Nombre nativo en sistema Android).
* `ios/Runner.xcodeproj/project.pbxproj` (Configuración `CFBundleDisplayName` en iOS).
* `assets/foliate-js/index.html` (Título del lector WebView).
* `lib/l10n/app_en.arb` y `lib/l10n/app_es.arb` (Cadenas localizadas del sistema).
* Ejecución exitosa de `flutter gen-l10n` para actualizar los bindings de traducción generados.
