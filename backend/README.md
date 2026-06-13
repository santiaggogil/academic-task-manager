# Backend — Quick Start

Breve guía para levantar y trabajar con el backend (FastAPI + SQLAlchemy + PostgreSQL).

## Requisitos
- Python 3.10+
- Docker & Docker Compose (opcional pero recomendado)
- `pip` / entorno virtual

## Variables de entorno
Cree un archivo `.env` en `backend/` (o exporte las variables):

```env
DATABASE_URL=postgresql://postgres:1234@db:5432/academic_tasks_db
SECRET_KEY=change_this_secret
ACCESS_TOKEN_EXPIRE_MINUTES=60
ENV=development
```

Guarde secretos en un secret manager para producción.

## Levantar con Docker (recomendado)
Desde la raíz del repo:

```bash
docker-compose up --build
```

Esto levantará la base de datos y la API. La app quedará expuesta por defecto en `http://localhost:8000`.

## Levantar local sin Docker
En Windows (PowerShell):

```powershell
cd backend
python -m venv .venv
.\.venv\Scripts\activate
pip install -r requirements.txt
# configurar .env
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

## Migraciones (Alembic)
Si usa Alembic (recomendado):

```bash
cd backend
pip install alembic
alembic revision --autogenerate -m "init"
alembic upgrade head
```

## Seeds (datos iniciales)
Crear/ejecutar `backend/scripts/seed.py` o `backend/sql/seed.sql` para insertar `subjects`, `categories`, `priorities`, `task_statuses` y un usuario admin de prueba.

Ejemplo (Python):

```bash
python backend/scripts/seed.py
```

## Ejecutar tests

```bash
cd backend
pip install -r requirements.txt
pytest -q
```

## Lint

Configurar y ejecutar `ruff` o `flake8` según convenga:

```bash
ruff check .
```

## Comandos útiles
- Ejecutar servidor: `uvicorn app.main:app --reload --port 8000`
- Aplicar migraciones: `alembic upgrade head`
- Crear migración: `alembic revision --autogenerate -m "msg"`

## Troubleshooting rápido
- DB connection error: verificar `DATABASE_URL`, que el container de Postgres esté corriendo y migraciones aplicadas.
- Token expired: loguear de nuevo; revisar `ACCESS_TOKEN_EXPIRE_MINUTES`.
- 422 validation: revisar payload contra los Pydantic schemas en `app/schemas/`.

