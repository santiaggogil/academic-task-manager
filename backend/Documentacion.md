
---

## 1. Resumen ejecutivo

- Framework: FastAPI
- ORM: SQLAlchemy (`declarative_base` + `sessionmaker`)
- Autenticación: JWT (HS256) con `python-jose`
- Hash de contraseñas: `passlib` (bcrypt)
- Motor: PostgreSQL (configurable vía `DATABASE_URL`)
- Entrypoint: `uvicorn app.main:app`

Objetivo: esta guía reúne la documentación operativa y técnica del backend, cubriendo endpoints, contratos (Pydantic schemas), autenticación, base de datos, despliegue, tests y mantenimiento.

---

## 2. Estructura del proyecto

- `app/`
  - `routes/`: controladores y definición de endpoints (`auth_routes.py`, `task_routes.py`).
  - `services/`: lógica de negocio y validaciones (`auth_service.py`, `task_service.py`).
  - `models/`: modelos SQLAlchemy.
  - `schemas/`: Pydantic schemas (requests/responses).
  - `auth/`: hashing y JWT (`password_handler.py`, `jwt_handler.py`, `dependencies.py`).
- `database.py`: engine, `SessionLocal`, `Base`.
- `requirements.txt`: dependencias.
- `Dockerfile`, `docker-compose.yml` para entornos con contenedores.

---

## 3. Contratos (Pydantic schemas) y validaciones

Resumen de schemas principales (archivos en `app/schemas`):
- `auth_schema.py`: `LoginRequest`, `TokenResponse`.
- `user_schema.py`: `UserCreate`, `UserResponse`.
- `task_schema.py`: `TaskCreate`, `TaskUpdate`, `TaskResponse`.
- `category_schema.py`, `priority_schema.py`, `subject_schema.py`, `task_status_schema.py`, `task_history_schema.py`.

Validaciones clave:
- `title`: string, min_length=3, max_length=100
- `description`: string, min_length=3, max_length=500
- `email`: `EmailStr`
- `due_date`: ISO 8601 datetime
- Campos opcionales/obligatorios definidos en cada schema

Incluye en la documentación de cada endpoint el nombre exacto del schema usado tanto para request como para response.

---

## 4. Endpoints (documentación unificada)

Formato por endpoint: método, URL, headers, permisos, parámetros (path/query/body), request schema, response schema, códigos HTTP, ejemplos cURL y JSON (éxito / error).

1) Auth — Registro
- Método: POST
- URL: `/api/register`
- Headers: `Content-Type: application/json`
- Body: `UserCreate` ({name, email, password})
- Responses:
  - 201 Created: `UserResponse` ({id, name, email})
  - 400 Bad Request: `{"detail": "Email already registered"}`
  - 422 Unprocessable Entity: validaciones Pydantic
- Ejemplo request JSON:

```json
{
  "name": "Juan Pérez",
  "email": "juan@example.com",
  "password": "s3cretP@ss"
}
```

Ejemplo cURL:

```bash
curl -X POST http://localhost:8000/api/register \
  -H "Content-Type: application/json" \
  -d '{"name":"Juan Pérez","email":"juan@example.com","password":"s3cretP@ss"}'
```

2) Auth — Login
- Método: POST
- URL: `/api/login`
- Body: `LoginRequest` ({email, password})
- Responses:
  - 200 OK: `TokenResponse` ({"access_token": "...", "token_type": "bearer"})
  - 401 Unauthorized: `{"detail":"Invalid credentials"}`
- Ejemplo request JSON:

```json
{
  "email": "juan@example.com",
  "password": "s3cretP@ss"
}
```

Ejemplo cURL:

```bash
curl -X POST http://localhost:8000/api/login \
  -H "Content-Type: application/json" \
  -d '{"email":"juan@example.com","password":"s3cretP@ss"}'
```

3) Tasks — Crear tarea
- Método: POST
- URL: `/api/tasks`
- Headers: `Authorization: Bearer <token>`
- Body: `TaskCreate` ({title, description, due_date, subject_id, category_id, priority_id, status_id})
- Responses:
  - 201 Created: `TaskResponse`
  - 400 Bad Request: validación o FK inexistente
  - 401 Unauthorized: token inválido/ausente

Ejemplo request JSON:

```json
{
  "title": "Estudiar para el parcial",
  "description": "Repasar capítulos 1 a 4",
  "due_date": "2026-06-20T23:59:00",
  "subject_id": 1,
  "category_id": 2,
  "priority_id": 1,
  "status_id": 1
}
```

4) Tasks — Listar tareas
- Método: GET
- URL: `/api/tasks`
- Query params: `search` (string), `status` (id), `page` (int), `page_size` (int)
- Headers: `Authorization: Bearer <token>`
- Responses:
  - 200 OK: lista paginada de `TaskResponse`

5) Tasks — Obtener / Actualizar / Eliminar
- GET `/api/tasks/{task_id}` → 200/404/401
- PUT `/api/tasks/{task_id}` → 200/400/401/403 (verificar `Task.user_id == current_user.id`)
- DELETE `/api/tasks/{task_id}` → 200/404/401/403

6) Tasks — Estadísticas
- GET `/api/tasks/stats` → 200 OK con resumen por usuario (counts, overdue, next due)

Nota: Documentar para cada endpoint los posibles códigos de error y el formato de error devuelto.

---

## 5. Manejo de errores (estándar)

Se recomienda un formato homogéneo para errores JSON:

```json
{
  "detail": "Mensaje legible",
  "code": "ERROR_CODE",
  "errors": { "field": "mensaje" }
}
```

Ejemplos de códigos HTTP:
- 400 Bad Request: payload inválido, FK inexistente.
- 401 Unauthorized: token inválido o ausente.
- 403 Forbidden: acceso a recurso de otro usuario.
- 404 Not Found: recurso no encontrado.
- 422 Unprocessable Entity: validación Pydantic.
- 500 Internal Server Error: error inesperado (loguear stacktrace internamente).

---

## 6. Autenticación y seguridad

- Flow: registro → login → obtener `access_token` (Bearer) → usar en `Authorization` header.
- JWT:
  - Algoritmo: HS256
  - Claims mínimos: `user_id`, `exp` (expiración)
  - `SECRET_KEY` y parámetros en variables de entorno
- Hash de contraseñas: `passlib` / bcrypt (ver `app/auth/password_handler.py`).
- Buenas prácticas:
  - No loguear contraseñas ni tokens.
  - Guardar secrets en variables de entorno o secret manager.
  - Implementar rate-limiting en endpoints de autenticación.
  - Manejar token expirado con mensajes claros y posibilidad de refresh si se implementa.

---

## 7. Modelos y base de datos

Resumen de tablas y relaciones (ver `app/models`):

- `users`
  - id (PK), name, email (UNIQUE), password
- `tasks`
  - id (PK), title, description, due_date, user_id (FK → users.id), subject_id, category_id, priority_id, status_id
- `subjects`, `categories`, `priorities`, `task_statuses`
  - id (PK), name
- `task_history`
  - id (PK), action, created_at, task_id (FK → tasks.id)

Índices recomendados: `tasks(user_id)`, `tasks(due_date)`, índices para columnas usadas en filtros/joins.

Configuración de conexión: `DATABASE_URL` en `app/database.py`

---

## 8. Migraciones y seeds

Recomendación: usar Alembic.

Ejemplo flujo mínimo:

```bash
pip install alembic
alembic init alembic
alembic revision --autogenerate -m "init"
alembic upgrade head
```

Seeds: incluir un script `backend/scripts/seed.py` o `sql/seed.sql` para insertar datos iniciales (subjects, categories, priorities, statuses, usuario admin de prueba).

---

## 9. Setup y ejecución local

Variables de entorno mínimas:
- `DATABASE_URL`
- `SECRET_KEY`
- `ACCESS_TOKEN_EXPIRE_MINUTES`
- `ENV` (development/production)

Con Docker (desde la raíz del repo):

```bash
docker-compose up --build
```

Sin Docker (Windows):

```powershell
python -m venv .venv
.\.venv\Scripts\activate
pip install -r backend/requirements.txt
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

---

## 10. Tests

- Ubicación sugerida: `backend/tests/` (unit + integration).
- Comando propuesto:

```bash
pip install -r backend/requirements.txt
pytest -q
```

Testing DB: usar sqlite in-memory o una instancia postgres dedicada; utilizar fixtures para datos y aislar transacciones.

---

## 11. Observabilidad y logging

- Configurar `logging` por entornos (DEBUG en dev, INFO/WARN en prod).
- Considerar integración con Sentry para errores y exponer métricas (Prometheus) si aplica.

---

## 12. CI/CD y calidad

- Pipeline recomendado:
  1. Lint (ruff/flake8)
  2. Tests
  3. Build image (Docker)
  4. Deploy (staging → production)

Proveer archivo ejemplo `.github/workflows/ci.yml` que ejecute los pasos anteriores.

---

## 13. Versionado de API y changelog

- Recomendar versionado en la ruta: `/api/v1/...`.
- Mantener `CHANGELOG.md` con breaking changes y notas de release.

---

## 14. Operaciones y mantenimiento

- Backups: `pg_dump` para exportar y `pg_restore` para restaurar.
- Monitorización de estado de la DB y uso de índices.

Comandos de ejemplo:

```bash
# Backup
pg_dump $DATABASE_URL -Fc -f backup.dump

# Restore
pg_restore -d $DATABASE_URL backup.dump
```

---

## 15. Diagramas, artefactos y ownership

- carpeta `backend/docs/erd/` con los diagramas ER y diagramas de flujo de autenticación.
---

## 16. FAQ y troubleshooting (rápido)

- DB connection error: verificar `DATABASE_URL`, que la base de datos esté accesible y migraciones aplicadas.
- Token expired: login de nuevo o implementar refresh tokens.
- 500 errors after deploy: revisar logs, stacktrace y variables de entorno en producción.

---
