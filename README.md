# ExpPy

*ExpPy* es un software que permite automatizar y sistematizar la ejecución de un experimento o simulación computacionales desarrolladas en *Python* para cuando se quiere explorar conjuntos de valores para sus parámetros para descubrir cómo responde el sistema ante los cambios en los valores de sus parámetros.

## Descripción

Para utilizar *ExpPy* tiene que realizar lo siguiente:

1. Cargar los parámetros que existen en su experimento computacional en un archivo JSON denominado *"parameters.json"* (ver template adjunto). Este archivo presenta una estructura de datos con un único atributo denominado *"parameters"*. Este atributo es un único objeto cuyos atributos son los parámetros del experimento de interés. Cada uno de estos atributos tiene asignado una lista con valores que queremos que tomen. A continuación se muestra el contenido del archivo *"parameters.json"* de un experimento hipotético que presenta 8 parámetros (*"N", "step", "number_agents", "alternatives_number", "maximum_number_practical_arguments", "maximum_number_epistemic_arguments", "maximum_attacks_density_value" y "resource_boundness_density"*). Entre "[ ]" se listan tantos valores de cada variable como se quienan a explorar.

```
{
    "parameters": {
        "N": [10],
        "step": [2],
        "number_agents": [5, 10],
        "alternatives_number": [2, 3],
        "maximum_number_practical_arguments": [5, 10],
        "maximum_number_epistemic_arguments": [2, 4],
        "maximum_attacks_density_value": [0.2],
        "resource_boundness_density": [0.1]
    }

}
```

2. Luego a partir del archivo JSON es posible generar un archivo csv con todas las configuraciones posibles de valores de los parámetros experimentales
especificados en el JSON que son los que se desearían explorar. Esto se logra con el archivo get_configurations.py. Cada configuración estará representada mediante un string donde los valores de los paŕametros estarán separados por comas en el orden en el que fueron declarados en el JSON file. Los dos primeros valores corresponderán al estado del experimento (si no fue ejecutado 0, si está en ejecución i y si ha finalizado f) y un id numerico. Por ejemplo, una configuracion posible siguiendo el ejemplo sería "0,0,5,2,5,2,0.2,0.1" donde el primer elemento es el status, el segundo el id, el tercero number_agents, el cuarto alternatives_number, y así sucesivamente hasta el último parámetro. El archivo generado se llamará configurations.csv.

Finalmente, resta ejecutar cada una de las configuraciones generadas. esto se logra con el archivo de bash run_experiments.sh. Este file lee las configuraciones del archivo configurations.csv (las que tienen status = "0", es decir, auqellas que no hay sido ejecutadas nunca) y ejecuta los scripts de python correspondientes. El stript de python a ejecutar se demonina main.py y recibe un único parámetro, el string correspondiente a una configuración que se lee del configurations.csv.

El archivo main.py recibe un string correspondiente a una configuración (el orden de los valores corresponde al del JSON) y allí mismo principalmente le pasa los parámetros a la función que representa nuestro experimento. En el archivo main hay que importar un módulo que tiene la función que va a ejecutarse que es el experimento mismo. Esta función tiene que tener la forma "funcion_experiment(parameter1,, parameter2, ..., parameterm)". Además cuenta con unas rutinas que al dar comienzo con la ejecutcion del function_experiment modifica el status de esta configiracion en el configuration.csv a i y lo buelve a hacer cuando esto finaliza. Cabe mencionar que el guardado de resultados corre por cuenta de quien diseña el propio experimento encapsulado en funcion_experiment.


En resumen:
1. Crear un JSON file según el template
2. Generar el archivo configurations.csv ejecutando la linea python3 get_configurations.py
3. Encapsular el experimento propio en una funcion de la forma function_experiment(parameter1, parameter2, ..., parameterm) donde parameter1, parameter2, paramenterm corresponden a los parameteros del json en el orden en el que fueron declarados.
4. Ejecutar la linea bash run_experiments.sh


