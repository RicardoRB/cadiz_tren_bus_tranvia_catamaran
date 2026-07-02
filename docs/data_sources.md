# Fuentes de Datos - CadizTransit

Este documento registra el origen de los datos para cada operador y modo de transporte, así como sus condiciones de licencia.

| Operador | Modo | Fuente Estática (GTFS/JSON) | Fuente Tiempo Real (API) | Licencia | Estado |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Consorcio Bahía de Cádiz | Bus / Catamarán | [Consorcio](https://transporteandalucia.es/) | Pendiente | Pública / Reutilización | Mock / Parcial |
| Renfe Cercanías | Tren | GTFS Renfe | Pendiente | Pública | Mock / Parcial |
| TramBahía | Tranvía | Junta de Andalucía | Pendiente | Pública | Mock / Parcial |

## Notas por Operador

### Consorcio de Transportes de la Bahía de Cádiz
Los datos se obtienen mediante el pipeline de datos que procesa los JSON/CSV descargados.

### Renfe
Se utiliza el GTFS oficial de Renfe para la línea C1 de Cádiz.

### TramBahía
Operado por la Junta de Andalucía. Se integra en el pipeline de datos.
