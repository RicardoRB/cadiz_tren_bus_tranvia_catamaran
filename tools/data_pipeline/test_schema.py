import sqlite3
import os

def test_schema():
    db_path = "test_cadiz_transit.sqlite"
    schema_path = "tools/data_pipeline/schema.sql"

    if os.path.exists(db_path):
        os.remove(db_path)

    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    # 1. Ejecutar el esquema
    with open(schema_path, 'r') as f:
        cursor.executescript(f.read())

    print("✅ Esquema creado correctamente.")

    try:
        # 2. Insertar datos de ejemplo (Bus y Tranvía)
        cursor.execute("INSERT INTO operators VALUES ('ctmc', 'Consorcio Bahía de Cádiz', 'bus', 'Datos de prueba', 'http://example.com')")
        cursor.execute("INSERT INTO operators VALUES ('tram', 'TramBahía', 'tram', 'Datos de prueba', 'http://example.com')")

        cursor.execute("INSERT INTO stops VALUES ('stop_bus_1', 'Plaza España', 36.53, -6.29, 'bus', 'ctmc')")
        cursor.execute("INSERT INTO stops VALUES ('stop_tram_1', 'Río Arillo', 36.48, -6.19, 'tram', 'tram')")

        cursor.execute("INSERT INTO routes VALUES ('route_m010', 'M-010 Cádiz-San Fernando', 'ctmc', 'bus', '#FF0000')")
        cursor.execute("INSERT INTO routes VALUES ('route_t1', 'Línea 1', 'tram', 'tram', '#0000FF')")

        cursor.execute("INSERT INTO trips VALUES ('trip_bus_out', 'route_m010', 'outbound')")
        cursor.execute("INSERT INTO trips VALUES ('trip_tram_out', 'route_t1', 'outbound')")

        cursor.execute("INSERT INTO stop_times VALUES ('trip_bus_out', 'stop_bus_1', 1, '08:00:00', '08:05:00', 'weekday')")
        cursor.execute("INSERT INTO stop_times VALUES ('trip_tram_out', 'stop_tram_1', 1, '09:00:00', '09:02:00', 'weekday')")

        conn.commit()
        print("✅ Datos de ejemplo insertados correctamente.")

        # 3. Verificar integridad referencial y JOINs
        cursor.execute("""
            SELECT o.name, r.name, s.name, st.arrival_time
            FROM operators o
            JOIN routes r ON o.id = r.operator_id
            JOIN trips t ON r.id = t.route_id
            JOIN stop_times st ON t.id = st.trip_id
            JOIN stops s ON st.stop_id = s.id
            WHERE o.transport_mode = 'bus'
        """)

        result = cursor.fetchone()
        assert result is not None, "Debe devolver al menos un resultado para el bus"
        print(f"✅ Consulta Bus: {result}")

        cursor.execute("""
            SELECT o.name, r.name, s.name, st.arrival_time
            FROM operators o
            JOIN routes r ON o.id = r.operator_id
            JOIN trips t ON r.id = t.route_id
            JOIN stop_times st ON t.id = st.trip_id
            JOIN stops s ON st.stop_id = s.id
            WHERE o.transport_mode = 'tram'
        """)

        result = cursor.fetchone()
        assert result is not None, "Debe devolver al menos un resultado para el tranvía"
        print(f"✅ Consulta Tranvía: {result}")

        # 4. Verificar validaciones de CHECK
        try:
            cursor.execute("INSERT INTO stops VALUES ('stop_fail', 'Error', 40.0, -3.0, 'bus', 'ctmc')")
            assert False, "Debería haber fallado por coordenadas fuera de rango"
        except sqlite3.IntegrityError:
            print("✅ Validación de coordenadas (CHECK) funciona correctamente.")

        print("🚀 ¡Todas las pruebas del esquema han pasado!")

    finally:
        conn.close()
        if os.path.exists(db_path):
            os.remove(db_path)

if __name__ == "__main__":
    test_schema()
