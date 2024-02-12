# entidadesBancarias
Repositorio para el ejercicio de entidadesBancarias de MySQL

## -Enunciado-
Crear la base de datos **entidadesBancarias**. Un **banco debe tener como minimo mas de un cliente y los clientes tendrán mínimo un banco o varios como máximo**, De los bancos interesa guardar el id, nombre, la ciudad de la sucursal central, el numero de clientes que tiene y si tiene sucursales físicas o no.
Cada cliente tiene un id, un nombre, un apellido, una edad y un estado que puede ser; dado de alta o de baja. A parte de esto, **interesará guardar la fecha de alta de cada cliente y la fecha de baja** en caso de que exista.
Los **clientes podrán pedir como mucho un préstamo pero estos pueden ser pedidos por varios clientes** que sean titulares de la mima cuenta.
De los prestamos interesará guardar el id, el dia limite del plazo para pagar dicho préstamo, la cantidad y el id del cliente que solicite dicho préstamo.
Cada **cliente tiene que abrir una cuenta aunque podrá abrir varias, mientras que las cuentas pueden ser abiertas por varios clientes** ya que mas de un cliente puede ser titular de una misma cuenta. De las cuentas guardaremos el código de cuenta, la cantidad de la que dispondrá la cuenta, si la cuenta tiene tarjeta física o no y el PIN de la tarjeta en caso de que esta exista.
**Los clientes pueden realizar transacciones desde sus cuentas**, de las que interesa guardar el id, el tipo de transacción(pudiendo ser solamente transacciones de *prestamos, activos, intereses o alquiler*) y la cantidad de la transacción. Además interesa guardar la **fecha en la que se realiza dicha transacción**.

### Resultado en diseñador phpMyAdmin
![Captura de pantalla 2024-02-12 172609](https://github.com/E7OY/entidadesBancarias/assets/102689282/8626a494-69d8-4f83-8212-adab1a3a0c15)
