# ExpPy

*ExpPy* es un software que permite automatizar y sistematizar la ejecución de un experimento o simulación computacionales desarrolladas en *Python* para cuando se quiere explorar conjuntos de valores para sus parámetros para descubrir cómo responde el sistema ante los cambios en los valores de sus parámetros.

## Descripción

Para utilizar *ExpPy* tiene que realizar lo siguiente:

1. Cargar los parámetros que existen en su experimento computacional en un archivo JSON denominado *"parameters.json"* (ver template adjunto). Este archivo presenta una estructura de datos con un único atributo denominado *"parameters"*. Este es un único objeto cuyos atributos son los parámetros del experimento de interés. Cada uno de estos atributos tiene asignado una lista con valores que queremos que adopten. A continuación se muestra el contenido del archivo *"parameters.json"* de un experimento hipotético que presenta N parámetros (*"param1", "param2", ..., "paramN"*). Entre "[ ]" se listan tantos valores de cada variable como se quienan explorar.

```
{
    "parameters": {
        "param1": [5, 10],
        "param2": [0.1, 0.2, 0.3],
        .
        .
        .
        "paramN": [1, 2]
    }

}
```

2. Generar y guardar todas las configuraciones de valores de parámetros especificados en *"parameters.json"*. Esto se logra ejecutando *"get_configurations.py"* de la sigiente forma:

```
python3 get_configurations.py
```

Como resultado se crea el archivo *"configurations.csv"*. A continuación se muestra un fragmento representativo de las configuraciones objenidas para un experimento hipotético.

```
status,id,param1,param2,...,paramN
0,0,5,0.1,...,1
0,1,5,0.1,...,2
.
.
.
0,M,10,0.3,...,2

```
La primera fila (*"status,id,param1,param2,...,paramN"*) corresponde al header del csv en la que se especifican los nombres de las columnas separados por comas. El resto de las filas representan configuraciones de valores de parámetros (ej. *"0,0,5,0.1,...,1"*). La primera columna se denomina *"status"* y representa el estado del experimento para cierta configuración y puede adoptar los siguientes valores *{0, i, f}* (*"0"*: no ejecutado, *"i"*: iniciado, y *"f"*: finalizado). Al crearse por primera vez *"configurations.csv"* los *"status"* de todas las configuraciones son *"0"*. Luego, la segunda columna llamada *"id"* es la identificación de la configuración y es un valor entero positivo. Así, si hay M (M > 0) configuraciones, el *"id"* es *0* para la primera configuración y *M - 1* para la última. Finalmente, las columnas siguientes son los valores de los parámetros del experimento, separados por comas, dispuestos en el orden en el que fueron declarados en *"parameters.json"*.

3. Ejecutar experimentos de forma automática y sistemática mediante el archivo de *Bash* *"run_experiments.sh"* de la siguiente manera:
```
bash run_experiments.sh
```
Este archivo lee las configuraciones, si existen, en *"configurations.csv"* (las que presentan *status* = 0*, es decir, aquellas que no hay sido ejecutadas nunca) y ejecuta un archivo de *Python* para cada una de ellas. El archivo de *Python* a ejecutar se demonina *"main.py"* y recibe como único argumento el string correspondiente a una configuración no ejecutada aún y que lee de *"configurations.csv"*.


l archivo main.py recibe un string correspondiente a una configuración (el orden de los valores corresponde al del JSON) y allí mismo principalmente le pasa los parámetros a la función que representa nuestro experimento. En el archivo main hay que importar un módulo que tiene la función que va a ejecutarse que es el experimento mismo. Esta función tiene que tener la forma "funcion_experiment(parameter1,, parameter2, ..., parameterm)". Además cuenta con unas rutinas que al dar comienzo con la ejecutcion del function_experiment modifica el status de esta configiracion en el configuration.csv a i y lo buelve a hacer cuando esto finaliza. Cabe mencionar que el guardado de resultados corre por cuenta de quien diseña el propio experimento encapsulado en funcion_experiment.

## Uso

1. Cargar los parámetros del experimento de interés en *"parameters.json"*.
2. Encapsular el experimento de interés, desarrollado en *Python*, en la función "my_function" de "my_experiment.py". Esta función recibe tantos argumentos como parámetros se hayan declarado en "parameters.json" y en el orden en el que fueron declarados.
3. Generar *configurations.csv* ejecutando en una terminal de linux la línea: `python3 get_configurations.py`
5. Ejecutar los experimentos en una terminal de linux mediante la línea: `bash run_experiments.sh`


