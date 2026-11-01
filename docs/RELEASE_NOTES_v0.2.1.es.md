# v0.2.1 — Desinstalación fiable entre cuentas de Windows

[Español](RELEASE_NOTES_v0.2.1.es.md) · [English](RELEASE_NOTES_v0.2.1.md) · [Français](RELEASE_NOTES_v0.2.1.fr.md) · [Deutsch](RELEASE_NOTES_v0.2.1.de.md) · [Italiano](RELEASE_NOTES_v0.2.1.it.md) · [Português](RELEASE_NOTES_v0.2.1.pt.md) · [Norsk bokmål](RELEASE_NOTES_v0.2.1.nb.md) · [Dansk](RELEASE_NOTES_v0.2.1.da.md) · [Русский](RELEASE_NOTES_v0.2.1.ru.md) · [Українська](RELEASE_NOTES_v0.2.1.uk.md) · [Беларуская](RELEASE_NOTES_v0.2.1.be.md)

## Nuevo instalador

- Corrige el error **1605** causado al confundir el registro de un teclado en el equipo con una instalación MSI perteneciente a la cuenta actual.
- La desinstalación selecciona el producto realmente registrado tras comprobar su MSI en caché, nombre y DLL del teclado, en lugar de suponer que lo identifica el paquete descargado.
- Las instalaciones existentes por usuario se quitan desde su cuenta propietaria. Las instalaciones del equipo solicitan autorización de administrador.
- Las instalaciones nuevas se registran para todo el equipo; la preferencia de teclado predeterminado sigue siendo independiente por cuenta.
- Los productos ausentes, ambiguos o no verificables se notifican antes de restaurar una preferencia predeterminada. No se borran manualmente archivos de teclado ni entradas de registro.
- La ventana y los diálogos del instalador muestran ahora **v0.2.1**. Las propiedades del archivo identifican la misma versión. Desinstalar un teclado del equipo puede afectar a otras cuentas.

## Fiabilidad y documentación

- La instalación MSI nueva usa explícitamente `ALLUSERS=1`. Las desinstalaciones por usuario evitan relanzar la operación como otro administrador.
- Los registros detallados `/L*V` y los diagnósticos de producto y contexto se guardan localmente en `%LOCALAPPDATA%\AngleQuotes\logs`. No se envían automáticamente y pueden contener identificadores de cuenta y rutas.
- La salida correcta `0` se contrasta con el inventario MSI antes de comunicar el éxito. Se conserva la salida `3010`, que solicita reiniciar. Los datos de versión proceden de una única fuente.

## Compatibilidad y advertencias

Las DLL de teclado, los paquetes MSI, las asignaciones de caracteres y los textos de práctica no cambian respecto a v0.2.0. Se mantiene Windows 10/11 en x86/x64; ARM64 no está incluido. Windows puede requerir cerrar sesión o reiniciar para que el teclado aparezca o funcione correctamente.

SmartScreen: el aviso «Windows protegió su PC», con «Editor desconocido», se ha observado al ejecutar setup.exe descargado de GitHub tanto en v0.1.0 como en v0.2.0. Los instaladores siguen sin firma digital. Si has comprobado el origen del archivo y decides continuar, pulsa «Más información» y después «Ejecutar de todas formas», si Windows ofrece esa opción. No es necesario desactivar SmartScreen ni Microsoft Defender.

## Validación

- Se superan 26 comprobaciones aisladas de identidad y contexto MSI y las 35 de preferencias existentes en Windows PowerShell 5.1 de 32 y 64 bits. Las configuraciones de Windows y operaciones MSI se simulan.
- 238 comprobaciones de metadatos, arquitecturas, nombres visibles, recursos integrados y versiones abarcan las 17 distribuciones. Las DLL de teclado y los paquetes MSI no cambian.
- Se auditan los hashes de los 18 ZIP, contenidos de carpetas, copias de documentación, enlaces locales y codificación. Las comprobaciones de solo lectura prueban la detección MSI nativa y el arranque real del instalador.
- He probado satisfactoriamente Spanish (Spain) en una cuenta recién creada: instalación, activación y desactivación del predeterminado, persistencia tras cerrar sesión o reiniciar y desinstalación. Primero retiré la instalación anterior por usuario. No he probado manualmente las otras 16 distribuciones ni todas las configuraciones de Windows; las traducciones no han recibido revisión lingüística independiente. La recompilación final añade la versión visible a la lógica probada.

Si una instalación antigua pertenece a otra cuenta, desinstálala primero desde esa cuenta original y después instala esta versión desde la cuenta deseada. Crear una cuenta nueva o abrir el instalador nuevo no migra un registro MSI por usuario ya existente. He completado esta migración y después he repetido satisfactoriamente la prueba completa en una cuenta nueva.

## Descargas

Elige `ANGLE_QUOTES_NATIVE_WINDOWS.zip` para obtener todas las distribuciones o el ZIP individual de la tuya. Extrae el ZIP completo y conserva juntos sus archivos. `SHA256SUMS.txt` contiene los hashes SHA256 de los 18 ZIP descargables.

Las descargas **Source code** ZIP/TAR.GZ de GitHub se generan por separado y no son los paquetes de instalación.
