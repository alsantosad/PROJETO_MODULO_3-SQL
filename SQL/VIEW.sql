'''
Essas informações são colocadas em
planilhas diferentes, dificultando muitas das vezes a extração de dados
estratégicos para a empresa.
1. Gerar uma representação das entidades e seus respectivos atributos e relacionamentos;
2. Criar a modelagem do banco de dados;
3. Criar os scripts SQL para criação do banco de dados e das tabelas com seus respectivos
atributos;
4. Criar scripts SQL para inserção dos dados nas tabelas
5. Executar consultas para gerar informações estratégicas para a área de ensino da Resilia
Detalhes do projeto:

● Após a criação do banco de dados, você e sua equipe deverão inserir dados para teste do banco
de dados. Vocês deverão executar as consultas abaixo e apresentar seus resultados:
1. Selecionar a quantidade total de estudantes cadastrados no banco;
2. Selecionar quais pessoas facilitadoras atuam em mais de uma turma;
3. Crie uma view que selecione a porcentagem de estudantes com status de evasão
agrupados por turma;
4. Crie um trigger para ser disparado quando o atributo status de um estudante for atualizado
e inserir um novo dado em uma tabela de log.
● Além disso, vocês deverão pensar em mais uma pergunta que deverá ser respondida por scripts
SQL que combine pelo menos 3 tabelas.
'''

-- 1. Selecionar a quantidade total de estudantes cadastrados no banco;
CREATE VIEW numero_alunos AS
SELECT COUNT(DISTINCT aluno.cpf) AS total_alunos
FROM aluno;

SELECT * FROM numero_alunos;

'''
Como o CPF esta como BIGINT eu estou usando o DISTINCT para tentar contalo apenas uma vez (tem que testar ainda).
'''


-- 2. Selecionar quais pessoas facilitadoras atuam em mais de uma turma;

CREATE VIEW facilitadores_maior2 AS
SELECT cpf_facilitador, COUNT(DISTINCT turma_fk) AS total_turmas
FROM presenca_aluno_facilitador
GROUP BY cpf_facilitador
HAVING COUNT(DISTINCT turma_fk) > 1;

-- 3. Crie uma view que selecione a porcentagem de estudantes com status de evasão agrupados por turma;
-- Aluno -> Avaliaçao -> Diciplina - Modulo -> Curso -> Turma

-- # Tabela de Status em Geral (Ideia para 5 Pergunta) depois filtra para somente os Evadidos
CREATE VIEW status_alunos AS
SELECT 
    aluno.nome,
    aluno.cpf, 
    turma.nome_da_turma, 
    curso.nome_curso, 
    diciplina.nome, 
    avaliacao.nota, 
    avaliacao.status