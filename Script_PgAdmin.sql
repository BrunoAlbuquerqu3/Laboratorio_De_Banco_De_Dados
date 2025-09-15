CREATE TABLE IF NOT EXISTS cliente(
    cliente_id SERIAL PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL
);

CREATE TABLE IF NOT EXISTS pedidos(
    id_pedido SERIAL PRIMARY KEY,
    data_pedido DATE NOT NULL,
    status_pedido VARCHAR(10),
    cliente_id INTEGER,
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
    );

 CREATE TABLE IF NOT EXISTS produto(
     id_produto SERIAL PRIMARY KEY,
     nome_produto VARCHAR(100) NOT NULL,
     descricao varchar(100),
     preco_unitario DECIMAL(10,2) NOT NULL,
     estoque INTEGER
 );
    
 CREATE TABLE IF NOT EXISTS item_pedido(
	id_item SERIAL PRIMARY KEY,
    pedido_id INTEGER NOT NULL,
    produto_id INTEGER,
    quantidade INTEGER,
    preco_total_item DECIMAL(10,2),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (produto_id) REFERENCES produto(id_produto)
 );
 

     
