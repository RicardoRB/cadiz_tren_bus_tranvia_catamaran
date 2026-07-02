# AGENTS.md

Instrucciones para agentes de codificación IA (Jules, Codex, Cursor, etc.) que trabajen en este repositorio. Léelo entero antes de empezar cualquier tarea.

## Sobre el proyecto

**CadizTransit** es una app Flutter multiplataforma (Android, iOS, Web) que muestra horarios y localizaciones de bus, tranvía, cercanías (Renfe) y catamarán en la provincia de Cádiz (España).

**Restricción de arquitectura clave: no hay backend propio.** Todos los datos estáticos (paradas, líneas, horarios) viven embebidos en un fichero SQLite dentro de la app, generado por un pipeline offline (`tools/data_pipeline/`). Cuando exista tiempo real, se llama directamente desde el cliente Flutter a las APIs públicas de cada operador (sin proxy propio), con fallback automático a datos estáticos si la API falla o no existe. No propongas ni construyas un backend/servidor propio salvo que se te pida explícitamente.

El desarrollo sigue un plan por fases (Fase 0 a Fase 8, ver `docs/roadmap.md` si existe). No implementes funcionalidad de una fase futura mientras trabajas en una tarea de una fase anterior, aunque te parezca una mejora natural; si detectas un prerequisito bloqueante de una fase posterior, coméntalo en la descripción del PR en vez de implementarlo fuera de alcance.

## Stack técnico

- **Framework:** Flutter (stable channel), Dart 3.x, null-safety estricto.
- **Gestión de estado:** `riverpod` (`flutter_riverpod`). Si el proyecto usa `riverpod_generator` (`@riverpod`), sigue ese mismo patrón; no mezcles providers generados con providers manuales dentro del mismo proyecto.
- **Navegación:** `go_router`, rutas declarativas. Debe funcionar correctamente con el botón atrás del navegador en Web (deep linking real, no solo hash routing).
- **Base de datos local:** `drift` sobre `sqlite3_flutter_libs`, con soporte explícito para Web vía WASM. El setup de Web difiere del de móvil; sigue la guía oficial de drift para Web vigente en el momento de la tarea en vez de replicar el código de móvil sin más.
- **Mapa:** `flutter_map` sobre OpenStreetMap. No uses Google Maps ni ningún proveedor de mapas de pago; es una decisión de arquitectura tomada por coste.
- **Geolocalización:** `geolocator`.
- **Red (solo para tiempo real):** `dio`, `connectivity_plus`.
- **Notificaciones:** `flutter_local_notifications`. En iOS evita depender de ejecución periódica en segundo plano; usa notificaciones programadas de antemano (`zonedSchedule`) en vez de un mecanismo de chequeo continuo.
- **UI:** Material 3, `flex_color_scheme` para modo oscuro, `shimmer` para estados de carga.
- **Otros:** `shared_preferences`, `intl` (formateo `es_ES`), `package_info_plus`.

No añadas dependencias fuera de esta lista sin justificarlo en la descripción del PR. Si una tarea requiere un paquete no listado aquí, añádelo con una versión fijada y explica por qué en el PR.

## Estructura del repositorio

```
tools/
  data_pipeline/
    schema.sql              # DDL fuente de verdad del esquema SQLite
    sources/<modo>/*.json    # datos intermedios por modo de transporte
    build_sqlite.py          # genera assets/data/cadiz_transit.sqlite
docs/                        # documentación técnica y de proceso
lib/
  core/
    theme/
    routing/
    utils/
  database/
    drift/                   # tablas, DAOs, código generado
    seed/                    # carga del sqlite embebido como asset
  features/
    home/ lines/ stops/ map/ favorites/ schedule/ search/ settings/ realtime/
    <feature>/
      data/                  # repositorios, DAOs
      domain/                # modelos de dominio, casos de uso
      presentation/
        screens/             # pantallas completas
        widgets/             # widgets reutilizables de la feature
        providers/           # providers de riverpod
  shared/
    widgets/                 # widgets comunes a toda la app (estados vacíos, error, etc.)
    models/
assets/
  data/
    cadiz_transit.sqlite     # generado por tools/data_pipeline/build_sqlite.py, no editar a mano
test/
```

No dupliques esta estructura ni inventes una alternativa. Si una carpeta que necesitas no existe todavía, créala respetando esta convención.

## Modelo de datos (SQLite embebido)

Fuente de verdad: `tools/data_pipeline/schema.sql`. Tablas: `operators`, `stops`, `routes`, `trips`, `stop_times`.

- `operators(id, name, transport_mode, attribution_text, license_url)`
- `stops(id, name, lat, lon, transport_mode, operator_id)`
- `routes(id, name, operator_id, transport_mode, color_hex)`
- `trips(id, route_id, direction)` — `direction`: `'outbound' | 'inbound'`
- `stop_times(trip_id, stop_id, sequence, arrival_time, departure_time, day_type)` — `day_type`: `'weekday' | 'saturday' | 'holiday'`

`transport_mode` es un enum común a toda la app: `'bus' | 'tram' | 'commuter_rail' | 'catamaran'`.

No modifiques este esquema sin actualizar `tools/data_pipeline/schema.sql`, `docs/schema.md` y las tablas/DAOs de Drift en el mismo PR. Un cambio de esquema no coordinado con estos tres sitios rompe el resto de la app.

Límites geográficos válidos para coordenadas de la provincia de Cádiz (usados en validación): lat entre 36.0 y 37.0, lon entre -6.4 y -5.2.

## Setup y comandos

```bash
# Instalar dependencias
flutter pub get

# Generar código (Drift, Riverpod si usa codegen)
dart run build_runner build --delete-conflicting-outputs

# Regenerar el SQLite embebido a partir de tools/data_pipeline/sources/
python3 tools/data_pipeline/build_sqlite.py --output assets/data/cadiz_transit.sqlite

# Analizar
flutter analyze

# Tests
flutter test

# Ejecutar en cada plataforma
flutter run -d chrome
flutter run -d android
flutter run -d ios
```

Ejecuta `flutter analyze` y `flutter test` antes de dar cualquier tarea por terminada. Corrige cualquier error o warning nuevo que hayas introducido tú; no es necesario que arregles deuda técnica preexistente no relacionada con tu tarea, pero si la detectas, coméntala en el PR.

## Convenciones de código

- Idioma del código (nombres de variables, clases, funciones, comentarios): **español (es_ES)**.
- Idioma de la interfaz visible al usuario final: **español (es_ES)**.
- Nombres de archivo: `snake_case.dart`.
- Cada feature sigue estrictamente las capas `data/` (repositorios, DAOs), `domain/` (modelos, lógica de negocio pura), `presentation/` (screens, widgets, providers).
- Los widgets de UI (`presentation/`) nunca acceden directamente a clases generadas por Drift; siempre pasan por un repositorio de `data/` que devuelve modelos de dominio propios.
- Un widget de pantalla completa va en `presentation/screens/`; un widget reutilizable dentro de esa misma feature va en `presentation/widgets/`; un widget reutilizable en toda la app va en `lib/shared/widgets/`.
- Usa `Semantics`/`semanticLabel` en botones e iconos sin texto visible asociado (accesibilidad).
- No fuerces `textScaleFactor`/`textScaler` a un valor fijo; el texto debe poder escalar con la configuración del sistema.

## Datos mock vs. datos reales

Si necesitas datos (horarios, coordenadas, nombres de paradas) que aún no están disponibles en `tools/data_pipeline/sources/`, genera datos de ejemplo realistas y márcalos explícitamente como mock, por ejemplo:

```dart
// MOCK DATA - replace when real data available for this operator
```

o, en JSON: `"_mock": true`. Nunca presentes datos inventados como si fueran reales sin esa marca.

## Testing

- Toda lógica de negocio nueva (repositorios, resolvers, cálculos) necesita al menos un test unitario.
- Las queries de Drift no triviales necesitan un test de integración usando `NativeDatabase.memory()` con datos de prueba conocidos, no la base de datos real.
- Los tests de UI (widget tests) son deseables para pantallas con lógica condicional relevante (ej. estados vacío/error/cargando), pero no bloqueantes para cambios puramente visuales.
- Coloca los tests en `test/` replicando la estructura de `lib/` (ej. `lib/features/schedule/data/schedule_repository.dart` → `test/features/schedule/schedule_repository_test.dart`).

## Tiempo real y red

- Cualquier llamada de red a una API de operador debe pasar por la interfaz `RealtimeProvider` (`lib/features/realtime/domain/realtime_provider.dart`) y tener un timeout corto (≈5s) y manejo de error explícito.
- El fallback a datos estáticos ante fallo de red, error HTTP o ausencia de conexión (`connectivity_plus`) debe ser automático y transparente para el usuario, con una indicación visual clara de qué fuente de datos se está mostrando ("EN VIVO" vs "Horario planificado").
- No inventes ni asumas la existencia de un endpoint de un operador que no esté confirmado en `docs/data_sources.md`. Si no hay fuente confirmada, documenta el bloqueo en vez de simular una API real.
- No implementes un proxy/backend propio para resolver problemas de CORS en Web; documenta el hallazgo en `docs/web_cors_notes.md` en su lugar.

## Seguridad y privacidad

- La app usa geolocalización (`geolocator`) y notificaciones locales (`flutter_local_notifications`); ambos permisos deben solicitarse de forma contextual, no de forma agresiva al primer arranque.
- Ningún dato de ubicación del usuario se envía a ningún servidor propio (no existe backend). Si añades cualquier llamada de red, verifica que no incluya datos de ubicación del usuario salvo que sea estrictamente necesario para una API de operador ya documentada y aprobada.
- No incluyas claves, tokens ni credenciales en el código. Si una tarea requiere una API key, dócumenta dónde debe configurarse (variable de entorno o fichero ignorado por git), pero no la generes ni la subas.

## Pull requests

- Cada PR debe corresponder a una única historia/tarea bien delimitada; evita mezclar cambios no relacionados.
- Usa commits pequeños y descriptivos.
- En la descripción del PR, resume: qué criterios de aceptación cumples, qué tests añadiste o modificaste, y cualquier decisión o supuesto que hayas tomado ante alguna ambigüedad del ticket.
- Si tu tarea deja explícitamente pendiente algo para una fase futura (por ejemplo, un `// TODO F5-1: persist favorite`), indícalo también en la descripción del PR para que quede trazable.

## Qué NO hacer

- No añadas un backend, servidor propio o base de datos remota: la arquitectura es explícitamente sin backend.
- No sustituyas OpenStreetMap/`flutter_map` por Google Maps u otro proveedor de pago.
- No implementes lógica de negocio de fases futuras dentro de una tarea de una fase anterior.
- No modifiques el esquema de `tools/data_pipeline/schema.sql` sin actualizar Drift y `docs/schema.md` en el mismo cambio.
- No presentes datos mock como si fueran datos reales sin marcarlos explícitamente.
- No implementes un proxy para evitar CORS en Web; solo documenta el problema.