# 🎓 Academic Task Manager - Frontend Technical Documentation

Este es el cliente móvil oficial del sistema **Academic Task Manager**, una solución integral desarrollada con **Flutter** para optimizar la organización, el seguimiento y la productividad académica de los estudiantes. La aplicación implementa una arquitectura limpia, reactiva y modular, garantizando escalabilidad y mantenibilidad a largo plazo.

---

## 🚀 1. Stack Tecnológico Detallado

La elección de tecnologías responde a la necesidad de crear una aplicación mantenible, rápida y con una excelente experiencia de usuario (UX):

*   **Framework:** [Flutter SDK ^3.11.5](https://flutter.dev/) - Renderizado de alto rendimiento (60-120 FPS) y consistencia visual multiplataforma mediante un único codebase.
*   **Gestión de Estado:** [Provider v6.1.2](https://pub.dev/packages/provider) - Implementación del patrón **Observer/ChangeNotifier**. Facilita la inyección de dependencias y asegura que la UI se reconstruya de forma eficiente ante cambios en los datos, separando la lógica de negocio de la presentación.
*   **Navegación:** [GoRouter v14.2.7](https://pub.dev/packages/go_router) - Sistema de enrutamiento declarativo. Permite una gestión centralizada de la pila de navegación, soporte para parámetros dinámicos y "guardas de navegación" (redirecciones lógicas) para proteger rutas privadas y gestionar el flujo de autenticación de forma centralizada.
*   **Comunicación HTTP:** [Dio v5.7.0](https://pub.dev/packages/dio) - Cliente potente que supera al paquete estándar `http` gracias a su soporte nativo para interceptores globales, configuración centralizada de `baseUrl` y manejo avanzado de errores mediante `DioException`.
*   **Persistencia Local:** [SharedPreferences v2.3.2](https://pub.dev/packages/shared_preferences) - Almacenamiento clave-valor utilizado para persistir el JWT (JSON Web Token), garantizando sesiones persistentes entre reinicios de la aplicación.
*   **Diseño:** Material Design 3 con un sistema de temas personalizado que adapta la identidad visual académica.

---

## 🏗️ 2. Arquitectura de Software (Layered Architecture)

El proyecto sigue una estructura de capas desacopladas, lo que garantiza que cada componente tenga una única responsabilidad (**Principios SOLID**).

### 📁 Capa de Núcleo (`lib/core/`)
*   **`theme/`**: Centraliza la identidad visual. Define paletas cromáticas (`AppColors`), tipografías (`AppTextStyles`) y la configuración global del `AppTheme`. Esto permite cambios visuales instantáneos en toda la app.
*   **`constants/`**: Gestión de configuraciones globales como `ApiConstants.baseUrl`, diseñada para adaptarse dinámicamente según el entorno (Android Emulator, iOS o Dispositivo físico).

### 📁 Capa de Modelos (`lib/models/`)
*   Contiene clases de datos (POJOs) como `TaskModel`. Incluyen constructores de fábrica para la serialización JSON (`fromJson`/`toJson`), asegurando que los datos de la API se transformen en objetos Dart fuertemente tipados y seguros.

### 📁 Capa de Lógica de Negocio (`lib/providers/`)
*   **`AuthProvider`**: Gestiona el estado de autenticación, el flujo de login/registro y la persistencia segura del token JWT en el dispositivo.
*   **`TaskProvider`**: Centraliza la lógica de las tareas: carga inicial, filtrado dinámico por estado, búsqueda por texto y sincronización de cambios (CRUD) con el backend mediante notificaciones de cambio a la UI.
*   **`DashboardProvider`**: Maneja las métricas y el resumen de actividad académica del usuario (tareas pendientes, completadas, etc.).

### 📁 Capa de Infraestructura/Servicios (`lib/services/`)
*   **Networking:** Servicios atómicos (`AuthService`, `TaskService`) encargados exclusivamente de la comunicación HTTP cruda.
*   **Auditoría Técnica:** Incluye bloques de trazabilidad en consola (modo debug) para rastrear URLs, payloads enviados (Body), cabeceras de autorización y códigos de respuesta del servidor (200, 401, 500) para un diagnóstico rápido.

### 📁 Capa de Presentación (`lib/screens/` & `lib/widgets/`)
*   **Screens:** Widgets de alto nivel que representan páginas completas y orquestan la navegación e interacción con Providers.
*   **Widgets:** Componentes granulares reutilizables (ej. `TaskCard`, `CustomButton`) diseñados para mantener el código DRY (**Don't Repeat Yourself**) y coherencia visual.

---

## 📁 3. Estructura de Directorios Detallada

```text
lib/
├── core/               # Configuraciones globales (Temas, Constantes)
│   ├── constants/      # URLs y configuraciones de API
│   └── theme/          # Sistema de diseño Material 3
├── models/             # Entidades de datos (Clases Dart)
├── providers/          # Lógica de estado y negocio (ChangeNotifiers)
├── routes/             # Configuración de rutas (GoRouter)
├── screens/            # Pantallas de la UI organizadas por módulos
│   ├── auth/           # Login, Registro, Splash
│   ├── home/           # Dashboard principal
│   ├── main/           # Estructura de navegación principal
│   ├── profile/        # Gestión de cuenta de usuario
│   └── tasks/          # Gestión de tareas (Listado, CRUD)
├── services/           # Peticiones HTTP y servicios externos
└── widgets/            # Componentes UI compartidos y atómicos
```

---

## 🛠️ 4. Flujos Críticos de Implementación

### 🔐 Seguridad y Autenticación (JWT Flow)
La seguridad se basa en el estándar **JSON Web Token**:
1.  **Handshake:** Tras un login exitoso, el servidor devuelve un `access_token`.
2.  **Persistencia:** El token se guarda en `SharedPreferences`.
3.  **Autorización:** Los servicios recuperan automáticamente el token e inyecta la cabecera `Authorization: Bearer <token>` en cada petición HTTP protegida.
4.  **Auto-login:** Al arrancar, la `SplashScreen` verifica la validez del token local para decidir si redirigir al Dashboard o al Login sin intervención del usuario.

### 📝 Gestión Dinámica de Tareas (Reactividad)
*   **Change Detection:** El `TaskProvider` utiliza `notifyListeners()` para actualizar la UI instantáneamente cuando se crea, edita o elimina una tarea.
*   **Búsqueda e Integridad:** Implementa lógica de filtrado local y validación de formularios mediante `GlobalKey<FormState>` y expresiones regulares para asegurar que los datos enviados al backend sean íntegros (ej. formato de fecha `YYYY-MM-DD`).
*   **Manejo de Errores:** Se capturan excepciones de red (`DioException`) para mostrar mensajes amigables mediante `SnackBar` y logs técnicos en consola para diagnóstico rápido de errores 500 o 401.

---

## 🌐 5. Configuración de Conectividad (Networking)

Configuración centralizada en `lib/core/constants/api_constants.dart`. Es vital ajustar el host según el entorno de prueba:

| Entorno | Dirección Host | Razón Técnico-Práctica |
| :--- | :--- | :--- |
| **Android AVD** | `http://10.0.2.2:8000/api` | Alias especial para acceder al localhost de la máquina host. |
| **iOS Simulator** | `http://localhost:8000/api` | Acceso directo al loopback del sistema operativo. |
| **Dispositivo Físico** | `http://<TU_IP_LOCAL>:8000/api` | Requiere que ambos dispositivos estén en la misma red Wi-Fi y firewall abierto. |

---

## 🎨 6. Sistema de Diseño (UI/UX)

*   **Material 3:** Implementación completa con soporte para superficies elevadas, colores dinámicos y tipografías optimizadas.
*   **Feedback:** Uso intensivo de indicadores visuales como `CircularProgressIndicator` para estados asíncronos y `SnackBar` para notificaciones de éxito/error técnico.
*   **Navegación:** Uso de `BottomNavigationBar` para acceso rápido y flujos de retroceso coherentes con flechas de navegación personalizadas en flujos secundarios para una experiencia intuitiva.

---

## 🧪 7. Calidad, Testing y Debugging

*   **Widget Testing:** Pruebas integradas en `test/widget_test.dart` para asegurar que la jerarquía de widgets se renderice correctamente bajo condiciones normales de inyección de Providers.
*   **Audit Logs:** Sistema de trazabilidad en consola que permite diagnosticar errores mediante la inspección de cabeceras y bodies JSON en tiempo real durante el desarrollo.

---

## ⚙️ 8. Instalación y Ejecución

1.  **Prerrequisitos:** Flutter SDK instalado y configurado (`flutter doctor`).
2.  **Instalar dependencias:**
    ```bash
    flutter pub get
    ```
3.  **Modo Desarrollador:** En Windows, es necesario activar el Modo Desarrollador en los ajustes del sistema para permitir la gestión de symlinks de plugins.
4.  **Configurar IP:** Ajusta el host en `api_constants.dart` según tu entorno de desarrollo.
5.  **Ejecutar:**
    ```bash
    flutter run
    ```

---

## 📈 9. Roadmap de Evolución
*   [ ] **Seguridad Avanzada:** Migración de `SharedPreferences` a `flutter_secure_storage` para el cifrado del JWT en el dispositivo.
*   [ ] **Modo Offline:** Implementación de caché local con `SQFlite` para permitir el uso de la aplicación sin conexión a internet.
*   [ ] **Notificaciones Push:** Alertas para recordatorios de fechas de entrega próximas.
*   [ ] **Dashboards Analíticos:** Pantalla de estadísticas de productividad académica y cumplimiento de metas.
