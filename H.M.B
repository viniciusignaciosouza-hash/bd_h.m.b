-- Tabela de Clientes/Usuários
CREATE TABLE cliente (
  id_cliente SERIAL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  cpf VARCHAR(14) UNIQUE NOT NULL,
  telefone VARCHAR(15)
);

-- Tabela de Fornecedores
CREATE TABLE fornecedor (
  id_fornecedor SERIAL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  contato VARCHAR(255),
  cnpj VARCHAR(18) UNIQUE NOT NULL
);

-- Tabela de Produtos
CREATE TABLE produto (
  id_produto SERIAL PRIMARY KEY,
  id_fornecedor INT REFERENCES fornecedor(id_fornecedor),
  nome VARCHAR(255) NOT NULL,
  marca VARCHAR(50),
  preco DECIMAL(10,2) NOT NULL
);

-- Tabela de Avaliações dos Produtos
CREATE TABLE avaliacao (
  id_avaliacao SERIAL PRIMARY KEY,
  id_produto INT REFERENCES produto(id_produto) ON DELETE CASCADE,
  id_cliente INT REFERENCES cliente(id_cliente),
  nota DECIMAL(2,1) CHECK (nota >= 0 AND nota <= 5),
  comentario VARCHAR(255)
);

-- Tabela de Compras/Pedidos
CREATE TABLE compra (
  id_compra SERIAL PRIMARY KEY,
  id_cliente INT REFERENCES cliente(id_cliente),
  data_compra TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(50) DEFAULT 'Pendente'
);

-- Tabela Item da Compra (Relacionamento N:N entre Compra e Produto)
CREATE TABLE compra_produto (
  id_compra_produto SERIAL PRIMARY KEY,
  id_compra INT REFERENCES compra(id_compra) ON DELETE CASCADE,
  id_produto INT REFERENCES produto(id_produto),
  quantidade INT NOT NULL CHECK (quantidade > 0),
  preco_unitario DECIMAL(10,2) NOT NULL
);

-- Tabela de Pagamento
CREATE TABLE pagamento (
  id_pagamento SERIAL PRIMARY KEY,
  id_compra INT UNIQUE REFERENCES compra(id_compra),
  forma_pagamento VARCHAR(50) NOT NULL,
  taxa_entrega DECIMAL(10,2) DEFAULT 0.00,
  valor_total DECIMAL(10,2) NOT NULL,
  data_pagamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Carrinho de Compras (Itens temporários)
CREATE TABLE carrinho (
  id_carrinho SERIAL PRIMARY KEY,
  id_cliente INT REFERENCES cliente(id_cliente),
  id_produto INT REFERENCES produto(id_produto),
  quantidade INT NOT NULL CHECK (quantidade > 0)
);
