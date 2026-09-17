CREATE TABLE clientes (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    cpf VARCHAR(14) UNIQUE NOT NULL
);

CREATE TABLE endereco (
    id_endereco BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    logradouro VARCHAR(255) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cep VARCHAR(9) NOT NULL,
    id_cliente BIGINT NOT NULL,

    CONSTRAINT fk_endereco_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);

CREATE TABLE categoria (
    id_categoria BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

CREATE TABLE fornecedor (
    id_fornecedor BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    contato VARCHAR(255)
);

CREATE TABLE produto (
    id_produto BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    marca VARCHAR(255) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    nota_avaliacao DECIMAL(10, 2) NOT NULL,
    id_categoria BIGINT NOT NULL,
    id_fornecedor BIGINT NOT NULL,

    CONSTRAINT fk_produto_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
    CONSTRAINT fk_produto_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
);

CREATE TABLE estoque (
    id_estoque BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    quantidade INT,
    id_produto BIGINT NOT NULL,

    CONSTRAINT fk_estoque_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE carrinho (
    id_carrinho BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    id_cliente BIGINT NOT NULL,
    id_produto BIGINT NOT NULL,

    CONSTRAINT fk_carrinho_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id),
    CONSTRAINT fk_carrinho_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE compra (
    id_compra BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_compra TIMESTAMP,
    valor_total DECIMAL(10, 2) NOT NULL,
    id_cliente BIGINT NOT NULL,
    id_endereco BIGINT NOT NULL,

    CONSTRAINT fk_compra_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id),
    CONSTRAINT fk_compra_endereco FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco)
);

CREATE TABLE compra_produto (
    id_compra_produto BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10, 2) NOT NULL,
    id_compra BIGINT NOT NULL,
    id_produto BIGINT NOT NULL,

    CONSTRAINT fk_compra_produto_compra FOREIGN KEY (id_compra) REFERENCES compra(id_compra),
    CONSTRAINT fk_compra_produto_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE pagamento (
    id_pagamento BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    forma_pagamento VARCHAR(50) NOT NULL,
    valor_pago DECIMAL(10, 2) NOT NULL,
    status_pagamento VARCHAR(50) NOT NULL,
    id_compra BIGINT NOT NULL,

    CONSTRAINT fk_pagamento_compra FOREIGN KEY (id_compra) REFERENCES compra(id_compra)
);