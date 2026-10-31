# LegadoSeguro

**Plataforma de Gestión de Legado y Testamento Digital**

LegadoSeguro es una aplicación web que permite a una persona registrar sus activos digitales, designar a sus beneficiarios y definir las condiciones bajo las cuales esa información será liberada cuando ya no pueda gestionarla. La plataforma verifica la actividad del propietario, coordina el proceso de liberación con notificaciones y confirmaciones, y mantiene un registro de auditoría de cada acción.

> LegadoSeguro no ejecuta operaciones financieras ni entrega credenciales bancarias. Para activos financieros genera un **Paquete de Orientación Legal** que indica al beneficiario el procedimiento a seguir ante las entidades competentes.

---

## Información académica

| | |
|---|---|
| **Universidad** | Universidad Tecnológica del Perú (UTP) |
| **Carrera** | Ingeniería de Sistemas e Informática |
| **Curso** | Curso Integrador I: Sistemas - Software |
| **Docente** | Dr. Johan Max Alexander Lopez Heredia |
| **Período** | 2026-II |

### Integrantes

| Integrante | GitHub |
|---|---|
| Angeles Méndez, Kiara Delina | [@aakiaradelina-boop](https://github.com/aakiaradelina-boop) |
| Pardo Acosta, Katheryn Stephany | [@KatherynPardo](https://github.com/KatherynPardo) |

---

## Módulos del sistema

| Módulo | Propósito |
|---|---|
| **M1.** Autenticación, Roles y Verificación de Identidad | Gestionar el acceso y la verificación de identidad |
| **M2.** Gestión de Activos Digitales | Registrar, clasificar y administrar activos digitales |
| **M3.** Gestión de Herederos y Validador Externo | Designar beneficiarios y un validador externo |
| **M4.** Reglas de Liberación y Monitoreo de Inactividad | Establecer condiciones de liberación y verificar la actividad del propietario |
| **M5.** Proceso de Liberación (Orquestación BPM) | Coordinar las etapas del proceso de liberación |
| **M6.** Orientación Legal | Generar orientación para procedimientos con activos financieros |
| **M7.** Notificaciones | Comunicar las acciones y cambios relevantes del proceso |
| **M8.** Auditoría y Reportes | Registrar acciones y brindar información administrativa |
| **M9.** Suscripciones y Pagos | Gestionar planes y pagos dentro del alcance académico |
| **M10.** Administración y Gestión de Disputas | Gestionar tareas administrativas, objeciones y reportes |

---

## Tecnologías

| Capa | Tecnología |
|---|---|
| Lógica de aplicación | Java, Servlets, JSP |
| Acceso a datos | Patrón DAO, JDBC |
| Base de datos | SQL Server |
| Interfaz | HTML5, CSS3, JavaScript, Bootstrap |
| Dependencias y pruebas | Maven, JUnit |
| Control de versiones | Git y GitHub |

La aplicación sigue el patrón de arquitectura **Modelo-Vista-Controlador (MVC)**.

---

## Estructura del repositorio

```
LegadoSeguro/
├── README.md
├── docs/
│   ├── U1-planificacion/
│   │   ├── Modelo-Canvas/                      → Lean Canvas
│   │   ├── Req.-Funcionales-y-no-funcionales/  → Requerimientos por módulo
│   │   └── PMBOK/                              → Informe de gestión y Diagrama de Gantt
│   ├── U2-diseno/
│   │   ├── BPM/                                → Diagramas BPMN
│   │   ├── Base-de-Datos/                      → MER, modelo relacional y script SQL
│   │   └── UX-UI/                              → Boceto y prototipos en Figma
│   └── U3-arquitectura/
│       └── diagrama-mvc.pdf                    → Arquitectura MVC
└── src/
    └── main/java/
        ├── model/        → Entidades del sistema
        ├── view/         → Componentes de presentación
        ├── controller/   → Controladores y Servlets
        └── dao/          → Acceso a datos (SQL Server)
```

Para más detalle de la documentación, ver [docs/README.md](docs/README.md).
