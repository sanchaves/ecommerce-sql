use ecommerce;

SELECT
  c.idClient,
  c.fullName AS Cliente,
  COUNT(o.idOrder) AS TotalPedidos
FROM clients c
LEFT JOIN orders o ON c.idClient = o.idOrderClient
GROUP BY c.idClient, c.fullName
ORDER BY TotalPedidos DESC;

SELECT s.idSeller, s.socialName AS Vendedor, sp.idSupplier, sp.socialName AS Fornecedor
FROM seller s
JOIN supplier sp ON s.CNPJ IS NOT NULL AND s.CNPJ = sp.CNPJ;

SELECT
  p.idProduct,
  p.Pname AS Produto,
  sp.socialName AS Fornecedor,
  IFNULL(ps.price_from_supplier,0) AS PriceFromSupplier,
  IFNULL(sl.quantity,0) AS QtEmEstoque,
  GROUP_CONCAT(DISTINCT CONCAT('Loc:', st.storageLocation)) AS Locais
FROM product p
JOIN productSupplier ps ON p.idProduct = ps.idPsProduct
JOIN supplier sp ON ps.idPsSupplier = sp.idSupplier
LEFT JOIN storageLocation sl ON sl.idLproduct = p.idProduct
LEFT JOIN productStorage st ON sl.idLstorage = st.idProdStorage
GROUP BY p.idProduct, p.Pname, sp.socialName, ps.price_from_supplier
ORDER BY p.Pname;

SELECT sp.socialName AS Fornecedor, p.Pname AS Produto
FROM supplier sp
JOIN productSupplier ps ON sp.idSupplier = ps.idPsSupplier
JOIN product p ON ps.idPsProduct = p.idProduct
ORDER BY sp.socialName, p.Pname;

SELECT
  o.idOrder,
  c.fullName AS Cliente,
  SUM(po.poQuantity * po.poUnitPrice) AS Subtotal,
  o.sendValue,
  SUM(po.poQuantity * po.poUnitPrice) + o.sendValue AS TotalPedido
FROM orders o
JOIN clients c ON o.idOrderClient = c.idClient
JOIN productOrder po ON po.idPOorder = o.idOrder
GROUP BY o.idOrder, c.fullName, o.sendValue
ORDER BY TotalPedido DESC;

SELECT
  c.idClient,
  c.fullName,
  COUNT(o.idOrder) AS TotalPedidos
FROM clients c
JOIN orders o ON o.idOrderClient = c.idClient
GROUP BY c.idClient, c.fullName
HAVING COUNT(o.idOrder) > 1;

SELECT
  p.idProduct, p.Pname,
  SUM(sl.quantity) AS TotalEstoque
FROM product p
JOIN storageLocation sl ON p.idProduct = sl.idLproduct
GROUP BY p.idProduct, p.Pname
HAVING SUM(sl.quantity) < 20
ORDER BY TotalEstoque ASC;

SELECT
  se.idSeller,
  se.socialName AS Vendedor,
  pr.idProduct,
  pr.Pname,
  ps.prodQuantity AS VendidoPeloVendedor,
  COALESCE(SUM(sl.quantity),0) AS EstoqueTotal
FROM seller se
JOIN productSeller ps ON se.idSeller = ps.idPseller
JOIN product pr ON ps.idPproduct = pr.idProduct
LEFT JOIN storageLocation sl ON pr.idProduct = sl.idLproduct
GROUP BY se.idSeller, se.socialName, pr.idProduct, pr.Pname, ps.prodQuantity
HAVING EstoqueTotal > 0
ORDER BY se.socialName;

SELECT d.idDelivery, o.idOrder, c.fullName AS Cliente, d.trackingCode, d.deliveryStatus, d.deliveryDate
FROM delivery d
JOIN orders o ON d.idOrder = o.idOrder
JOIN clients c ON o.idOrderClient = c.idClient
WHERE d.trackingCode IS NOT NULL
ORDER BY d.deliveryDate DESC;

