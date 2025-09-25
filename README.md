# Plantilla de Currículum Vitae (Typst)

## Requisitos

Para usar y compilar, necesitas tener instalados los siguientes componentes:

| Herramienta   | Descripción                                                            | Comandos para compilar                  |
| :------------ | :--------------------------------------------------------------------- | :-------------------------------------- |
| **Typst**     | El compilador principal.                                               | `typst compile <typ file> <output>`     |
| **watchexec** | **(Opcional)**. Usado por `compile.sh` para la compilación automática. | `chmod +x ./compile.sh ** ./compile.sh` |

## Modo de uso
Basta con editar `src/data/yml` para actualizar los datos.
Si se desea colocar una foto es necesario colocalarla en `src/images/` y colocar su nombre en `src/data/yml`.

```yaml
# src/data/data.yml
persona:
  picture: <archivo> # src/images/<archivo> debe existir.
```
