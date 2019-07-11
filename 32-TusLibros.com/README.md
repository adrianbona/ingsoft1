TusLibros.Com
=============

El presente repo divide los contenidos completos del proyecto en tres partes: Modelo, Tests y Client-Server.

Modelo contiene todo lo necesario para hacer funcionar el backend del sistema. Todos los modelos fueron escritos mediante TDD.

Tests contiene un todos los tests que fueron hechos durante la etapa de TDD para construir cada modelo. También se encuentra un store que contiene objetos de prueba que fueron necesarios y comunes a la mayoría de los modelos.

Client-Server contiene toda la lógica necesaria para la cuarta etapa del proyecto. Permite levantar un servidor que tiene todos los servicios que conforman la interfaz del sistema. A su vez se encuentra el cliente, la aplicación que consume dichos servicios y proporciona una interfaz gráfica al usuario para realizar pruebas.

Para acceder al cliente hay que activar el servidor mediante:

"TLServer new"

Para iniciar el cliente alcanza con llamar al login mediante:

"TLLoginWindow open"

El cliente es una experiencia autocontenida. Una vez que el cliente accede con sus datos de login puede ver el Dashboard. El mismo le permite acceder a un nuevo carrito o bien visualizar un reporte con sumariza todas las compras que lleva hechas.

Si se accede a la creación del carrito, será posible seleccionar de una lista el producto de su interés e ingresar manualmente o mediante los controles la cantidad de ítems de dicho producto que desea agregar. Una vez resuelto esto puede proceder al pago.

Para el pago alcanza con ingresar todos los datos de que solicitan a continuación y una vez que se paga se accede automáticamente al reporte al que también puede accederse desde el dashboard.