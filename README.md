# Infraestructura y Microservicios – Prueba Técnica Backend

Este proyecto fue desarrollado como parte de una **prueba técnica de arquitectura de microservicios**, con el objetivo de evaluar el diseño de la solución, la estructuración del código y el criterio aplicado durante el desarrollo backend.

La intención no fue construir una solución excesivamente compleja, sino una arquitectura clara, mantenible y alineada a escenarios reales de trabajo, priorizando la separación de responsabilidades, el manejo adecuado de reglas de negocio y la facilidad de despliegue.

La solución puede ejecutarse completamente en local utilizando **Docker**, sin configuraciones manuales adicionales.

---

## Arquitectura general

La solución está compuesta por **dos microservicios independientes**, cada uno con una responsabilidad bien definida y su propia base de datos.

- No existe acceso directo entre bases de datos
- La comunicación se realiza únicamente a través de **APIs REST**
- La infraestructura se desacopla del código mediante Docker Compose

Esta arquitectura permite escalabilidad, mantenibilidad y bajo acoplamiento entre dominios.

---

## customer-service

Microservicio encargado de la gestión de clientes y su información personal.

### Responsabilidades
- Creación y administración de clientes
- Persistencia de información personal
- Exposición de endpoints REST para operaciones CRUD

### Características
- Base de datos propia (PostgreSQL)
- Validaciones básicas de negocio
- Manejo de errores mediante excepciones de dominio

**Puerto por defecto:**
8080

**Repositorio:**
git@github.com:chiguirin/customer-service.git

---

## account-service

Microservicio responsable de la gestión de cuentas y movimientos.

### Responsabilidades
- Creación y administración de cuentas
- Registro de movimientos (depósitos y retiros)
- Validación de saldo disponible
- Generación de reportes por rango de fechas
- Manejo de errores de negocio (saldo insuficiente, cuenta no válida, etc.)

### Características
- Base de datos propia (PostgreSQL)
- Lógica de negocio centralizada en la capa de servicio
- Uso de BusinessException y GlobalExceptionHandler

**Puerto por defecto:**
8081

**Repositorio:**
git@github.com:chiguirin/account-service.git

---

## infra-local

Repositorio de infraestructura local que permite levantar los microservicios y sus bases de datos mediante **Docker Compose**.

Incluye la configuración necesaria para inicializar las bases de datos y facilitar el entorno de desarrollo sin pasos manuales adicionales.

**Repositorio:**
git@github.com:chiguirin/infra-local.git

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

.
├── infra-local/
│   ├── docker-compose.yml
│   ├── postman_collection.json
│   └── db/
│       ├── init.sql
│       ├── account-schema.sql
│       └── customer-schema.sql
│
├── customer-service/
│   ├── Dockerfile
│   ├── pom.xml
│   └── src/
│
└── account-service/
    ├── Dockerfile
    ├── pom.xml
    └── src/

---

## Cómo ejecutar el proyecto

### Requisitos previos
- Java 17
- Maven
- Docker Desktop (con Docker Compose habilitado)

### Compilar los microservicios

Desde cada microservicio ejecutar:
mvn clean package -DskipTests

### Levantar el entorno completo

Desde la carpeta infra-local:
docker compose up --build

### Detener el entorno
docker compose down

---

## OpenAPI / Swagger

- Customer Service: http://localhost:8080/swagger-ui.html
- Account Service: http://localhost:8081/swagger-ui.html

---

## Cumplimiento de la prueba técnica

- F1: CRUD de Cliente, Cuenta y Movimiento
- F2: Registro de movimientos con actualización de saldo
- F3: Validación de saldo no disponible
- F4: Reporte de estado de cuenta por rango de fechas
- F5: Pruebas unitarias de dominio
- F6: Pruebas de integración
- F7: Despliegue en contenedores Docker

---

## Autor

Jair Castillo  
Backend Java Developer
