-- =========================
-- Inserts de exemplo (até 5 por tabela)
-- =========================

-- clients
INSERT INTO clients (fullName, email) VALUES
('Ana Silva','ana.silva@example.com'),
('Loja Tech Ltda','contato@lojatech.com'),
('Bruno Costa','bruno.costa@example.com'),
('João Vendedor','joao.vendas@example.com'),
('Maria Compradora','maria.comp@example.com');

-- clientPF (pessoas físicas)
INSERT INTO clientPF (idClientPF, CPF, birthDate) VALUES
(1,'12345678901','1990-05-10'),
(3,'98765432100','1985-11-20'),
(5,'45612378900','1998-03-02');

-- clientPJ (pessoas jurídicas)
INSERT INTO clientPJ (idClientPJ, CNPJ, companyName) VALUES
(2,'12345678000199','Loja Tech Ltda'),
(4,'22233344000155','Vendas do João LTDA');

-- payments (múltiplos por cliente)
INSERT INTO payments (idClient, typePayment, details, limitAvailable) VALUES
(1,'Cartão','Visa termina 1234',2000.00),
(1,'PIX','ana@pix',0),
(2,'Boleto','Conta corrente Loja Tech',0),
(3,'Cartão','Master 5678',1500.00),
(5,'Cartão','Elo 4444',800.00);

-- product
INSERT INTO product (Pname, price, classification_kids, category, avaliacao, size) VALUES
('Camiseta Básica',49.90,false,'Vestimenta',4.5,'M'),
('Notebook 14"',3599.90,false,'Eletrônico',4.8,'14\"'),
('Boneca Barbie',79.90,true,'Brinquedos',4.7,'30cm'),
('Mesa de Jantar',899.00,false,'Móveis',4.3,'120x80'),
('Chocolate 100g',9.90,true,'Alimentos',4.9,'100g');

-- supplier
INSERT INTO supplier (socialName, CNPJ, contact) VALUES
('Fornecedora Alfa','11122233000155','11987654321'),
('Distribuidora Beta','22233344000166','21999887766'),
('Moveis Requinte','33344455000177','31988552233'),
('Chocolates Delicia','44455566000188','47999887744'),
('Brinquedos Alegria','55566677000122','41988776655');

-- seller
INSERT INTO seller (socialName, CNPJ, CPF, location, contact) VALUES
('Loja da Maria',NULL,'77788899900','SP','11999998888'),
('TechHouse','11122233000144',NULL,'RJ','21999997777'),
('MoveisTop','33344455000177',NULL,'MG','31988886666'),
('DoceSabor',NULL,'66655544433','RS','51988776655'),
('BrinqKids','55566677000122',NULL,'PR','41999995555');

-- productStorage (depósitos)
INSERT INTO productStorage (storageLocation, info) VALUES
('Galpão 1 - SP','Capacidade A'),
('Galpão 2 - RJ','Capacidade B'),
('Depósito Central - MG','Capacidade C'),
('Galpão 3 - PR','Capacidade D'),
('Galpão 4 - RS','Capacidade E');

-- storageLocation (ligação produto <-> estoque)
INSERT INTO storageLocation (idLproduct, idLstorage, quantity) VALUES
(1,1,100),
(2,2,25),
(3,3,300),
(4,4,10),
(5,5,500);

-- productSupplier (fornecimento)
INSERT INTO productSupplier (idPsSupplier, idPsProduct, price_from_supplier, lead_time_days) VALUES
(1,1,20.00,7),
(2,2,2800.00,14),
(5,3,40.00,5),
(3,4,400.00,21),
(4,5,3.50,2);

-- productSeller (quem vende o produto)
INSERT INTO productSeller (idPseller, idPproduct, prodQuantity) VALUES
(1,1,50),
(2,2,30),
(5,3,70),
(3,4,25),
(4,5,90);

-- orders
INSERT INTO orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) VALUES
(1,'Confirmado','Compra 2 camisetas',15.00,TRUE),
(3,'Em processamento','Compra notebook',25.00,FALSE),
(5,'Confirmado','Boneca + chocolate',12.00,TRUE),
(1,'Cancelado','Teste cancelado',0.00,FALSE),
(2,'Confirmado','Pedido institucional',40.00,FALSE);

-- productOrder (itens do pedido)
INSERT INTO productOrder (idPOproduct, idPOorder, poQuantity, poUnitPrice, poStatus) VALUES
(1,1,2,49.90,'Disponível'),
(2,2,1,3599.90,'Disponível'),
(3,3,1,79.90,'Disponível'),
(5,3,2,9.90,'Disponível'),
(1,5,10,49.90,'Disponível');

-- delivery (rastreamento)
INSERT INTO delivery (idOrder, trackingCode, deliveryStatus, estimatedDate, deliveryDate) VALUES
(1,'TRK123456BR','Em trânsito','2025-11-10',NULL),
(2,NULL,'Em separação',NULL,NULL),
(3,'TRK654321BR','Entregue',NULL,'2025-10-28'),
(5,'TRK999888BR','Enviado','2025-11-12',NULL),
(4,NULL,'Devolvido',NULL,'2025-10-01');
