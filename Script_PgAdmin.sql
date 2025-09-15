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
 
 
/********************************************************************************
* SEÇÃO 2: DML (Data Manipulation Language) - INSERÇÃO DE DADOS
********************************************************************************/

--CADASTRANDO CLIENTES

insert into cliente (nome_cliente,email,telefone,endereco,cidade,uf) VALUES
('Bruno','brunoloko@gmail.com','15 997325456','rua cabritinho','Itapetininga','SP'),
('Ricardo','noloko@gmail.com','15 991125456','rua cabrinho','Itapetininga','SP'),
('Matheus','Matheus@gmail.com','15 991555456','rua higor','tatui','SP'),
('Hercules','Hercules@gmail.com','15 95565456','rua pedrada','Itapetininga','SP'),
('Beatriz','bia@gmail.com','15 15 958854787','rua cabrinho','Itapetininga','SP')

SELECT * FROM cliente

--CADASTRANDO PRODUTOS
--TRUNCATE É RESPONSAVEL POR LIMPAR INSERTS DE UMA TABELA E ZERALA

truncate table produto RESTART IDENTITY CASCADE

INSERT INTO produto(nome_produto,descricao,preco_unitario,estoque)values
('Notebook','250GB',2590.00,15),
('Iphone','500GB',3000.00,5),
('Mouse','Rápido de mais',250.00,30),
('Mouse Pad','Mouse Pad cobre sua mesa',100.00,40),
('Monitor 4k','Resolução de altissima qualidade',4502.00,3)

SELECT * FROM produto;


--CADASTRANDO PEDIDO
INSERT INTO pedidos(data_pedido,status_pedido,cliente_id) VALUES
('10/02/2025','Aguardando',2)


select * from pedidos




