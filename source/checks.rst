Django checks
=======================================================================

**Django checks** es un conjunto de
comprobaciones estáticas para validar proyectos Django. Detecta
problemas comunes y proporciona pistas sobre cómo solucionarlos. Además de
las comprobaciones incluidos, se pueden agregar fácilmente chequeos propios.


Las comprobaciones se ejecutan a través del comando ``check``.

.. code:: shell

    python manage.py check


Además, se activan implícitamente antes de la mayoría de los comandos,
incluidos ``migrate`` y ``runserver``. Por temas de rendimiento, **no** se
ejecutan como parte de la pila WSGI que se utiliza en la implementación.
Si necesita ejecutar comprobaciones del sistema en el servidor de
implementación, hay que ejecutarlas explícitamente.

Los errores graves impiden la ejecución de Django. Los problemas menores
no impiden la ejecución, solo muestran mensajes de advertencia en la
consola. En caso de ser necesario, se puede forzar al sistema a ignorar un
determinado chequeo, usando la variable `` SILENCED_SYSTEM_CHECKS`` en el
fichero ``settings.py``.

La lista completa de los chequeos incluidos de serie, y las
explicaciones correspondientes, se pueden encontrar en la
documentación oficial, en `System check framework`_

Cómo escribir nuestros propios chequeos
------------------------------------------------------------------------

Podemos crear nuestros propios chequeos. Para ello solo es necesario
una función que devuelva una lista de posibles errores, y registrar dicha
función en el sistema de chequeos. Los errores en si deben ser instancias
de la clase ``django.core.checks.Error``. Veamos un ejemplo::

.. code:: python

    from django.core.checks import Error, register

    @register()
    def example_check(app_configs, **kwargs):
        errors = []
        # ... your check logic here
        if check_failed:
            errors.append(
                Error(
                    "an error",
                    hint="A hint.",
                    obj=checked_object,
                    id="myapp.E001",
                )
            )
        return errors

La función de comprobación debe aceptar un argumento ``app_configs``. Es
la lista de aplicaciones que deben ser inspeccionadas. Si no se especifica
ninguna, (valor ``None``) entonces la comprobación debe ejecutarse en
todas las aplicaciones instaladas.

En las variable nominales, la función tanbién debe esperar una entrada
llamada ``databases``, con una lista de los nombres / alias de las bases
de datos configuradas en el sistema. Si no se especifica (valor ``None``)
entonces los chequeos no deben acceder a ninguna base de datos.

El argumento **kwargs es necesario para futuras expansiones.

La función debe devolver una lista de mensajes. Si no se encuentran
problemas como resultado de la comprobación, la función de comprobación
debe devolver una lista vacía.

Finalmente, la función debe registrarse explicitamente en el registro de
chequeos del sistema. Idelamente, deberían registrarse cuando se carga ls
aplicación, por ejemplo en la llamada al método ``AppCongig.ready()``.

La forma más habitual, no obstante, es usar el decorador
```django.core.checks.register``. El decorador acepta varios parámetros
que son etiquetas. Las etiquetas no spermiten agrupar los cheuqeos para
que se ejecuten o no dependiendo del contexto. Por ejemplo se pueden
registrar los chequeos de seguridad usango el tag ``Tasg.security``.

Las etiqeutas actualmente definidas son:

- ``admin``: Comporbar problemas con el sistema de *admin*.

- ``async_support``: Comporbar problemas relativo a procesos asíncrono

- ``caches``: Comprobar problemas relativos a la caché

- ``compatibility``: Comprobar problemas con las actualizaciones de versiones

- ``commands``: Comporbar problemas con los comandos personalizados.

- ``database``: Comprobar las conexiones con la base de datos. Estas comprobaciones
  no se ejecutan por defecto, porque normalmente son ms costosas que el
  resto. Se ejecutan automticamente solo en el caso de la orden
  ``migrate`` o si se especifica una base de datos concreta usando su alias con el
  *flag* ``''database`` al llmar a ``check``.

- ``files``: Comprobar la configuracin con respecto a archivos

- ``models``: Comprobar modelos, campos y gestores

- ``security``: Comporbaciones de seguridad

- ``signals``: Comporobar la definición y asignacion de señales 

- ``sites``: Comprobar la configuración de *sites*

- ``staticfiles``: Comprobar la configuración de contenidos estáticos

- ``templates``: Comporbar problemas con las plantillas

- ``translation``: Comprobar problemas con las traducciones.

- ``urls``: Comprobar configuracion de urls.

Recordar que se pueden asignar varias tags a una misma función.
Para ejecutar los chequeos agrupados bajo una etiqeuta, se usa el 
*flag* ``--tag``:

.. code:: shell

    python manage.py check --tag templates


Chequeos para el despliegue
------------------------------------------------------------------------

Además se pueden definir chequeos que solo se ejecutarán en el despliegue,
con el parámetro ``deploy``. Por ejemplo:

.. code:: python

    from django.core.checks import register, Tags

    @register(Tags.security, deploy=True)
    def my_check(app_configs, **kwargs):
        ...
        return errors

Estos chequeos solo se ejecutarán si se llama a la orden ``check`` con el
*flag* ``--deploy``.




    


Los mensajes de error
------------------------------------------------------------------------

Las advertencias y errores devueltos por el método de comprobación deben
ser instancias de ``CheckMessage``. Una instancia de CheckMessage
encapsula una única advertencia o mensaje de rror. También proporciona
contexto, sugerencias y un identificador único que se puede utiliza para
fines de filtrado.

El concepto es similar al usado en ``messages`` o en ``logging``, los
mensajes se etiquetan con un nivel que indica la gravedad del mensaje.
También hay accesos directos para facilitar la creación de mensajes 
con niveles comunes. Al usar estas clases, se puede omitir el argumento
de nivel porque está implícito en el nombre de la clase.

- Depuración

- Info

- Advertencia

- Error

- Crítico


.. _System check framework:: https://docs.djangoproject.com/es/6.0/ref/checks/

