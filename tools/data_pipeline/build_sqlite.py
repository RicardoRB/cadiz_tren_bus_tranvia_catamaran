import sqlite3
import os
import argparse

def build_db(schema_path, output_path):
    print(f"Building database at {output_path}...")

    if os.path.exists(output_path):
        os.remove(output_path)

    conn = sqlite3.connect(output_path)
    cursor = conn.cursor()

    # 1. Crear esquema
    with open(schema_path, 'r') as f:
        cursor.executescript(f.read())

    # 2. (TODO) Cargar datos desde sources/
    # Por ahora, el script es idempotente y crea la base de datos vacía con el esquema correcto.

    conn.commit()
    conn.close()
    print("Database built successfully.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Build the SQLite database for CadizTransit.")
    parser.add_argument("--output", default="assets/data/cadiz_transit.sqlite", help="Path to the output SQLite file")
    parser.add_argument("--schema", default="tools/data_pipeline/schema.sql", help="Path to the schema.sql file")

    args = parser.parse_args()

    # Asegurar que el directorio de salida existe
    os.makedirs(os.path.dirname(args.output), exist_ok=True)

    build_db(args.schema, args.output)
