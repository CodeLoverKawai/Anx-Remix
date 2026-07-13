# Anx Remix - Release v1.15.2

Esta es la primera entrega oficial y estable de **Anx Remix**, consolidando la independencia completa del proyecto base y todas las mejoras de rendimiento y experiencia de lectura desarrolladas.

---

## 🚀 Novedades de esta Versión (v1.15.0 a v1.15.2)

### 1. Independencia del Paquete (Decoupling)
* Se modificaron los identificadores únicos de aplicación (Bundle ID / Package ID) a `com.pitufus.anx_remix` (Android/Linux/Web) y `com.pitufus.anxRemix` (iOS). 
* Esto permite instalar y ejecutar **Anx Remix** en paralelo con la aplicación original *ANX Reader* sin conflictos de base de datos o almacenamiento.

### 2. Automatización del Proceso de Release
* **[run_release.sh](file:///home/rousseau/Documents/GitHub/Anx-Remix/run_release.sh)**: Script automatizado en Bash para el incremento de versión interactivo en `pubspec.yaml`, generación de tags y despliegue a Git directamente en la rama principal (`main`).
* **[build_apk.sh](file:///home/rousseau/Documents/GitHub/Anx-Remix/scripts/build_apk.sh)**: Automatización de la compilación de APKs de Android por arquitectura (`arm64-v8a`, `armeabi-v7a`, `x86_64`) con renombrado dinámico y copiado directo a la raíz del proyecto.
* **[build_appimage.sh](file:///home/rousseau/Documents/GitHub/Anx-Remix/scripts/build_appimage.sh)**: Script que empaqueta y genera el instalador portable de Linux `Anx_Remix-x86_64.AppImage` descargando la herramienta `appimagetool` y configurando los parámetros gráficos necesarios (incluyendo bypass sandbox de WebKit para Wayland/NVIDIA).

### 3. Correcciones de Estabilidad y Compilación
* Arreglado un fallo de parseo de expresión regular en [release.dart](file:///home/rousseau/Documents/GitHub/Anx-Remix/release.dart) que corrompía el formato de versión de `pubspec.yaml` (ej. `1.15.2+2-remix+2`), restaurando la compatibilidad estricta con SemVer.
* Limpieza completa de la caché de CMake (`flutter clean`) para solucionar fallos de compilación cruzada causados por el cambio de rutas del espacio de trabajo.

---

## 🛠️ Mejoras Acumuladas (Frente al ANX Reader Base)

* **TTS Personalizable**: Selector interactivo de color y opacidad del marcador de texto por voz.
* **Soporte MDict (.mdx)**: Lector nativo integrado sin necesidad de conversores externos, con base de datos SQLite sincronizada.
* **Búsqueda con Desconjugación (Stemming)**: Lógica inteligente para buscar la raíz léxica de las palabras cuando no hay coincidencia exacta.
* **Wiktionary Fallback**: Consulta web directa adaptada al idioma actual del libro si no existen definiciones offline.
* **Single-click Context Menu**: Solución al fallo en el puente JS-Dart que impedía desplegar el menú de selección en pantallas táctiles y escritorios Linux al tocar una sola palabra.
