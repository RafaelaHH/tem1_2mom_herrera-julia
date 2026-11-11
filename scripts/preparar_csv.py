import csv
from pathlib import Path

base = Path(__file__).resolve().parent.parent
origen = base / "dataset" / "superstore.csv"
destino = base / "dataset" / "superstore_hive.tsv"

with origen.open("r", encoding="cp1252", newline="") as entrada:
    lector = csv.DictReader(entrada)
    columnas = lector.fieldnames
    print("Columnas:", columnas)

    with destino.open("w", encoding="utf-8", newline="") as salida:
        escritor = csv.writer(salida, delimiter="\t", lineterminator="\n", quoting=csv.QUOTE_NONE, escapechar="\\")
        total = 0
        for fila in lector:
            valores = []
            for columna in columnas:
                valor = fila[columna] or ""
                valor = valor.replace("\t", " ").replace("\r", " ").replace("\n", " ")
                valores.append(valor)
            escritor.writerow(valores)
            total += 1

print("Registros procesados:", total)
print("Archivo generado:", destino)
