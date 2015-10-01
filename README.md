# Q

Q ofrece la posibilidad de crear documentos modelo de los cuales los usuarios pueden rellenar instancias. Sus raíces emergen de la necesidad de evitar que los documentos de calidad se lleven en papel.

Para ello los documentos están sujetos a un sistema de control de versiones, y cada cambio, actualiza el número de revisión del documento y anota el autor que lo ha realizado.

Por otro lado los documentos se suscriben a un ámbito. El ámbito está compuesto de:

(sea un colegio)

### Respecto al trabajo:

#### Niveles: 

```yaml
colegio: 
    primaria:
    - primero_de_primaria
    - segundo_de_primaria
    secundaria:
        eso:
        - primero_de_la_eso
        - segundo_de_la_eso
    fp:
        fpb:
            primero_de_fpb: {}
            segundo_de_fpb: {}
        cfgm:
            primero_de_cfgm: {}
            segundo_de_cfgm: {}
```

#### Areas:

Cada nivel se puede dividir en areas de trabajo, por ejemplo fp en mecánica y electricidad.

### Respecto a las funciones

#### Funciones:

Las distintas funciones se pueden agrupar. Por ejemplo, profesor, orientador, pueden formar el claustro y así hasta que la agrupación de grupos forma el personal del centro.

#### Departamentos:

Igual que con los niveles, existe una transversalidad que puede atravesar las funciones. Por ejemplo, las personas que pertenecen al departamento de inglés.

### Ámbito

Finalmente, la combinación de niveles, áreas, funciones y departamentos generan un ámbito.

Así un documento puede estar restringido:

#### Ejemplos:

1. Claustro
2. Claustro de fp
3. Los tutores de primeros
4. Los tutores de primero de fp
5. Los profesores de mecánica. (Todos los que dan clase en algún ciclo del área de mecánica.)
6. El departamento de mecánica. (Todos los profesores que dan asignaturas de la familia de mecánica en algñun ciclo, sea o no de mecánica)

## Instalación

Necesita gpg


## Especificaciones

### Usuarios

Como usuario no registrado quiero tener acceso usando la cuenta de salesianosdosa.com

### Ficheros

Como administrador del sistema de calidad quiero poder subir documentos de word conteniendo los registros.


### Desarrollo

Hacer rake secrets:fold despues de modificar secrets.yml o enviroment_variables.yml
