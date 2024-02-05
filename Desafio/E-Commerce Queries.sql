-- Query de Pedidos realizados e os respectivos clientes.
SELECT 
    clientes.Nome,
    clientes.Endereço,
    produto_em_pedido.Quantidade,
    produtos.Nome AS `Nome do Produto`
FROM
    clientes
        INNER JOIN
    pedido USING (idcliente)
        INNER JOIN
    produto_em_pedido USING (idpedido)
        INNER JOIN
    produtos USING (idproduto);

-- Query de Produtos Vendidos por Terceiros
SELECT 
    `Razão Social`, Nome, Categoria
FROM
    terceiro
        INNER JOIN
    produto_revendido USING (idterceiro)
        INNER JOIN
    produtos USING (idproduto);

-- Query de Produtos Recebidos por fornecedor
SELECT 
    Razão_Social,
    Valor_compra,
    Quantidade,
    valor_compra * quantidade AS Total_da_compra,
    Nome AS Nome_do_Produto,
    Valor AS Valor_Produto
FROM
    fornecedor
        INNER JOIN
    produto_fornecido USING (idfornecedor)
        INNER JOIN
    produtos USING (idproduto);

-- Query para encontrar todos os produtos que estão em estoque.
SELECT 
    *
FROM
    produtos
        INNER JOIN
    produto_estoque USING (idproduto);
