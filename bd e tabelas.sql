CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- clients
CREATE TABLE clients (
  idClient INT AUTO_INCREMENT PRIMARY KEY,
  fullName VARCHAR(100) NOT NULL,
  email VARCHAR(150),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- clientPF e clientPJ
CREATE TABLE clientPF (
  idClientPF INT PRIMARY KEY,
  CPF CHAR(11) NOT NULL UNIQUE,
  birthDate DATE,
  FOREIGN KEY (idClientPF) REFERENCES clients(idClient) ON DELETE CASCADE
);

CREATE TABLE clientPJ (
  idClientPJ INT PRIMARY KEY,
  CNPJ CHAR(14) NOT NULL UNIQUE,
  companyName VARCHAR(255) NOT NULL,
  stateRegistration VARCHAR(50),
  FOREIGN KEY (idClientPJ) REFERENCES clients(idClient) ON DELETE CASCADE
);

-- Pagamentos
CREATE TABLE payments (
  idPayment INT AUTO_INCREMENT PRIMARY KEY,
  idClient INT NOT NULL,
  typePayment ENUM('Boleto','Cartão','PIX','Dois cartões') NOT NULL,
  details VARCHAR(255),
  limitAvailable DECIMAL(12,2) DEFAULT 0,
  active BOOLEAN DEFAULT TRUE,
  FOREIGN KEY (idClient) REFERENCES clients(idClient) ON DELETE CASCADE
);

-- Produtos 
CREATE TABLE product (
  idProduct INT AUTO_INCREMENT PRIMARY KEY,
  Pname VARCHAR(100) NOT NULL,
  price DECIMAL(12,2) NOT NULL DEFAULT 0,
  classification_kids BOOLEAN DEFAULT FALSE,
  category ENUM('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') NOT NULL,
  avaliacao FLOAT DEFAULT 0,
  size VARCHAR(20)
);

-- Fornecedores
CREATE TABLE supplier (
  idSupplier INT AUTO_INCREMENT PRIMARY KEY,
  socialName VARCHAR(255) NOT NULL,
  CNPJ CHAR(14) NOT NULL UNIQUE,
  contact VARCHAR(20)
);

-- Vendedores
CREATE TABLE seller (
  idSeller INT AUTO_INCREMENT PRIMARY KEY,
  socialName VARCHAR(255) NOT NULL,
  CNPJ CHAR(14),
  CPF CHAR(11),
  location VARCHAR(255),
  contact VARCHAR(20),
  UNIQUE (CNPJ),
  UNIQUE (CPF)
);

--  Pedido (orders) 
CREATE TABLE orders (
  idOrder INT AUTO_INCREMENT PRIMARY KEY,
  idOrderClient INT NOT NULL,
  orderStatus ENUM('Cancelado','Confirmado','Em processamento') DEFAULT 'Em processamento',
  orderDescription VARCHAR(255),
  sendValue DECIMAL(10,2) DEFAULT 10,
  paymentCash BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (idOrderClient) REFERENCES clients(idClient) ON DELETE RESTRICT ON UPDATE CASCADE
);

--  Entrega (delivery)
CREATE TABLE delivery (
  idDelivery INT AUTO_INCREMENT PRIMARY KEY,
  idOrder INT NOT NULL UNIQUE,
  trackingCode VARCHAR(100),
  deliveryStatus ENUM('Em separação','Enviado','Em trânsito','Entregue','Devolvido') DEFAULT 'Em separação',
  estimatedDate DATE,
  deliveryDate DATE,
  FOREIGN KEY (idOrder) REFERENCES orders(idOrder) ON DELETE CASCADE
);

--  Estoque: depósitos/galpões 
CREATE TABLE productStorage (
  idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
  storageLocation VARCHAR(255),
  -- total capacity/infos podem ser adicionadas
  info VARCHAR(255)
);

--  Localização do produto no estoque 
CREATE TABLE storageLocation (
  idLproduct INT,
  idLstorage INT,
  quantity INT DEFAULT 0 CHECK (quantity >= 0),
  PRIMARY KEY (idLproduct, idLstorage),
  FOREIGN KEY (idLproduct) REFERENCES product(idProduct) ON DELETE CASCADE,
  FOREIGN KEY (idLstorage) REFERENCES productStorage(idProdStorage) ON DELETE CASCADE
);

--  Relação produto
CREATE TABLE productSupplier (
  idPsSupplier INT,
  idPsProduct INT,
  price_from_supplier DECIMAL(12,2),
  lead_time_days INT DEFAULT 0,
  PRIMARY KEY (idPsSupplier, idPsProduct),
  FOREIGN KEY (idPsSupplier) REFERENCES supplier(idSupplier) ON DELETE CASCADE,
  FOREIGN KEY (idPsProduct) REFERENCES product(idProduct) ON DELETE CASCADE
);

--  Relação produto 
CREATE TABLE productSeller (
  idPseller INT,
  idPproduct INT,
  prodQuantity INT DEFAULT 0,
  PRIMARY KEY (idPseller, idPproduct),
  FOREIGN KEY (idPseller) REFERENCES seller(idSeller) ON DELETE CASCADE,
  FOREIGN KEY (idPproduct) REFERENCES product(idProduct) ON DELETE CASCADE
);

--  Relação pedido
CREATE TABLE productOrder (
  idPOproduct INT,
  idPOorder INT,
  poQuantity INT DEFAULT 1 CHECK (poQuantity > 0),
  poUnitPrice DECIMAL(12,2) NOT NULL,
  poStatus ENUM('Disponível','Sem estoque') DEFAULT 'Disponível',
  PRIMARY KEY (idPOproduct, idPOorder),
  FOREIGN KEY (idPOproduct) REFERENCES product(idProduct) ON DELETE CASCADE,
  FOREIGN KEY (idPOorder) REFERENCES orders(idOrder) ON DELETE CASCADE
);





    
	