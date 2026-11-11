# Examen pr├íctico individual ΓÇô Apache Hive

**Universidad del Valle | Segundo momento**  
**Dataset:** Sample Superstore  
**Repositorio:** `tem1_2mom_herrera-julia`

## Descripci├│n

Este proyecto procesa y analiza el conjunto de datos Sample Superstore utilizando Apache Hive. Incluye la preparaci├│n del archivo CSV, su carga en HDFS, la creaci├│n de una tabla de origen y otra anal├¡tica, y consultas HiveQL para estudiar la calidad de datos, ventas, clientes, productos, descuentos y tendencias.

## Objetivo

Aplicar modelado, ingesta, transformaci├│n y an├ílisis de datos con HiveQL para obtener informaci├│n ├║til sobre las ventas y la rentabilidad de Superstore.

## Requisitos

- Docker Desktop y Docker Compose
- Git
- Python 3
- Apache Hadoop, Hive y Beeline, mediante el entorno Docker
- Dataset Sample Superstore de [Kaggle](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)

## Estructura

```text
dataset/                 Archivo CSV original y TSV preparado (agregados localmente)
scripts/preparar_csv.py  Conversi├│n CSV a TSV
scripts/ddl/             Creaci├│n y carga de tablas
scripts/consultas/       Consultas HiveQL de las preguntas 1 a 8
evidencias/              Capturas de la ejecuci├│n (agregadas localmente)
resultados/              Resultados y an├ílisis (agregados localmente)
documentacion/           Informe y diccionario de datos (agregados localmente)
```

## Procedimiento de ejecuci├│n

1. Descargar el dataset y colocar el archivo con el nombre `dataset/superstore.csv`.
2. Preparar el archivo para Hive:

   ```cmd
   python scripts\preparar_csv.py
   ```

3. Iniciar el entorno Docker desde la carpeta donde est├í `docker-compose.yml`:

   ```cmd
   docker compose up -d
   docker compose ps
   ```

4. Copiar el TSV al contenedor NameNode (ajustar el nombre si es distinto):

   ```cmd
   docker cp dataset\superstore_hive.tsv docker-hive-namenode-1:/tmp/superstore_hive.tsv
   ```

5. Ejecutar las sentencias de `scripts/ddl/01_tabla_raw.sql` en Beeline y despu├⌐s subir los datos a HDFS:

   ```cmd
   docker exec docker-hive-namenode-1 hdfs dfs -mkdir -p /user/hive/warehouse/superstore_raw
   docker exec docker-hive-namenode-1 hdfs dfs -put -f /tmp/superstore_hive.tsv /user/hive/warehouse/superstore_raw/
   ```

6. Ejecutar `02_tabla_analitica.sql` y `03_cargar_analitica.sql` desde Beeline, en ese orden.
7. Comprobar la carga:

   ```sql
   USE examen_superstore;
   SELECT COUNT(*) FROM superstore;
   SELECT * FROM superstore LIMIT 10;
   ```

8. Ejecutar las consultas de `scripts/consultas/` y documentar los resultados obtenidos.

## Preguntas desarrolladas

1. Dise├▒o e implementaci├│n del modelo de datos.
2. Auditor├¡a de calidad e integridad de datos.
3. An├ílisis de evoluci├│n comercial por regi├│n.
4. Segmentaci├│n avanzada de clientes mediante RFM.
5. Ranking de productos seg├║n rentabilidad.
6. An├ílisis del impacto de los descuentos.
7. An├ílisis de tendencias temporales.
8. An├ílisis Pareto de ventas y rentabilidad.

## Resultados y evidencias

El dataset contiene **9.994 registros**, seg├║n la verificaci├│n realizada en Beeline. Las capturas y los resultados completos deben incorporarse en las carpetas `evidencias`, `resultados` y `documentacion`. No se atribuyen valores a consultas cuyos resultados a├║n no se han verificado.

## Optimizaci├│n

Se utiliza una tabla anal├¡tica en formato ORC para facilitar el procesamiento de campos tipados. El an├ílisis utiliza CTE, agregaciones y funciones de ventana como `LAG`, `RANK`, `DENSE_RANK`, `NTILE` y `SUM OVER`. Cualquier comparaci├│n de tiempos o mejora de rendimiento debe documentarse con mediciones reales.

## Conclusiones

La preparaci├│n y carga del dataset permiten realizar an├ílisis de ventas y rentabilidad por regi├│n, cliente y producto. Las consultas ayudan a detectar problemas de calidad y a comparar el comportamiento comercial. Las conclusiones cuantitativas definitivas deben basarse en las salidas de ejecuci├│n de Hive.

## Fuente

[Sample Superstore ΓÇô Kaggle](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)

