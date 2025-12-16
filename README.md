# infra-local
Repositorio de infraestructura local que permite levantar los microservicios y sus bases de datos mediante Docker Compose. Incluye la configuración necesaria para inicializar las bases de datos y facilitar el entorno de desarrollo sin pasos manuales adicionales

# Account y Customer Services

Este proyecto fue desarrollado como parte de una **prueba técnica para DEVSU**, con el objetivo de analizar el alcance técnico, la forma de estructurar una solución y el criterio aplicado durante el desarrollo backend.

La intención no fue construir algo excesivamente complejo, sino una solución clara, entendible y fácil de mantener, similar a lo que se haría en un entorno real de trabajo.  
Se priorizó la organización del codigo, la separación de responsabilidades y el manejo correcto de errores de negocio, incluso por encima de optimizaciones prematuras.

El proyecto puede ejecutarse localmente usando Docker, sin configuraciones complicadas ni dependencias externas adicionales.

---

## Arquitectura general

La solución está compuesta por **dos microservicios independientes**, cada uno con una responsabilidad bien definida y su propia base de datos.

No existe acceso directo entre bases de datos y la comunicación se realiza únicamente a través de APIs REST.

---

## customer-service

Este microservicio se encarga de la gestión de clientes.

Responsabilidades principales:
- Creación de clientes
- Persistencia de información personal
- Exposición de endpoints REST

Características:
- Base de datos propia (PostgreSQL)
- Validaciones básicas de negocio
- Manejo de errores mediante excepciones de dominio

Puerto por defecto:
```
8080
```

---

## account-service

Este microservicio maneja la lógica relacionada con cuentas y movimientos.

Responsabilidades principales:
- Creación de cuentas
- Registro de movimientos (depósitos y retiros)
- Validación de saldo disponible
- Reporte de movimientos por rango de fechas
- Manejo de errores de negocio (saldo insuficiente, cuenta no válida, etc)

Características:
- Base de datos propia (PostgreSQL)
- Lógica de negocio centralizada en el service
- Uso de BusinessException y GlobalExceptionHandler

Puerto por defecto:
```
8081
```

---

## Tecnologías utilizadas

- Java 17  
- Spring Boot 3.x  
- Spring Data JPA  
- PostgreSQL 15  
- Maven  
- Docker / Docker Compose  

---

## Estructura del proyecto

```

├── account-service/
│   ├── Dockerfile
│   ├── pom.xml
│   └── src/
│
├── customer-service/
│   ├── Dockerfile
│   ├── pom.xml
│   └── src/
│
└── infra-local/
    ├── README.md
    ├── docker-compose.yml
    ├── postman_collection.json
    └── db/
        ├── init.sql
        ├── account-schema.sql
        └── customer-schema.sql

---

## Cómo ejecutar el proyecto

### Requisitos previos

- Java 17
- Maven
- Docker Desktop (con Docker Compose habilitado)

---

### 1. Compilar los microservicios

Desde cada microservicio ejecutar:

```
mvn clean package -DskipTests
```

Esto genera el JAR ejecutable en la carpeta target.

---

### 2. Levantar el entorno completo

Desde la carpeta raíz del proyecto:

```
docker compose up --build
```

Esto levantará:
- customer-db
- account-db
- customer-service
- account-service

---

### 3. Detener el entorno

```
docker compose down
```

---

## Endpoints principales

### customer-service (8080)

Crear cliente

```
POST /clientes
```

Ejemplo de request:

```
{
  "customerId": "C001",
  "password": "1234",
  "name": "Jair Castillo",
  "gender": "M",
  "age": 35,
  "address": "Calle Fake 123",
  "phone": "3204584846"
}
```

---

### account-service (8081)

Crear cuenta

```
POST /cuentas
```

Registrar movimiento

```
POST /movimientos
```

Ejemplo depósito:

```
{
  "accountNumber": "ACC001",
  "amount": 5000
}
```

Ejemplo retiro:

```
{
  "accountNumber": "ACC001",
  "amount": -2000
}
```

Si el saldo no es suficiente, el servicio responde con **409 Conflict** y un mensaje de error de negocio.

---

### Reporte de movimientos

```
GET /reporte
```

Parámetros:
- accountNumber
- from (fecha inicial)
- to (fecha final)

Ejemplo:

```
GET /reporte?accountNumber=ACC001&from=2025-01-01T00:00:00&to=2025-12-31T23:59:59
```

Ejemplo de respuesta:

```
[
  {
    "date": "2025-12-15T09:10:12",
    "movementType": "DEPOSIT",
    "amount": 5000,
    "balance": 5000
  },
  {
    "date": "2025-12-15T09:12:45",
    "movementType": "WITHDRAW",
    "amount": -2000,
    "balance": 3000
  }
]
```

---

## Manejo de errores

Los errores de negocio se manejan mediante una excepción propia (BusinessException) y un GlobalExceptionHandler que traduce estas excepciones a respuestas HTTP adecuadas.

La lógica de negocio no se encuentra en los controllers y no se usan try/catch innecesarios.

---

Este proyecto fue desarrollado únicamente con fines de evaluación técnica.

---

## Autor

Creado por **JAIR CASTILLO**  
Backend Java Developer
Cel 3204584846
Experiencia en Java, Spring Boot, microservicios y arquitectura backend.

