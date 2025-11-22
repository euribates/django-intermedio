Conversores en rutas (*Path converters*)
========================================================================

Para poder usar los conversores, es necesario usar ``path`` en los
ficheros ``urls.py``.


Conversores de serie
------------------------------------------------------------------------

Existe cinco conversores incluidos en la distribución base
de Django, disponibles directamente:

- ``str``: Casa con cualquier cadena de texto que no esté vacía, y que
  no contenga el carácter ``/``, usado como separador en las rutas. Es el
  conversor que se usará por defecto si no especificamos ningún
  conversor. Por ejemplo ``Hola, mundo!``.

- ``int``: Casa con cualquier número entero positivo, incluyendo el
  cero. Devuelve un entero. Por ejemplo ``84532``.

- ``slug``: Casa con una cadena de texto que cumpla las reglas para ser
  considerado como tal: Una cadena de texto no vacía que
  contiene solo letras ASCII, dígitos decimales, el carácter
  guión/menos (``-``) o el carácter subrayado (``_``). Por ejemplo
  ``hola_mundo23``.

- ``uuid``: Casa con una *string* formateada siguiendo el formato de
  representación textual de los `UUID`_. Esto implica que se deben
  incluir los guiones, y que los dígitos hexadecimales deben ir en
  minúsculas. Por ejemplo ``075194d3-6885-417e-a8a8-6c931e272f00``.
  

- ``path``: Casa con cualquier cadena de texto, incluso si contiene el
  separador ``/``. De esta forma se puede trabajar con la URL completa.
  Por ejemplo ``hola/mundo/``


.. _UUID: https://es.wikipedia.org/wiki/Identificador_%C3%BAnico_universal
.. _URL: https://es.wikipedia.org/wiki/Localizador_de_recursos_uniforme
