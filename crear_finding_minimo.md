# 🐛 Crear un Finding en DefectDojo (flujo mínimo)

Este documento resume los **pasos mínimos necesarios** para crear un *finding* (hallazgo) usando la API de DefectDojo.

---

## 🧱 1. Crear un Producto

```bash
curl -X POST http://<IP>:8080/api/v2/products/ \
  -H "Authorization: Token <TOKEN>" \
  -H "Content-Type: application/json" \
  -d '{"name": "Mi Producto", "description": "Test product", "prod_type": 1}'
```

---

## 🔁 2. Crear un Engagement

```bash
curl -X POST http://<IP>:8080/api/v2/engagements/ \
  -H "Authorization: Token <TOKEN>" \
  -H "Content-Type: application/json" \
  -d '{
    "product": 1,
    "name": "Engagement de prueba",
    "target_start": "2025-04-23",
    "target_end": "2025-04-30",
    "status": "In Progress"
  }'
```

---

## 🧪 3. Crear un Test

```bash
curl -X POST http://<IP>:8080/api/v2/tests/ \
  -H "Authorization: Token <TOKEN>" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Test de Pen Test",
    "engagement": 1,
    "test_type": 3,
    "target_start": "2025-04-23",
    "target_end": "2025-04-23"
  }'
```

---

## 🐛 4. Crear un Finding

```bash
curl -X POST http://<IP>:8080/api/v2/findings/ \
  -H "Authorization: Token <TOKEN>" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Inyección SQL",
    "description": "Vulnerabilidad detectada en login.",
    "severity": "High",
    "numerical_severity": "S1",
    "test": 1,
    "found_by": [3],
    "active": true,
    "verified": true
  }'
```

---

## 📌 Dependencias

```plaintext
Product ➝ Engagement ➝ Test ➝ Finding
```
