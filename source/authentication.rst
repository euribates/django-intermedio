Identificación y autentificación de usuarios (*Authentication*)
-----------------------------------------------------------------------

Sirven para identificar y, según corresponda, autorizar o denegar el
acceso de los usuarios. Funcionan en modo encadenado. Por defecto solo
tienes el que añade ``django.contrib.auth``, pero puedes escribir y
añadir los que quieras.

Cuando se llama a ``django.contrib.auth.authenticate()``, Django intenta
autentificar al usuario usando la lista de *authentication backends*
registrados, si el primero que prueba falla, pasa al siguiente y sigue
así hasta que encuentra a alguno que autorice.  Si ninguno de los
*backends* autoriza, la llamada a ``authenticate`` falla.

Más información en:

- <https://docs.djangoproject.com/en/1.6/topics/auth/customizing/>
