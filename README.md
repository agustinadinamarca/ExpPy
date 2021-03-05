# ExpPy

Archivo JSON "parameters.json" donde se encontrará una estructura que contiene los parámetros de un experimento computacional a ejecutar. Esta estructura contiene dos subestructuras una correspondiente a los parámetros de configuración "settings" y otra con los parámetros experimentales "experimental_parameters".

A continuación se muestra el contenido del archivo parameters.json de un experimento. Se puede observar que dentro de los paŕametros de configuración (settings) hay 2 parámetros "N" y "step" cuyos valores a explorar se especifican en una lista para cada uno. Por otro lado, en los parámetros experimentales (experimental_parameters) se especfican 6 parámetros. Dentro de settings y de experimental_parameters uno puede colocar todos los parámetros requeridos en el experiemnto a ejecutar usando python. Se adjunta en el repositorio una plantilla del archivo JSON que uno debería utilizar cargando los parámetros nombres y valores a explorar en el experimento de su interrés.

"""
{

    "settings": {
        "N": [10],
        "step": [2]
    },

    "experimental_parameters": {
        "number_agents": [5, 10],
        "alternatives_number": [2, 3],
        "maximum_number_practical_arguments": [5, 10],
        "maximum_number_epistemic_arguments": [2, 4],
        "maximum_attacks_density_value": [0.2],
        "resource_boundness_density": [0.1]
    }
}
"""

