# Taller 4: Peticiones HTTP y Consumo de API Pública en Flutter
**Institución:** Unidad Central del Valle del Cauca (UCEVA)  
**Estudiante:** Johan Eliu Salgado Castro  
**Repositorio:** [taller_datos_abiertos](https://github.com/Johan-salgado/taller_datos_abiertos)  

---

## 1. Descripción de la API Pública
La aplicación consume datos de la **API Pública de Colombia**, una plataforma de datos abiertos que centraliza información geográfica, histórica, cultural y turística del país:
* **Sitio Web Oficial:** [https://api-colombia.com/](https://api-colombia.com/)
* **Documentación Swagger:** [https://api-colombia.com/swagger/index.html](https://api-colombia.com/swagger/index.html)
* **Base URL:** `https://api-colombia.com/api/v1`

---

## 2. Endpoints Seleccionados
Se implementaron 4 endpoints clave que ofrecen diversidad de datos (textos, cifras, imágenes y ubicaciones):

| # | Endpoint | Método | Descripción |
|---|---|---|---|
| 1 | `/Department` | `GET` | Información territorial: 32 departamentos, capitales, superficie, población y cantidad de municipios. |
| 2 | `/President` | `GET` | Registros históricos: Presidentes de la República, fotografía oficial, período de gobierno, partido y biografía. |
| 3 | `/TouristicAttraction` | `GET` | Atractivos turísticos: Parques nacionales, lugares icónicos, coordenadas (latitud/longitud) y fotografías. |
| 4 | `/TypicalDish` | `GET` | Gastronomía: Platos tradicionales colombianos, ingredientes característicos, fotografía y departamento de origen. |

---

## 3. Ejemplo de Respuestas JSON

<details>
<summary><b>1. /Department (Ejemplo JSON)</b></summary>

```json
{
  "id": 3,
  "name": "Arauca",
  "description": "Arauca es uno de los treinta y dos departamentos...",
  "cityCapitalId": 143,
  "municipalities": 7,
  "surface": 23818,
  "population": 304978,
  "phonePrefix": "7",
  "cityCapital": {
    "id": 143,
    "name": "Arauca"
  }
}
```
</details>

<details>
<summary><b>2. /President (Ejemplo JSON)</b></summary>

```json
{
  "id": 3,
  "image": "https://upload.wikimedia.org/wikipedia/commons/d/db/Rafael_Nunez.JPG",
  "name": "Rafael",
  "lastName": "Núñez Moledo",
  "startPeriodDate": "1887-06-04",
  "endPeriodDate": "1888-08-07",
  "politicalParty": "Partido nacional",
  "description": "Rafael Wenceslao Núñez Moledo..."
}
```
</details>

<details>
<summary><b>3. /TouristicAttraction (Ejemplo JSON)</b></summary>

```json
{
  "id": 36,
  "name": "Hacienda Nápoles",
  "description": "Parque temático y reserva...",
  "images": [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/P%C3%B3rtico_Hacienda_N%C3%A1poles.JPG/800px-P%C3%B3rtico_Hacienda_N%C3%A1poles.JPG"
  ],
  "latitude": "5.887894",
  "longitude": "-74.6418",
  "city": {
    "name": "Puerto Triunfo"
  }
}
```
</details>

<details>
<summary><b>4. /TypicalDish (Ejemplo JSON)</b></summary>

```json
{
  "id": 1,
  "name": "Bandeja Paisa",
  "description": "La bandeja paisa es el orgullo de la cocina paisa...",
  "ingredients": "Frijoles, arroz, carne molida, chicharrón, huevo, plátano maduro, chorizo, arepa, aguacate.",
  "imageUrl": "https://apicolombiastorage.blob.core.windows.net/typicaldishes/1. Bandeja Paisa.jpg",
  "department": {
    "name": "Antioquia"
  }
}
```
</details>

---

## 4. Arquitectura y Estructura del Proyecto
El proyecto sigue estrictamente la arquitectura modular por capas solicitada:

```text
lib/
├── config/                     # Configuración general y variables de entorno
│   └── api_config.dart         # Carga y expone la URL base y endpoints
├── models/                     # Modelos de datos serializables con fromJson y toJson
│   ├── department.dart
│   ├── president.dart
│   ├── tourist_attraction.dart
│   └── typical_dish.dart
├── routes/                     # Configuración centralizada de go_router
│   └── app_router.dart         # Definición de rutas con nombre y paso de objetos
├── services/                   # Lógica de consumo HTTP
│   └── api_service.dart        # Llamadas GET, validación de código 200 y excepciones
├── themes/                     # Estilos y tema global Material 3
│   └── app_theme.dart          # Paleta de colores inspirada en Colombia
├── views/                      # Pantallas principales
│   ├── dashboard_view.dart     # Home con cards de presentación
│   ├── departments_list_view.dart
│   ├── department_detail_view.dart
│   ├── presidents_list_view.dart
│   ├── president_detail_view.dart
│   ├── attractions_list_view.dart
│   ├── attraction_detail_view.dart
│   ├── dishes_list_view.dart
│   └── dish_detail_view.dart
├── widgets/                    # Componentes reutilizables
│   ├── endpoint_card.dart      # Card interactiva del Dashboard
│   ├── error_view.dart         # Widget amigable de error con botón de reintento
│   └── loading_view.dart       # Widget centrado de estado de carga
└── main.dart                   # Punto de entrada, inicialización de dotenv y runApp
```

---

## 5. Paquetes Implementados

| Paquete | Versión | Propósito en el Proyecto |
|---|---|---|
| `http` | `^1.6.0` | Cliente HTTP para consumir los 4 endpoints mediante peticiones `GET`. |
| `go_router` | `^18.1.1` | Navegación declarativa, rutas nombradas y paso de objetos completos en `state.extra`. |
| `flutter_dotenv` | `^6.0.1` | Gestión segura de variables de entorno mediante el archivo `.env` (`API_BASE_URL`). |

---

## 6. Navegación con `go_router` (Rutas y Parámetros)

| Nombre de Ruta (`name`) | Path | Vista Destino | Parámetro Enviado (`extra`) |
|---|---|---|---|
| `home` | `/` | `DashboardView` | Ninguno |
| `departments_list` | `/departments` | `DepartmentsListView` | Ninguno |
| `department_detail` | `/departments/detail` | `DepartmentDetailView` | Objeto `Department` |
| `presidents_list` | `/presidents` | `PresidentsListView` | Ninguno |
| `president_detail` | `/presidents/detail` | `PresidentDetailView` | Objeto `President` |
| `attractions_list` | `/attractions` | `AttractionsListView` | Ninguno |
| `attraction_detail` | `/attractions/detail` | `AttractionDetailView` | Objeto `TouristAttraction` |
| `dishes_list` | `/dishes` | `DishesListView` | Ninguno |
| `dish_detail` | `/dishes/detail` | `DishDetailView` | Objeto `TypicalDish` |

**Ejemplo de navegación implementada:**
```dart
context.pushNamed(
  AppRouter.departmentDetail,
  extra: department,
);
```

---

## 7. Manejo de Estados
La aplicación gestiona los tres estados de UI de manera limpia mediante `FutureBuilder` y `RefreshIndicator`:
1. **Cargando (`LoadingView`):** Indicador de progreso circular con mensaje explicativo contextual.
2. **Éxito (`ListView.builder`):** Renderizado eficiente de la lista de elementos en tarjetas con soporte para *Pull to Refresh*.
3. **Error (`ErrorView`):** Mensaje amigable con icono de alerta y botón de **Reintentar** que vuelve a disparar la petición HTTP.

---

## 8. Flujo de Trabajo GitFlow
El repositorio utiliza el modelo GitFlow establecido:
* `main`: Rama de código estable en producción.
* `dev`: Rama de integración donde convergen las características.
* `feature/taller_api_colombia`: Rama activa donde se implementó el consumo de la API.

### Commits Realizados:
* `feat: inicializar estructura de capas y dependencias (http, go_router, flutter_dotenv)`
* `feat: implementar configuracion dotenv y servicio HTTP para los 4 endpoints`
* `feat: implementar modelos de datos con fromJson y toJson`
* `feat: configurar navegacion declarativa go_router con rutas nombradas`
* `feat: implementar vistas de Dashboard, Listado y Detalle maestro-detalle`
* `docs: documentar endpoints, arquitectura, rutas y flujo git`

---

## 9. Instrucciones para Ejecutar el Proyecto

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/Johan-salgado/taller_datos_abiertos.git
   cd taller_datos_abiertos
   ```

2. Verificar que el archivo `.env` exista en la raíz con:
   ```env
   API_BASE_URL=https://api-colombia.com/api/v1
   ```

3. Instalar dependencias:
   ```bash
   flutter pub get
   ```

4. Ejecutar en tu dispositivo o emulador:
   ```bash
   flutter run
   ```

---

## 10. Guía para el Video de Sustentación
Para el video requerido por el docente (entregable 2), se sugiere la siguiente estructura de 3 a 5 minutos:
1. **Presentación (30 seg):** Saludo, nombre completo (Johan Eliu Salgado Castro), materia y objetivo del taller.
2. **Demostración de la App (1:30 min):**
   * Mostrar el Dashboard y las 4 opciones.
   * Entrar a cada listado mostrando la carga y el listado con `ListView.builder`.
   * Entrar a cada pantalla de detalle (Maestro-Detalle con `go_router`).
3. **Explicación del Código (1:30 min):**
   * Mostrar `pubspec.yaml` y `.env` con `flutter_dotenv`.
   * Mostrar `services/api_service.dart` y explicar el `http.get` con validación `statusCode == 200` y manejo de excepciones.
   * Mostrar un modelo en `models/` explicando `fromJson` y `toJson`.
   * Mostrar `routes/app_router.dart` explicando cómo viajan los parámetros mediante `state.extra`.
4. **GitFlow y Cierre (30 seg):** Mostrar el historial de ramas (`main`, `dev`, `feature/taller_api_colombia`) y el Pull Request en GitHub.
