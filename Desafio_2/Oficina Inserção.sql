INSERT INTO Clientes (Nome, Contato, CPF)
VALUES ('Camila Bernardes', '95989692670', '26258943187'),
('Isabella Aline', '83984098518', '92997695406'),
('Takumi Fujiwara', '51985504881', '75022468190');

INSERT INTO Veiculos (idClientes, Modelo, Placa, Ano)
VALUES ('1', 'Hilux Branca', 'UIO3Y56', '2022'),
('2', 'Corolla Preto', 'OIJ8F76', '2021'),
('3', 'Trueno AE86', '13-954', '1983');

INSERT INTO Equipe (Turno, Setor)
VALUES ('Diurno', 'Mecânico'),
('Noturno', 'Estético'),
('Diurno', 'Revisão');

INSERT INTO Mecânico (idEquipe, Nome)
VALUES ('1', 'Carlos Alberto'),
('1', 'Rodrigo Tavares'),
('1', 'Luan Santana'),
('2', 'Pedro Gomes'),
('2', 'João Pedro'),
('2', 'Zé Felipe'),
('3', 'Gabriel Antonio'),
('3', 'Luiz Felipe'),
('3', 'Matheus Campos');

INSERT INTO Pecas (Código, Descrição, Quantidade, Valor_un)
VALUES ('896257', 'Oleo 15W40', '9', '50'),
('254863', 'Motor Trueno', '1', '20000'),
('826428', 'Banco Esportivo', '4', '350'),
('756842', 'Volante Esportivo', '6', '500');

INSERT INTO Serviços (Descrição, Valor)
VALUES ('Troca de motor', '3500'),
('Troca de Volante', '300'),
('Troca de Bancos', '250'),
('Revisão Completa', '800'),
('Troca de Óleo', '150');

INSERT INTO Ordem_Serviço (idVeiculos, idEquipe, Data_entrada, Data_saida, Status_ordem, Valor_total)
VALUES ('1', '3', '2024-01-05', '2024-01-07', 'Concluido', '1000'),
('2', '2', '2024-01-06', '2024-01-08', 'Concluido', '2450'),
('3', '1', '2024-01-01', NULL, 'Pendente', '23500');

INSERT INTO Ordem_Serviços (idServiços, idOrdem_Serviço)
VALUES ('4', '1'),
('5', '1'),
('2', '2'),
('3', '2'),
('1', '3');

INSERT INTO Ordem_Pecas (idOrdem_Serviço, idPecas, Quantidade)
VALUES ('1', '1', '1'),
('2', '3', '4'),
('3', '2', '1');
