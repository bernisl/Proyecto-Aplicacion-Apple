# EmpresaFlow — Proyecto unificado para Xcode

UCAM · Aplicaciones para Dispositivos Móviles: iOS · Entregable parcial 1

## Abrir sin crear ningún proyecto nuevo

1. Descomprime **EmpresaFlow_Unificado_Xcode.zip** en tu Mac.
2. En Finder, abre la carpeta **EmpresaFlow_Unificado** y haz doble clic en **EmpresaFlow.xcodeproj** (está junto a este README).
3. En Xcode, selecciona el esquema **EmpresaFlow** y un simulador de iPhone con iOS 17 o posterior.
4. Ejecuta con **⌘R**. Para pruebas automatizadas usa **⌘U**.

**No crees otra aplicación ni arrastres archivos uno a uno.** El proyecto `.xcodeproj` ya contiene las referencias, los targets y el JSON como recurso de la app.

## Fuentes integradas

- **Persona 1:** `EmpresaFlow/Models/Project.swift`, `ProjectNote.swift` y `EmpresaFlow/Resources/projects.json`. Son las versiones más recientes subidas por el equipo, sin renombrar propiedades.
- **Persona 2:** los cinco archivos de `EmpresaFlow/Views/`: lista, fila, detalle, acerca de e imagen. Se han conservado de la última versión entregada.
- **Integración provisional:** `EmpresaFlow/EmpresaFlowApp.swift`, `ContentView.swift` y `EmpresaFlow/Data/ProjectDataLoader.swift` conectan la lectura del JSON local con `ProjectListView(projects: projects)`.
- **Pruebas de referencia:** `EmpresaFlowTests/JSONLoaderTests.swift` incorpora tres tests Swift Testing; la Persona 3 puede revisar, ampliar o sustituir ese trabajo.

## Estado del dataset

10 proyectos (5 en curso) y 30 actuaciones; los datos y enlaces de Unsplash se conservan tal como los proporcionó Persona 1. Se utilizan fotos remotas con respaldo visual si no cargan. Las pruebas de modelos/JSON no requieren red.

## Cómo se conectan

`EmpresaFlowApp` → `ContentView` → `ProjectDataLoader.loadProjects()` → `[Project]` → `ProjectListView(projects:)` → `ProjectRowView` y `ProjectDetailView`.

## Antes de entregar

- Abre `EmpresaFlow/Views/AboutDetailView.swift` y sustituye los tres nombres de ejemplo por los nombres reales.
- Compila con ⌘B y ejecuta con ⌘R en un iPhone simulado.
- Ejecuta ⌘U y revisa que pasen las tres pruebas. **Todavía no han podido ejecutarse con Xcode aquí.**
- Prepara capturas de la app y de las pruebas para el README y añade el profesor al repositorio GitHub privado.
- Indica cuáles pruebas se redactaron antes de utilizar IA, solo si realmente ocurrió.
- Crea y publica la etiqueta `e1` únicamente cuando esté integrado y comprobado.

## Sobre el nombre y el esquema

Este proyecto se llama **EmpresaFlow** de principio a fin: carpeta, archivo `.xcodeproj`, target, app y módulo Swift. No mantiene el antiguo nombre GestorEmpresas.

## Verificación del paquete

El archivo `.pbxproj` se ha validado como sintaxis OpenStep; los modelos Swift 6 y el JSON se han probado con el decodificador de Swift en Linux. Los archivos de interfaz solo se han podido analizar sintácticamente porque **Xcode/iOS SDK no está instalado en este entorno**. No se afirma que una compilación ni los tests de iOS hayan pasado hasta que los ejecutéis en el Mac.
