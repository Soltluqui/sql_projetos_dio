-- Ver o Veiculo e seu Dono
SELECT 
    *
FROM
    clientes
        INNER JOIN
    veiculos USING (idclientes);

-- Mostrar informações da Ordem de Serviço
SELECT 
    Modelo, Data_entrada, Status_ordem, Descrição
FROM
    veiculos
        INNER JOIN
    ordem_serviço USING (idveiculos)
        INNER JOIN
    ordem_serviços USING (idordem_serviço)
        INNER JOIN
    serviços USING (idserviços);

-- Mostrar informações sobre Mecânicos
SELECT 
    Nome, Turno, Setor
FROM
    mecânico
        INNER JOIN
    equipe USING (idequipe);
