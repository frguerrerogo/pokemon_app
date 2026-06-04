# 🔴 Pokédex App - Flutter

**Pokédex App** es una aplicación móvil desarrollada en Flutter que permite a los usuarios explorar y descubrir información detallada sobre Pokémon. La aplicación ofrece una experiencia de usuario fluida e intuitiva, con un diseño responsivo y funcionalidades interactivas.

La aplicación está diseñada para proporcionar una experiencia visual atractiva, con una interfaz intuitiva, navegación fluida con GetX y gestión eficiente del estado. Entre sus funcionalidades principales se incluyen autenticación con Firebase, visualización de Pokémon, búsqueda y filtrado, caché local con Hive, y detección inteligente de conectividad.

La aplicación utiliza la **PokéAPI** pública para obtener información actualizada sobre Pokémon, con almacenamiento en caché mediante Hive para acceso offline y gestión de estado reactiva con GetX.

## 🎥 Demo en video

Puedes ver una demostración completa de la aplicación haciendo clic en el siguiente enlace:

👉 [Ver demo de PokeApp](https://drive.google.com/file/d/192v7XYo9j0ZXEbAE2mBSjUdqqAW4RFno/view?usp=sharing)

---

## 🚀 Características Principales

- ✅ **Autenticación Firebase**: Login y registro seguro con Firebase Auth
- 📋 **Listado de Pokémon**: Exploración completa de Pokémon desde la PokéAPI
- 📊 **Detalle de Pokémon**: Información completa con estadísticas, tipos y habilidades
- 💾 **Almacenamiento Local**: Caché con Hive para datos offline
- 🌍 **Internacionalización (i18n)**: Soporte multiidioma (Español e Inglés)
- ⚡ **Conexión Inteligente**: Detección de conectividad con connectivity_plus
- 📱 **UI Responsiva**: Diseño responsivo y experiencia fluida
- 🎨 **Temas Dinámicos**: Soporte para tema claro y oscuro

---

## 🛠️ Requisitos Previos

- **Flutter**  3.44.0+ ([Instalar](https://flutter.dev/docs/get-started/install))
- **Dart** 3.12.0+
- **Git**
- **Android Studio/SDK** (API 24+) o **Xcode 14.3+** (según plataforma)
- **Configuración de Firebase** (credenciales en `google-services.json` y `GoogleService-Info.plist`)

---

## 📦 Instalación

```bash
# 1. Clonar el repositorio
git clone https://github.com/frguerrerogo/pokemon_app.git
cd pokemon_app

# 2. Instalar dependencias
flutter pub get
# 3. Generar archivos (si modificaste modelos de datos)
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 🚀 Ejecución

```bash
# Ejecutar la aplicación en modo desarrollo
flutter run

# O presionar F5 (si está configurado launch.json)

# Ejecutar en un dispositivo específico
flutter run -d <device-id>
```

---

## 🏗️ Tecnologías Utilizadas

| Tecnología | Propósito |
|-----------|----------|
| **Flutter 3.44.0+** | Framework principal |
| **Dart 3.12.0+** | Lenguaje de programación |
| **GetX** | Gestión de estado y routing |
| **Firebase Core** | Infraestructura Firebase |
| **Firebase Auth** | Autenticación de usuarios |
| **Dio** | Cliente HTTP para APIs |
| **Hive** | Base de datos local NoSQL |
| **Equatable** | Comparación de objetos |
| **Connectivity Plus** | Detección de conectividad |
| **Intl** | Internacionalización (i18n) |
| **Cached Network Image** | Caché de imágenes |
| **Flutter Test** | Testing unitario e integración |

---

## 📁 Estructura del Proyecto

Este proyecto sigue una **arquitectura limpia (Clean Architecture)** con separación en capas y patrones modulares:

```
lib/
├── app/                         # Configuración de la aplicación
│   ├── app.dart                 # Widget principal de la app
│   ├── bindings/                # Bindings de GetX (inyección de dependencias)
│   ├── config/                  # Configuración de Firebase y otros servicios
│   ├── controllers/             # Controllers globales de GetX
│   └── routes/                  # Definición de rutas con GetX
│
├── core/                        # Núcleo compartido
│   ├── constants/               # Constantes globales
│   ├── errors/                  # Manejo de errores y excepciones
│   ├── extensions/              # Extensiones de Dart/Flutter
│   ├── network/                 # Configuración de Dio (HTTP)
│   ├── services/                # Servicios globales (Hive, etc.)
│   ├── shared/                  # Componentes compartidos
│   ├── theme/                   # Temas, colores y estilos
│   ├── widgets/                 # Widgets reutilizables
│   └── core.dart                # Exportaciones del core
│
├── features/                    # Módulos de funcionalidades
│   ├── auth/                    # Feature: Autenticación
│   │   ├── data/                # Repositorio y datasources
│   │   ├── domain/              # Entidades y abstracciones
│   │   └── presentation/        # UI, screens y controllers
│   │
│   └── pokemon/                 # Feature: Gestión de Pokémon
│       ├── data/                # Repositorio y datasources
│       ├── domain/              # Entidades y abstracciones
│       └── presentation/        # UI, screens y controllers
│
├── l10n/                        # Internacionalización
│   ├── app_en.arb               # Traducciones en inglés
│   ├── app_es.arb               # Traducciones en español
│   └── app_localizations.dart
│
├── firebase_options.dart        # Configuración de Firebase
├── main.dart                    # Punto de entrada
└── ...
```

### Patrón por Feature

Cada feature sigue la estructura de Clean Architecture:

- **Presentation**: Screens, widgets y GetX Controllers
- **Domain**: Entidades, casos de uso y abstracciones de repositorio
- **Data**: Implementación de repositorios, datasources (API remoto, almacenamiento local)

---

## 🧪 Testing & Build

```bash
# Tests unitarios
flutter test

# Compilación
flutter build apk                   # Android (debug)
flutter build appbundle             # Android (Play Store)
flutter build ios                   # iOS
flutter build web                   # Web
flutter build windows               # Windows
flutter build macos                 # macOS
flutter build linux                 # Linux
```

---

## 🪝 Git Hooks

Configurar una sola vez:

```bash
git config core.hooksPath githooks
```

**Hooks disponibles:**
- **pre-commit**: Ejecuta `flutter analyze` y `flutter test` automáticamente
- **commit-msg**: Valida formato de commits (feat:, fix:, refactor:, etc.)

Saltarse si es necesario:
```bash
git commit --no-verify
```

---

## 📋 Flujo de Datos

```
                    ┌─────────────┐
                    │  Firebase   │
                    │   Auth      │
                    └──────┬──────┘
                           │
        ┌──────────────────┴──────────────────┐
        │                                     │
    ┌───▼────┐                          ┌────▼──────┐
    │PokéAPI │                          │   Hive    │
    │(Remoto)│                          │ (Local)   │
    └───┬────┘                          └────┬──────┘
        │                                     │
        └──────────────────┬──────────────────┘
                           │
                    ┌──────▼──────┐
                    │ DataSources │
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │ Repository  │
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │GetX Controller
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │   UI/Pages  │
                    └─────────────┘
```

---

## 🔧 Configuración Adicional

### Firebase

1. **Configurar Firebase** (si aún no está hecho):
   ```bash
   flutterfire configure
   ```

2. **Verificar archivos de configuración:**
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`

### Hive

El almacenamiento local con Hive se inicializa automáticamente en `main.dart` mediante `HiveService.init()`.

Adapta las rutas y tipos de cajas según tus necesidades en `core/services/`.

---

## 👤 Autor y Contacto

**Desarrollador**: Fabian Guerrero

Para preguntas, soporte o colaboración:

- **Email**: [frguerrerogo@gmail.com](mailto:frguerrerogo@gmail.com)
- **LinkedIn**: [frguerrerogo](https://www.linkedin.com/in/frguerrerogo/)
- **GitHub**: [frguerrerogo](https://github.com/frguerrerogo)

---

**Última actualización**: Mayo 27 de 2026

