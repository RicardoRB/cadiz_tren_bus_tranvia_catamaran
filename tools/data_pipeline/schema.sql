-- Esquema de base de datos para CadizTransit
-- Fuente de verdad para el pipeline de datos y Drift

-- Desactivar temporalmente las claves foráneas para facilitar la creación (opcional en scripts de creación)
PRAGMA foreign_keys = ON;

-- Tabla de Operadores (Consorcio, Renfe, etc.)
CREATE TABLE operators (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    transport_mode TEXT NOT NULL CHECK (transport_mode IN ('bus', 'tram', 'commuter_rail', 'catamaran')),
    attribution_text TEXT,
    license_url TEXT
);

-- Tabla de Paradas
CREATE TABLE stops (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    lat REAL NOT NULL CHECK (lat BETWEEN 36.0 AND 37.0),
    lon REAL NOT NULL CHECK (lon BETWEEN -6.4 AND -5.2),
    transport_mode TEXT NOT NULL CHECK (transport_mode IN ('bus', 'tram', 'commuter_rail', 'catamaran')),
    operator_id TEXT NOT NULL,
    FOREIGN KEY (operator_id) REFERENCES operators(id) ON DELETE CASCADE
);

-- Tabla de Rutas/Líneas
CREATE TABLE routes (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    operator_id TEXT NOT NULL,
    transport_mode TEXT NOT NULL CHECK (transport_mode IN ('bus', 'tram', 'commuter_rail', 'catamaran')),
    color_hex TEXT, -- Formato #RRGGBB
    FOREIGN KEY (operator_id) REFERENCES operators(id) ON DELETE CASCADE
);

-- Tabla de Viajes (instancia de una ruta en una dirección)
CREATE TABLE trips (
    id TEXT PRIMARY KEY,
    route_id TEXT NOT NULL,
    direction TEXT NOT NULL CHECK (direction IN ('outbound', 'inbound')),
    FOREIGN KEY (route_id) REFERENCES routes(id) ON DELETE CASCADE
);

-- Tabla de Tiempos de Parada (Horarios)
CREATE TABLE stop_times (
    trip_id TEXT NOT NULL,
    stop_id TEXT NOT NULL,
    sequence INTEGER NOT NULL,
    arrival_time TEXT NOT NULL, -- Formato HH:MM:SS
    departure_time TEXT NOT NULL, -- Formato HH:MM:SS
    day_type TEXT NOT NULL CHECK (day_type IN ('weekday', 'saturday', 'holiday')),
    PRIMARY KEY (trip_id, stop_id, sequence),
    FOREIGN KEY (trip_id) REFERENCES trips(id) ON DELETE CASCADE,
    FOREIGN KEY (stop_id) REFERENCES stops(id) ON DELETE CASCADE
);

-- Índices para optimizar búsquedas comunes
CREATE INDEX idx_stop_times_stop_day ON stop_times(stop_id, day_type);
CREATE INDEX idx_stop_times_trip_sequence ON stop_times(trip_id, sequence);
CREATE INDEX idx_stops_operator ON stops(operator_id);
CREATE INDEX idx_routes_operator ON routes(operator_id);
CREATE INDEX idx_trips_route ON trips(route_id);
