# PetStore API Karate Tests

Proyecto de pruebas automatizadas para la API PetStore de Swagger utilizando Karate Framework.

## Descripción

Este proyecto implementa pruebas automatizadas de API REST para la PetStore API disponible en https://petstore.swagger.io/

Las pruebas cubren el flujo completo CRUD de usuarios:
1. Crear un usuario
2. Buscar el usuario creado
3. Actualizar el nombre y el correo del usuario
4. Buscar el usuario actualizado
5. Eliminar el usuario

## Requisitos Previos

- Java JDK 17 o superior
- Maven 3.8+ instalado
- Conexión a Internet (para acceder a la API PetStore)

## Estructura del Proyecto

```
karate/
├── README.md                      # Este archivo
├── CONCLUSIONES.md                # Hallazgos y conclusiones
├── pom.xml                        # Configuración Maven
└── src/test/java/
    ├── TestRunner.java            # Runner principal
    ├── karate-config.js           # Configuración global
    ├── users/
    │   ├── users.feature          # Tests principales
    │   └── UsersRunner.java       # Runner específico
    ├── common/user/
    │   ├── create-user.feature    # POST /user
    │   ├── get-user.feature       # GET /user/{username}
    │   ├── update-user.feature    # PUT /user/{username}
    │   └── delete-user.feature    # DELETE /user/{username}
    ├── utils/
    │   ├── generateEmail.js       # Generador de emails
    │   ├── generateUsername.js    # Generador de usernames
    │   ├── loadUserData.js        # Cargador de datos
    │   └── deepCopy.js            # Copia profunda
    ├── data/
    │   └── user-data.json         # Template de datos
    └── schemas/
        └── user-schema.json       # Schema de validación
```

## Instrucciones de Ejecución

### Paso 1: Compilar el Proyecto
```bash
mvn clean compile
```

### Paso 2: Ejecutar Todos los Tests
```bash
mvn clean test
```

### Paso 3: Ejecutar con Entorno Específico
```bash
mvn clean test -Dkarate.env=dev
```

### Paso 4: Ver Reportes
Después de ejecutar los tests, los reportes HTML se generan en:
```
target/karate-reports/karate-summary.html
```

Abrir este archivo en un navegador para ver los resultados detallados.

## Escenarios de Prueba

Los tests implementan los siguientes escenarios:

### Escenario 1: Crear Usuario
- **Endpoint**: POST /user
- **Entrada**: JSON con datos del usuario
- **Salida Esperada**: Código 200, mensaje de confirmación

### Escenario 2: Buscar Usuario
- **Endpoint**: GET /user/{username}
- **Entrada**: Username del usuario creado
- **Salida Esperada**: Datos completos del usuario

### Escenario 3: Actualizar Usuario
- **Endpoint**: PUT /user/{username}
- **Entrada**: JSON con campos actualizados (firstName, email)
- **Salida Esperada**: Código 200, mensaje de confirmación

### Escenario 4: Verificar Actualización
- **Endpoint**: GET /user/{username}
- **Entrada**: Username del usuario
- **Salida Esperada**: Datos actualizados

### Escenario 5: Eliminar Usuario
- **Endpoint**: DELETE /user/{username}
- **Entrada**: Username del usuario
- **Salida Esperada**: Código 200

### Escenario 6: Flujo Completo CRUD
- Ejecuta todo el ciclo: Crear → Buscar → Actualizar → Buscar → Eliminar

## Variables y Datos

### Datos de Entrada (user-data.json)
```json
{
  "id": 1,
  "username": "testuser",
  "firstName": "Test",
  "lastName": "User",
  "email": "test@example.com",
  "password": "password123",
  "phone": "1234567890",
  "userStatus": 1
}
```

### Variables Generadas Dinámicamente
- **username**: Generado con timestamp (user_1234567890)
- **email**: Generado con timestamp (user_1234567890@mail.com)

## Reportes

Los reportes incluyen:
- Resumen de ejecución (karate-summary.html)
- Detalle por escenario (users.users.html)
- Timeline de ejecución (karate-timeline.html)
- Tags y estadísticas (karate-tags.html)

## Contacto

Para más información o soporte, revisar el repositorio en GitHub.
