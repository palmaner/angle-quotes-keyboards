# Comillas angulares para Windows

[Español](README.es.md) · [English](README.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Italiano](README.it.md) · [Português](README.pt.md) · [Norsk bokmål](README.nb.md) · [Dansk](README.da.md) · [Русский](README.ru.md) · [Українська](README.uk.md) · [Беларуская](README.be.md)

He creado estas 17 distribuciones nativas para escribir comillas angulares con AltGr, conservando el teclado original y sin AutoHotkey ni aplicaciones en segundo plano.

La colección incluye **15 variantes originales y dos inglesas experimentales: Estados Unidos y Reino Unido**.

**[Descargar teclados](https://github.com/palmaner/angle-quotes-keyboards/releases/latest)** · [Informar de un problema](https://github.com/palmaner/angle-quotes-keyboards/issues)

## Elige tu distribución

Elige según tu teclado habitual, no solo por nacionalidad. Los enlaces llevan a las instrucciones locales con todas las posiciones modificadas.

| Distribuciones e instrucciones | Apertura | Cierre |
| --- | --- | --- |
| [Español (España)](Spanish-Spain/README.txt), [Español (Latinoamérica)](Spanish-Latin-America/README.txt), [Italiano](Italian/README.txt), [Ruso](Russian/README.txt), [Ucraniano](Ukrainian/README.txt), [Bielorruso](Belarusian/README.txt), [Francés belga](Belgian-French/README.txt) | AltGr+5 → « | AltGr+7 → » |
| [Portugués (Portugal)](Portuguese-Portugal/README.txt), [Noruego](Norwegian/README.txt) | AltGr+5 → « | AltGr+6 → » |
| [Alemán (Alemania)](German-Germany/README.txt), [Alemán (Austria)](German-Austria/README.txt), [Danés](Danish/README.txt) | AltGr+5 → » | AltGr+6 → « |
| [Francés suizo](Swiss-French/README.txt), [Alemán suizo](Swiss-German/README.txt), [Luxemburgo con francés suizo](Luxembourg-Swiss-French/README.txt) | AltGr+5 → « | AltGr+7 → » |
| **Experimental:** [Inglés (Estados Unidos)](English-United-States/README.txt), [Inglés (Reino Unido)](English-United-Kingdom/README.txt) | AltGr+5 → « | AltGr+7 → » |

Las dos variantes inglesas sirven para probar las comillas angulares, no para proponer cambios en la puntuación inglesa. Usan los teclados estándar de Estados Unidos y Reino Unido; Alt derecho pasa a funcionar como AltGr. No son US-International ni UK Extended.

## Instalación

Windows 10/11 en equipos x86 o x64; ARM64 no está incluido. No necesitas Internet ni instalar Keyboard Layout Creator.

1. Extrae el ZIP completo y abre la carpeta de tu teclado. Mantén juntos sus archivos.
2. Ejecuta **setup.exe** y acepta los permisos de administrador.
3. Pulsa **Win+Espacio** y selecciona el nombre terminado en **“- Angle Quotes”**.
4. Prueba AltGr (Alt derecho) y la fila superior de números en el Bloc de notas.

**El instalador puede comportarse de forma irregular: a veces hay que cerrar sesión y volver a entrar para que aparezca el teclado o funcione correctamente.** Instalarlo no implica seleccionarlo. Si no aparece, añádelo desde las opciones de teclado de tu idioma en Configuración.

Si setup.exe no arranca, abre `_amd64.msi` para Windows de 64 bits o `_i386.msi` para 32 bits. Los instaladores no están firmados; Windows puede mostrar «Editor desconocido».

## Cambios de caracteres

En España, Italia, Portugal, Noruega y Dinamarca, AltGr+5 sustituye al euro; **€ sigue en AltGr+E**. En francés belga, **[ sigue disponible con AltGr y la tecla ^ junto a P**.

En las variantes suizas, **§ pasa a AltGr+8** y **la barra vertical pasa a AltGr+1**. Se sustituyen ¢ y ¦, que actualmente no tienen un nuevo atajo. Consulta las instrucciones locales antes de elegirlas.

Las demás combinaciones y los acentos comprobados se conservan. Ctrl+Alt puede producir los mismos caracteres que AltGr.

## Volver al teclado anterior o desinstalar

Usa **Win+Espacio** para volver a tu teclado original. Para desinstalar, selecciónalo primero y vuelve a ejecutar el instalador del teclado personalizado; elige **Remove**.

## Prácticas

He incluido [colecciones de práctica](practice/README.md) en los idiomas del proyecto. Las categorías se refieren a **cada párrafo**, no al archivo ni a la historia: aproximadamente 10–25 palabras en short, 25–50 en medium y 80–120 en long. Las líneas en blanco separan párrafos, que pueden continuar la misma historia. Copia uno o varios en el modo **custom** de Monkeytype. Cada ZIP individual incluye `practice/short.txt`, `practice/medium.txt`, `practice/long.txt` y un `practice.txt` combinado.

**Los textos ficticios se han generado con IA para practicar y pueden contener errores.** No son una referencia lingüística ni normativa. En inglés se emplean deliberadamente comillas angulares con fines de prueba.

## Pruebas y comentarios

He probado cinco variantes originales en mi portátil y funcionan, aunque a veces ha sido necesario cerrar sesión. No he probado manualmente las 17, incluidas las dos inglesas experimentales. Las comprobaciones automáticas cubren tablas de caracteres, acentos y nombres en x86, x64 y WOW64.

Mantengo este proyecto. Para comunicar un fallo, abre una incidencia con la versión de Windows, el teclado, el atajo, el resultado y si cerrar sesión ayudó.

Creado con [Microsoft Keyboard Layout Creator 1.4](https://www.microsoft.com/en-us/download/details.aspx?id=102134). Mi código original y mis modificaciones usan la [licencia MIT](LICENSE). Los componentes de Microsoft conservan sus condiciones; consulta los [avisos de terceros](THIRD_PARTY_NOTICES.md).

Para desarrolladores (documentación en inglés): [compilar y verificar](docs/BUILD.md) / [comentarios y contribuciones](CONTRIBUTING.md).
