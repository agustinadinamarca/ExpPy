# ExpPy

*ExpPy* es un software que permite automatizar y sistematizar la ejecución de un experimento o simulación computacionales desarrolladas en *Python* para cuando se quiere explorar conjuntos de valores para sus parámetros para descubrir cómo responde el sistema.

## Descripción

Para utilizar *ExpPy* tiene que realizar lo siguiente:

1. Cargar los parámetros que existen en su experimento computacional en un archivo JSON denominado *"parameters.json"* (ver template adjunto). Este archivo presenta una estructura de datos con un único atributo denominado *"parameters"*. Este es un único objeto cuyos atributos son conjuntos de parámetros del experimento de interés. Cada uno de estos conjuntos contiene como atributos parámetros que tienen asignados una lista con valores que queremos que adopten. A continuación se muestra el contenido del archivo *"parameters.json"* de un experimento hipotético que presenta N conjuntos de parámetros (*"parameters_type_1", ..., "parameters_type_N"*) donde cada uno presenta K1, ..., KN parámetros. Entre "[ ]" se listan tantos valores de cada variable como se quienan explorar.

```
{
    "parameters_type_1": {
        "param11": [5, 10],
        "param12": [0.1, 0.2, 0.3],
        .
        .
        .
        "param1K1": [1, 2]
    },
    .
    .
    .,
    
    "parameters_type_N": {
        "paramN1": [2, 4, 6],
        "paramN2": [0.1],
        .
        .
        .
        "paramNKN": [1.2, 3.4, 4.5]
    }

}
```
2. Encapsular el experimento propio desarrollado en *Python* en la función *"my_function"* de *"my_experiment.py"*. Esta función recibe tantos argumentos como parámetros se hayan declarado en "parameters.json" y en el orden en el que fueron dispuestos.

3. Generar y guardar todas las configuraciones de valores de parámetros especificados en *"parameters.json"*. Esto se logra ejecutando *"get_configurations.py"* de la sigiente forma:

```
python3 get_configurations.py
```

Como resultado se crea el archivo *"configurations.csv"*. A continuación se muestra un fragmento representativo de las configuraciones objenidas para un experimento hipotético.

```
status,id,param11,...,param1K1, ...., paramN1, ...., paramNKN
0,0,5,0.1,...,1,...,2,...,4.5
0,1,5,0.1,...,2,...,4,...,4.5
.
.
.
0,M,10,0.3,...,6,...,2,...,4.5

```
La primera fila (*"status,id,param11,...,param1K1, ...., paramN1, ...., paramNKN"*) corresponde al header del csv en la que se especifican los nombres de las columnas separados por comas. El resto de las filas representan configuraciones de valores de parámetros (ej. *"0,0,5,0.1,...,1"*). La primera columna se denomina *"status"* y representa el estado del experimento para cierta configuración y puede adoptar los siguientes valores *{0, i, f}* (*"0"*: no ejecutado, *"i"*: iniciado, y *"f"*: finalizado). Al crearse por primera vez *"configurations.csv"* los *"status"* de todas las configuraciones son *"0"*. Luego, la segunda columna llamada *"id"* es la identificación de la configuración y es un valor entero positivo. Así, si hay M (M > 0) configuraciones, el *"id"* es *0* para la primera configuración y *M - 1* para la última. Finalmente, las columnas siguientes son los valores de los parámetros del experimento, separados por comas, dispuestos en el orden en el que fueron declarados en *"parameters.json"*.

4. Ejecutar experimentos de forma automática y sistemática mediante el archivo de *Bash* *"run_experiments.sh"* de la siguiente manera:
```
bash run_experiments.sh
```
Este archivo lee las configuraciones, si existen, en *"configurations.csv"* (las que presentan *status* = 0*, es decir, aquellas que no hay sido ejecutadas nunca) y ejecuta un archivo de *Python* para cada una de ellas. El archivo de *Python* a ejecutar se demonina *"main.py"* y recibe como único argumento el string correspondiente a una configuración no ejecutada aún y que lee de *"configurations.csv"*. En términos generales, *"main.py"* le pasa los parámetros del experimento a la función *"my_function"* en *"my_experiment.py"* del punto 2, que representa el propio experimento. Además, *"main.py"* al dar comienzo con una ejecución de *"my_function"*, modifica el *"status"* de esa configuración en *configuration.csv* cambiándo de "0" a "i", y lo vuelve a hacer cuando ésta finaliza, cambiándo de "i" a "f". Cabe mencionar que el guardado de resultados de los experimentos corre por cuenta de quien diseña el propio experimento que fue encapsulado en la función *"my_function"* en *"my_experiment.py"*.

## Uso

1. Cargar los parámetros del experimento de interés en *"parameters.json"*.
2. Encapsular el experimento de interés, desarrollado por usted en *Python*, en la función "my_function" de "my_experiment.py". Esta función recibe tantos argumentos como parámetros se hayan declarado en "parameters.json" y en el orden en el que fueron dispuestos.
3. Generar *"configurations.csv"* ejecutando en una terminal de linux la línea: `python3 get_configurations.py`
5. Ejecutar los experimentos en una terminal de linux mediante la línea: `bash run_experiments.sh`

## Nota

El software *PyExp* está diseñado de manera tal que si en la ejecución de los experimentos computacionales ocurre una interrupción en la misma usted pueda continuar con los experimentos de las configuraciones restantes sin tener que ejecutar configuraciones que ya fueron ejecutadas. Simplmente, frente a una interrupción, para continuar con los experimentos faltantes ejecute la siguiente línea en una terminal de linux: `bash run_experiments.sh`.

