# Limitaciones de Notificaciones en iOS - CadizTransit

Este documento describe las limitaciones y el comportamiento de las notificaciones locales en la plataforma iOS para la aplicación CadizTransit.

## Comportamiento de las notificaciones programadas

En iOS, las notificaciones de recordatorio se implementan utilizando `zonedSchedule` de `flutter_local_notifications`. Este mecanismo utiliza las APIs nativas de iOS para programar alertas que el sistema operativo dispara de forma autónoma.

**Ventaja principal:** No depende de la ejecución en segundo plano (background execution) de la aplicación. Incluso si la aplicación está cerrada o suspendida, el sistema operativo mostrará la notificación a la hora programada.

## Limitaciones Conocidas

1. **Límite de notificaciones pendientes:** iOS impone un límite estricto de **64 notificaciones locales pendientes** por aplicación. Si se intenta programar más, el sistema descartará las más antiguas o fallará al añadir nuevas. En CadizTransit, esto significa que un usuario no debería tener más de 64 recordatorios activos simultáneamente.

2. **Permisos del usuario:** Al igual que en Android 13+, el usuario debe conceder explícitamente permisos de notificación. Si el usuario los deniega, los recordatorios se guardarán en la base de datos local pero el sistema no mostrará ninguna alerta visual ni sonora.

3. **Tareas en segundo plano (Workmanager):** A diferencia de Android, donde `workmanager` permite realizar tareas periódicas de mantenimiento de forma relativamente fiable, iOS restringe fuertemente estas tareas. Por lo tanto, CadizTransit evita depender de chequeos periódicos para disparar notificaciones. Toda la lógica de "cuándo notificar" se calcula y programa en el momento en que el usuario activa el recordatorio.

4. **Sonidos y Personalización:** iOS requiere que los sonidos personalizados estén incluidos en el bundle de la aplicación en tiempo de compilación. Actualmente, CadizTransit utiliza el sonido por defecto del sistema.

## Validación

Debido a que el simulador de iOS a veces presenta comportamientos inconsistentes con las notificaciones y las zonas horarias, se recomienda realizar pruebas finales en **hardware real (iPhone/iPad)** antes de cada lanzamiento mayor que afecte a esta funcionalidad.
