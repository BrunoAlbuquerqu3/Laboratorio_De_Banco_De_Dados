CREATE TABLE cliente(
    cliente_id INTEGER AUTO_INCREMENT PRIMARY KEY,
	nome_cliente VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(100) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    UF CHAR(2)
)ENGINE INNODB;

CREATE TABLE pedidos(
    id_pedido INTEGER AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATE NOT NULL,
    status_pedido VARCHAR(10),
    cliente_id INTEGER,
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
    )ENGINE INNODB;
    
 CREATE TABLE item_pedido(
	id_item INTEGER AUTO_INCREMENT PRIMARY KEY,
    pedido_id INTEGER NOT NULL,
    produto_id INTEGER,
    quantidade INTEGER,
    preco_total_item FLOAT(10.2),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (produto_id) REFERENCES produto(id_produto)
 )ENGINE INNODB;
     
 CREATE TABLE produto(
     id_produto INTEGER AUTO_INCREMENT PRIMARY KEY,
     nome_produto VARCHAR(100),
     descricao varchar(100),
     preco_unitario FLOAT(10.2),
     estoque INTEGER
 )ENGINE INNODB;
     
