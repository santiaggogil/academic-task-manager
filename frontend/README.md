# Academic Task Manager - Frontend (Quick Start)

Breve guía para ejecutar rápidamente el cliente móvil Flutter del proyecto Academic Task Manager.

## Requisitos
- Flutter SDK (recomendado >= 3.11)
- Android Studio / Xcode (para emuladores y builds nativos)
- Un backend en ejecución (ver "Configurar conexión al backend")

## Instalación rápida
1. Abre una terminal y sitúate en la carpeta del frontend:

```bash
cd frontend
```

2. Instala las dependencias:

```bash
flutter pub get
```

## Configurar conexión al backend
Edita el archivo de constantes de API en `lib/core/constants/api_constants.dart` y ajusta `baseUrl` según tu entorno:

- Android Emulator (AVD): `http://10.0.2.2:8000/api`
- iOS Simulator: `http://localhost:8000/api`
- Dispositivo físico: `http://<TU_IP_LOCAL>:8000/api` (asegúrate que backend y dispositivo estén en la misma red)

Nota técnica: para acceder desde un emulador Android al backend corriendo en la máquina host, usa `10.0.2.2`.

## Ejecutar en modo desarrollo

- Ejecutar en el emulador o dispositivo conectado (elige el dispositivo con `flutter devices`):

```bash
flutter run
```

- Ejecutar en Chrome (web):

```bash
flutter run -d chrome
```

## Builds

- APK para Android:

```bash
flutter build apk --release
```

- IPA para iOS (requiere macOS):

```bash
flutter build ios --release
```

## Persistencia y autenticación
El proyecto utiliza `SharedPreferences` para persistir el token JWT localmente. Si necesitas mayor seguridad, considera migrar a `flutter_secure_storage`.

## Depuración y logs
- El cliente usa `Dio` para llamadas HTTP; revisa los interceptores y logs en `lib/services/` para ver URLs, headers y payloads en modo debug.
- Mensajes y errores se muestran mediante `SnackBar` y logs en consola.

## Problemas comunes
- No se conecta al backend desde Android Emulator: verifica que `baseUrl` use `http://10.0.2.2:8000/api`.
- Token inválido / 401: elimina el token de `SharedPreferences` y vuelve a iniciar sesión.
- Error en iOS build: necesitas una máquina macOS con Xcode instalado.

## Siguientes pasos recomendados
- Ejecutar el backend localmente (ver carpeta `backend/`) antes de abrir la app.
- Ajustar `api_constants.dart` según entorno de pruebas.

