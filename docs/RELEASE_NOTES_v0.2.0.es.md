# v0.2.0 — Selección del teclado predeterminado

[Español](RELEASE_NOTES_v0.2.0.es.md) · [English](RELEASE_NOTES_v0.2.0.md) · [Français](RELEASE_NOTES_v0.2.0.fr.md) · [Deutsch](RELEASE_NOTES_v0.2.0.de.md) · [Italiano](RELEASE_NOTES_v0.2.0.it.md) · [Português](RELEASE_NOTES_v0.2.0.pt.md) · [Norsk bokmål](RELEASE_NOTES_v0.2.0.nb.md) · [Dansk](RELEASE_NOTES_v0.2.0.da.md) · [Русский](RELEASE_NOTES_v0.2.0.ru.md) · [Українська](RELEASE_NOTES_v0.2.0.uk.md) · [Беларуская](RELEASE_NOTES_v0.2.0.be.md)

## Nuevo instalador

- Las 17 distribuciones incluyen ahora una ventana de instalación con la casilla opcional **Usar como teclado predeterminado para mi cuenta**. Márcala e instala o aplica el cambio para guardar la preferencia de entrada predeterminada de Windows.
- Vuelve a abrir `setup.exe`, desmarca la casilla y pulsa **Aplicar** para recuperar la preferencia anterior manteniendo el teclado instalado. Si el teclado anterior ya no está disponible, el instalador pide elegir otro método de entrada disponible.
- La casilla refleja la preferencia actual de Windows. Se conservan los demás idiomas y teclados, y activar varias veces no sustituye el registro de recuperación original por la misma distribución.
- **Desinstalar** restaura primero el predeterminado anterior cuando corresponde y después elimina la distribución. La desinstalación directa mediante MSI o Aplicaciones de Windows omite este paso adicional de restauración.
- La interfaz sigue el idioma de Windows: español, inglés, francés, alemán, italiano, portugués, noruego bokmål, danés, ruso, ucraniano y bielorruso, con inglés como alternativa.
- Abre `setup.exe` normalmente, sin **Ejecutar como administrador**. Solo las operaciones MSI solicitan elevación; las preferencias de entrada se aplican a la cuenta que abrió el instalador. No se instala ninguna aplicación en segundo plano ni tarea programada.

## Fiabilidad y documentación

- El instalador evita consultas innecesarias de preferencias al arrancar. Si la consulta del predeterminado de Windows lanza una excepción genérica, consulta la preferencia almacenada en modo de solo lectura. Los errores de acceso y los valores mal formados siguen notificándose como errores.
- Los errores de configuración muestran el comando y la ubicación en el script y guardan un archivo de diagnóstico local en `%LOCALAPPDATA%\AngleQuotes\logs`. Los registros no se envían automáticamente.
- Se han actualizado las instrucciones de instalación, restauración y desinstalación en los 11 idiomas de los README y las carpetas de las 17 distribuciones. Se incluyen las fuentes de compilación, las traducciones y las pruebas aisladas de preferencias.

## Compatibilidad y advertencias

Las DLL de teclado, los paquetes MSI, las asignaciones de caracteres y los textos de práctica no cambian respecto a v0.1.0. Se mantiene Windows 10/11 en x86/x64; ARM64 no está incluido. Windows puede requerir cerrar sesión o reiniciar para que el teclado aparezca o funcione correctamente.

SmartScreen: el aviso «Windows protegió su PC», con «Editor desconocido», se ha observado al ejecutar setup.exe descargado de GitHub tanto en v0.1.0 como en v0.2.0. Los instaladores siguen sin firma digital. Si has comprobado el origen del archivo y decides continuar, pulsa «Más información» y después «Ejecutar de todas formas», si Windows ofrece esa opción. No es necesario desactivar SmartScreen ni Microsoft Defender.

## Validación

- Se superan 35 comprobaciones aisladas de preferencias tanto en Windows PowerShell 5.1 de 32 bits como de 64 bits, usando configuraciones de Windows y entradas de registro simuladas.
- Se superan 204 comprobaciones de metadatos de instaladores, arquitecturas, nombres visibles y recursos integrados. Los informes de tablas de caracteres abarcan las 17 distribuciones, con 11 016 comparaciones de caracteres en cada una de las arquitecturas x86, x64 y WOW64, además de comprobaciones de teclas muertas.
- Las auditorías de paquetes comprueban los hashes de los 18 ZIP, los contenidos de las carpetas individuales, las copias de los README, los enlaces locales y la codificación. También se comprobó el arranque real del instalador en modo de solo lectura con PowerShell de 32 y 64 bits.
- El usuario comunica una prueba manual global satisfactoria de la candidata corregida **Spanish (Spain) - Angle Quotes** en Windows Home x64, versión indicada 26H2, compilación 26300.9818. Los casos individuales no se registraron por separado. Esto no acredita cobertura manual de las otras 16 distribuciones ni de todas las versiones de Windows compatibles. Las nuevas traducciones no han recibido revisión lingüística independiente.

Prueba adicional de compatibilidad comunicada por el usuario: con una distribución de v0.1.0 ya instalada, el instalador de v0.2.0 reconoció correctamente la instalación existente y permitió establecerla como teclado predeterminado. Esto verifica ese caso en el equipo probado, sin acreditar una desinstalación y reinstalación completas ni cobertura de todas las distribuciones.

## Descargas

Elige `ANGLE_QUOTES_NATIVE_WINDOWS.zip` para obtener todas las distribuciones o el ZIP individual de la tuya. Extrae el ZIP completo y conserva juntos sus archivos. `SHA256SUMS.txt` contiene los hashes SHA256 de los 18 ZIP descargables.

Las descargas **Source code** ZIP/TAR.GZ de GitHub se generan por separado y no son los paquetes de instalación.
