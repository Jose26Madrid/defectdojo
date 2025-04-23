# 🛡️ Guía de Uso de DefectDojo con Docker + API

## 🐳 1. Instalación con Docker Compose

```bash
# Clonar el repositorio
git clone https://github.com/DefectDojo/django-DefectDojo.git
cd django-DefectDojo

# Instalar herramientas básicas si no las tenés
sudo yum install -y docker git curl

# Instalar plugin docker-compose (manual)
mkdir -p ~/.docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.24.2/docker-compose-linux-x86_64 \
  -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose

# Levantar los contenedores
sudo docker compose up -d
```

## 👤 2. Crear usuario admin manualmente (si el por defecto no funciona)

```bash
# Ingresar al contenedor Django
sudo docker exec -it django-defectdojo-uwsgi-1 bash

# Crear superusuario
python3 manage.py createsuperuser

# Te pedirá:
# - username
# - email
# - password (mínimo 12 caracteres)

```
## 🔐 3. Obtener token de autenticación vía API
```bash
curl -X POST http://<IP>:8080/api/v2/api-token-auth/ \
  -H "Content-Type: application/json" \
  -d '{"username": "TU_USUARIO", "password": "TU_PASSWORD"}'

```
## 📦 4. Crear entidades con la API

```bash
① Producto
curl -X POST http://<IP>:8080/api/v2/products/ \
  -H "Authorization: Token <TOKEN>" \
  -H "Content-Type: application/json" \
  -d '{"name": "Mi Producto", "description": "Descripción", "prod_type": 1}'
② Engagement
curl -X POST http://<IP>:8080/api/v2/engagements/ \
  -H "Authorization: Token <TOKEN>" \
  -H "Content-Type: application/json" \
  -d '{"product": 1, "name": "Engagement de prueba", "target_start": "2025-04-23", "target_end": "2025-04-30", "status": "In Progress"}'
③ Test
curl -X POST http://<IP>:8080/api/v2/tests/ \
  -H "Authorization: Token <TOKEN>" \
  -H "Content-Type: application/json" \
  -d '{"title": "Test sin environment", "engagement": 1, "test_type": 3, "target_start": "2025-04-23", "target_end": "2025-04-23"}'
④ Finding
curl -X POST http://<IP>:8080/api/v2/findings/ \
  -H "Authorization: Token <TOKEN>" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Inyección SQL en Login",
    "severity": "High",
    "numerical_severity": 2,
    "description": "Se detectó inyección SQL.",
    "test": 1,
    "active": true,
    "verified": true,
    "found_by": [3]
}'

```
## 📋 5. Endpoints útiles
```bash
# Listar productos
GET /api/v2/products/

# Listar engagements
GET /api/v2/engagements/

# Listar tests
GET /api/v2/tests/

# Listar findings
GET /api/v2/findings/

# Listar tipos de tests
GET /api/v2/test_types/

```
