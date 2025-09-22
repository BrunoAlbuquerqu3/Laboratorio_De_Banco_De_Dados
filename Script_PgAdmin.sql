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
--('10/03/2025','Aguardando',2),
('10/03/2025','Aguardando',3),
('10/03/2025','Aguardando',4),
('05/02/2025','Aguardando',1),
('02/02/2025','Aguardando',5)

select * from pedidos

--CADASTRANDO ITENS PEDIDOS
INSERT INTO item_pedido(pedido_id,produto_id,quantidade,preco_total_item) VALUES
(2,3,10,(10*250)),
(2,1,5,(5*2590)),
(3,3,3,(3*250)),
(4,5,1,(1*4502)),
(1,4,11,(11*100)),
(2,2,1,(1*3000))

select * from item_pedido

/********************************************************************************
* SEÇÃO 3: CRIAÇÃO DE VIEWS
********************************************************************************/

--CRIANDO v_pedidos_com_detalhes

CREATE VIEW v_pedidos_com_detalhes AS
SELECT 	c.nome_cliente,
		pe.data_pedido,
		pe.status_pedido,
		p.nome_produto,
		ip.quantidade,
		ip.preco_total_item
FROM item_pedido ip
INNER JOIN
pedidos pe on pe.id_pedido = ip.pedido_id
INNER JOIN
cliente c on c.id_cliente = pe.cliente_id
INNER JOIN
produto p on p.id_produto = ip.produto_id
;

SELECT * FROM v_pedidos_com_detalhes

--FINALIZANDO v_pedidos_com_detalhes

--CRIANDO v_estoque_baixo
CREATE VIEW v_estoque_baixo AS
SELECT 	nome_produto,
		estoque
FROM produto 
WHERE estoque < 10;

SELECT * FROM v_estoque_baixo;

--FINALIZANDO v_estoque_baixo

--CRIANDO v_produtos_mais_vendidos
	
SELECT nome_produto,sum(quantidade) AS "quantidade"
FROM v_pedidos_com_detalhes
GROUP BY nome_produto
ORDER BY quantidade DESC;

--FINALIZANDO v_produtos_mais_vendidos

--CRIANDO fn_calcular_total_pedido
CREATE OR REPLACE FUNCTION fn_calcular_total_pedido(id_pedido INTEGER) AS
$$ DECLARE
	BEGIN
		SELECT SUM(preco_total_item) AS "Valor total" 
		from item_pedido
		group by pedido_id
	END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_calcular_total_pedido(p_pedido_id INTEGER)
RETURNS DECIMAL AS
$$
DECLARE
    valor_total DECIMAL;
BEGIN
    SELECT SUM(preco_total_item) INTO valor_total
    FROM item_pedido
    WHERE pedido_id = p_pedido_id;

    RETURN valor_total;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION  fn_atualizar_estoque()
	RETURNS TRIGGER AS 
	$$
		BEGIN
			UPDATE produto 
				SET estoque = estoque - NEW.quantidade
				WHERE id_produto = NEW.produto_id;
			RETURN NEW;
		END;
	$$ LANGUAGE plpgsql;
	
	CREATE OR REPLACE TRIGGER trg_atualizar_estoque
	AFTER INSERT ON item_pedido
	FOR EACH ROW
	EXECUTE FUNCTION fn_atualizar_estoque();
	
	
	INSERT INTO item_pedido(pedido_id,produto_id,quantidade,preco_total_item) VALUES
	(4,4,10,(10*250));

	
	


