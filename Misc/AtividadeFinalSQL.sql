USE Master
GO

DROP DATABASE Banco
GO

DROP LOGIN user1
GO
DROP LOGIN user2
GO
DROP LOGIN user3
GO

CREATE DATABASE Banco
GO

USE Banco
GO


SET DATEFORMAT ymd
GO


------------------------- CREATE SCHEMAS ------------------------------------

CREATE SCHEMA escola
GO
CREATE SCHEMA secretaria
GO
CREATE SCHEMA adm
GO


------------------------- CREATE TABLES ------------------------------------

CREATE TABLE escola.aluno(id INT  PRIMARY KEY NOT NULL IDENTITY, nome VARCHAR(MAX), cpf VARCHAR(MAX), data_nascimento DATETIME, ativo BIT)
GO
CREATE TABLE escola.professor(id INT  PRIMARY KEY NOT NULL IDENTITY, nome VARCHAR(MAX), cpf VARCHAR(MAX), ativo BIT)
GO
CREATE TABLE escola.curso(id INT  PRIMARY KEY NOT NULL IDENTITY, nome VARCHAR(MAX), ativo BIT)
GO
CREATE TABLE escola.disciplina(id INT  PRIMARY KEY NOT NULL IDENTITY, nome VARCHAR(MAX), ativo BIT)
GO
CREATE TABLE escola.disciplinaXcurso(id INT  PRIMARY KEY NOT NULL IDENTITY, ativo BIT, id_curso INT FOREIGN KEY REFERENCES escola.curso(id), id_disciplina INT FOREIGN KEY REFERENCES escola.disciplina(id))
GO
CREATE TABLE escola.turma(id INT  PRIMARY KEY NOT NULL IDENTITY, nota1 DECIMAL(5,2), nota2 DECIMAL(5,2), nota3 DECIMAL(5,2), nota4 DECIMAL(5,2), notafinal DECIMAL(5,2), ativo BIT, id_aluno INT FOREIGN KEY REFERENCES escola.aluno(id), id_professor INT FOREIGN KEY REFERENCES escola.professor(id), id_disciplina_curso INT FOREIGN KEY REFERENCES escola.disciplinaXcurso(id))
GO
CREATE TABLE secretaria.pagamentos(id INT  PRIMARY KEY NOT NULL IDENTITY, boleto DATETIME, situacao VARCHAR(MAX) ,id_aluno INT FOREIGN KEY REFERENCES escola.aluno(id))
GO
CREATE TABLE secretaria.inadimplentes(id INT  PRIMARY KEY NOT NULL IDENTITY, data_registro DATETIME, id_aluno INT FOREIGN KEY REFERENCES escola.aluno(id))
GO
CREATE TABLE adm.log(id INT  PRIMARY KEY NOT NULL IDENTITY, tabela VARCHAR(MAX), comando VARCHAR(MAX), mensagem_de_erro VARCHAR(MAX), data_erro DATE)
GO


------------------------- INSERTS ------------------------------------

INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Macy BASs','569.575.437-13','2023-09-03',0)
INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Michelle Tyler','703.786.296-42','2022-07-21',0)
INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Clark Walker','837.575.643-81','2023-05-04',1)
INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Fleur Oneal','336.593.898-32','2022-03-04',1)
INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Dolan Moody','385.426.186-51','2022-05-19',1)
INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Kelsie Baird','175.817.538-61','2023-02-01',1)
INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Kevyn Fisher','167.395.213-52','2022-05-25',1)
INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Mallory Reyes','634.148.494-22','2022-11-08',1)
INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Reece Berg','142.033.744-62','2022-04-12',1)
INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Sawyer Carroll','368.511.862-44','2022-10-23',0)
GO

INSERT INTO escola.professor (nome,cpf) VALUES ('Rhoda Webb','846.358.468-43')
INSERT INTO escola.professor (nome,cpf) VALUES ('Damon Hogan','297.365.977-87')
INSERT INTO escola.professor (nome,cpf) VALUES ('Burton Vaughan','786.834.423-62')
INSERT INTO escola.professor (nome,cpf) VALUES ('Emery Tyson','948.642.765-65')
INSERT INTO escola.professor (nome,cpf) VALUES ('Mariko Osborne','212.133.663-33')
INSERT INTO escola.professor (nome,cpf) VALUES ('Alice Delacruz','683.372.796-68')
INSERT INTO escola.professor (nome,cpf) VALUES ('Brody Bell','841.747.638-82')
INSERT INTO escola.professor (nome,cpf) VALUES ('Hayes Wright','244.589.357-86')
INSERT INTO escola.professor (nome,cpf) VALUES ('Kenyon Clemons','912.345.394-17')
INSERT INTO escola.professor (nome,cpf) VALUES ('Todd Emerson','693.427.177-84')
GO

INSERT INTO escola.curso (nome,ativo) VALUES ('Fort Laird',1)
INSERT INTO escola.curso (nome,ativo) VALUES ('Kungälv',1)
INSERT INTO escola.curso (nome,ativo) VALUES ('Alphen aan den Rijn',1)
INSERT INTO escola.curso (nome,ativo) VALUES ('Otukpo',1)
INSERT INTO escola.curso (nome,ativo) VALUES ('Hong Kong',1)
INSERT INTO escola.curso (nome,ativo) VALUES ('Naushahro Firoze',1)
INSERT INTO escola.curso (nome,ativo) VALUES ('Waiheke Island',1)
INSERT INTO escola.curso (nome,ativo) VALUES ('Calapan',0)
INSERT INTO escola.curso (nome,ativo) VALUES ('Kotamobagu',0)
INSERT INTO escola.curso (nome,ativo) VALUES ('Hollabrunn',1)
GO 

INSERT INTO escola.disciplina (nome,ativo) VALUES ('Osogbo',1)
INSERT INTO escola.disciplina (nome,ativo) VALUES ('Ghizer',1)
INSERT INTO escola.disciplina (nome,ativo) VALUES ('Tampa',1)
INSERT INTO escola.disciplina (nome,ativo) VALUES ('TomASzów Mazowiecki',1)
INSERT INTO escola.disciplina (nome,ativo) VALUES ('Emalahleni',1)
INSERT INTO escola.disciplina (nome,ativo) VALUES ('KAShmore',1)
INSERT INTO escola.disciplina (nome,ativo) VALUES ('Gary',1)
INSERT INTO escola.disciplina (nome,ativo) VALUES ('Mount Gambier',1)
INSERT INTO escola.disciplina (nome,ativo) VALUES ('Máfil',0)
INSERT INTO escola.disciplina (nome,ativo) VALUES ('Haarlem',1)
GO 

INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (1,1,1)
INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (2,2,0)
INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (3,3,0)
INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (4,4,1)
INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (5,5,0)
INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (6,6,0)
INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (7,7,1)
INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (8,8,1)
INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (9,9,1)
INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (10,10,0)
GO

INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (1,1,1,10,5,3,5,4,0)
INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (2,2,2,6,9,2,8,3,1)
INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (3,3,3,4,7,4,6,9,0)
INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (4,4,4,0,2,7,2,3,0)
INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (5,5,5,10,6,6,4,1,0)
INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (6,6,6,6,3,7,9,6,0)
INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (7,7,7,6,1,6,7,4,1)
INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (8,8,8,3,4,3,8,7,0)
INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (9,9,9,1,3,4,9,6,1)
INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (10,10,10,3,0,4,1,5,1)
GO

INSERT INTO secretaria.pagamentos (boleto, situacao, id_aluno) VALUES ('2022-11-09', 'pendente', 1)
INSERT INTO secretaria.pagamentos (boleto, situacao, id_aluno) VALUES ('2022-11-10', 'pendente', 2)
INSERT INTO secretaria.pagamentos (boleto, situacao, id_aluno) VALUES ('2022-11-11', 'pendente', 3)
INSERT INTO secretaria.pagamentos (boleto, situacao, id_aluno) VALUES ('2022-11-12', 'pendente', 4)
INSERT INTO secretaria.pagamentos (boleto, situacao, id_aluno) VALUES ('2022-11-08', 'pendente', 5)
INSERT INTO secretaria.pagamentos (boleto, situacao, id_aluno) VALUES ('2022-12-01', 'pendente', 6)
INSERT INTO secretaria.pagamentos (boleto, situacao, id_aluno) VALUES ('2022-10-20', 'pendente', 7)
INSERT INTO secretaria.pagamentos (boleto, situacao, id_aluno) VALUES ('2022-12-09', 'pendente', 1)
GO

INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (1,'2022-01-01')
INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (2,'2023-09-15')
INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (3,'2022-11-24')
INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (4,'2023-10-15')
INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (5,'2023-04-18')
INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (6,'2023-05-28')
INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (7,'2022-11-08')
INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (8,'2023-01-13')
INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (9,'2022-02-03')
INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (10,'2023-02-04')
GO


------------------------- FUNÇÕES ------------------------------------

CREATE FUNCTION verificaIdade(@data_nascimento DATETIME)
RETURNS BIT
BEGIN
	DECLARE @idade INT
	SET @idade = FLOOR(DATEDIFF(DAY, @data_nascimento, GETDATE()) / 365.25)

	IF (@idade > 18) 
		RETURN(1)
	RETURN(0)
END
GO


------------------------- PROCEDURES DE INSERT ------------------------------------

--ALUNO--
CREATE PROCEDURE insereAluno
@nome VARCHAR(MAX), @cpf VARCHAR(MAX), @data_nascimento DATE
AS
BEGIN
	BEGIN TRY
		DECLARE @data DATETIME
		DECLARE @verificacao_idade BIT

		EXEC @verificacao_idade = verificaIdade @data_nascimento
	
		IF (@verificacao_idade = 1)
			INSERT INTO escola.aluno(nome, cpf, data_nascimento, ativo) VALUES (@nome, @cpf, @data_nascimento, 1)
		ELSE
			PRINT 'Aluno menor de idade'
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('aluno', 'INSERT', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--PROFESSOR--
CREATE PROCEDURE insereProfessor
@nome VARCHAR(MAX), @cpf VARCHAR(MAX), @ativo BIT
AS
BEGIN
	BEGIN TRY
		INSERT INTO escola.professor(nome, cpf, ativo) VALUES (@nome, @cpf, @ativo)
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('professor', 'INSERT', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--CURSO--
CREATE PROCEDURE insereCurso
@nome VARCHAR(MAX), @ativo BIT
AS
BEGIN
	BEGIN TRY
		INSERT INTO escola.curso(nome, ativo) VALUES (@nome, @ativo)
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('curso', 'INSERT', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--DISCIPLINA--
CREATE PROCEDURE insereDisciplina
@nome VARCHAR(MAX), @ativo BIT
AS
BEGIN
	BEGIN TRY
		INSERT INTO escola.disciplina(nome, ativo) VALUES (@nome, @ativo)
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('disciplina', 'INSERT', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--DISCIPLINA_CURSO--
CREATE PROCEDURE insereDisciplinaXCurso
@ativo BIT, @id_curso INT , @id_disciplina INT
AS
BEGIN
	BEGIN TRY
		INSERT INTO escola.disciplinaXcurso(ativo, id_curso, id_disciplina) VALUES (@ativo, @id_curso, @id_disciplina)
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('disciplinaXcurso', 'INSERT', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--TURMA--
CREATE PROCEDURE insereTurma
@nota1 DECIMAL(5,2), @nota2 DECIMAL(5,2), @nota3 DECIMAL(5,2), @nota4 DECIMAL(5,2), @notafinal DECIMAL(5,2), @ativo BIT , @id_aluno INT, @id_professor INT, @id_disciplina_curso INT
AS
BEGIN
	BEGIN TRY
		INSERT INTO escola.turma (nota1, nota2, nota3, nota4, notafinal, ativo, id_aluno, id_professor, id_disciplina_curso) VALUES (@nota1, @nota2, @nota3, @nota4, @notafinal, @ativo, @id_aluno, @id_professor, @id_disciplina_curso)
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('turma', 'INSERT', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--PAGAMENTOS--
CREATE PROCEDURE inserePagamento
@boleto DATETIME, @id_aluno INT
AS
BEGIN
	BEGIN TRY
		INSERT INTO secretaria.pagamentos(boleto, situacao, id_aluno) VALUES (@boleto, 'pendente', @id_aluno)
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('pagamentos', 'INSERT', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--INADIMPLENTES--
CREATE PROCEDURE insereInadimplentes
@id_aluno INT
AS
BEGIN
	BEGIN TRY
		INSERT INTO secretaria.inadimplentes (data_registro, id_aluno) VALUES (GETDATE(), @id_aluno)
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('inadimplentes', 'INSERT', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


------------------------- PROCEDURES DE DELETE ------------------------------------

--ALUNO--
CREATE PROCEDURE DELETEAluno
@id INT
AS
BEGIN
	BEGIN TRY
		UPDATE escola.aluno SET ativo = 0 WHERE id = @id
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('aluno', 'DELETE', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--PROFESSOR--
CREATE PROCEDURE DELETEProfessor
@id INT
AS
BEGIN
	BEGIN TRY
		UPDATE escola.professor SET ativo = 0 WHERE id = @id
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('professor', 'DELETE', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--CURSO--
CREATE PROCEDURE DELETECurso
@id INT
AS
BEGIN
	BEGIN TRY
		UPDATE escola.curso SET ativo = 0 WHERE id = @id
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('curso', 'DELETE', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--DISCIPLINA--
CREATE PROCEDURE DELETEDisciplina
@id INT
AS
BEGIN
	BEGIN TRY
		UPDATE escola.disciplina SET ativo = 0 WHERE id = @id
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('disciplina', 'DELETE', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--DISCIPLINA_CURSO--
CREATE PROCEDURE DELETEDisciplinaXCurso
@id INT
AS
BEGIN
	BEGIN TRY
		UPDATE escola.disciplinaXcurso SET ativo = 0 WHERE id = @id
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('disciplinaXcurso', 'DELETE', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--TURMA--
CREATE PROCEDURE DELETETurma
@id INT
AS
BEGIN
	BEGIN TRY
		UPDATE escola.turma SET ativo = 0 WHERE id = @id
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('turma', 'DELETE', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--PAGAMENTOS--
CREATE PROCEDURE DELETEPagamentos
@id_aluno INT
AS
BEGIN
	BEGIN TRY
		DELETE FROM secretaria.pagamentos WHERE id_aluno = @id_aluno
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('pagamentos', 'DELETE', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--INADIMPLENTES--
CREATE PROCEDURE DELETEInadimplentes
@id_aluno INT
AS
BEGIN
	BEGIN TRY
		DELETE FROM secretaria.inadimplentes WHERE id_aluno = @id_aluno
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('inadimplentes', 'DELETE', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


------------------------- PROCEDURES DE UPDATE ------------------------------------

--ALUNO--
CREATE PROCEDURE UPDATEAluno
@nome VARCHAR(MAX), @cpf VARCHAR(MAX), @data_nascimento DATE, @ativo INT
AS
BEGIN
	BEGIN TRY
		DECLARE @data DATETIME
		DECLARE @idade INT
		DECLARE @temp BIT
		SET @idade = FLOOR(DATEDIFF(DAY, @data_nascimento, GETDATE()) / 365.25)
	
		EXEC @temp = verificaIdade @idade
	
		IF (@temp = 1)
			UPDATE escola.aluno SET nome = @nome, data_nascimento = @data_nascimento, ativo = @ativo WHERE cpf = @cpf
		ELSE
			PRINT 'Aluno menor de idade'
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('aluno', 'UPDATE', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--PROFESSOR--
CREATE PROCEDURE UPDATEProfessor
@nome VARCHAR(MAX), @cpf VARCHAR(MAX), @ativo BIT
AS
BEGIN
	BEGIN TRY
		UPDATE escola.professor SET nome = @nome, ativo = @ativo WHERE cpf = @cpf
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('professor', 'UPDATE', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--CURSO--
CREATE PROCEDURE UPDATECurso
@nome VARCHAR(MAX), @ativo BIT, @id INT
AS
BEGIN
	BEGIN TRY
		UPDATE escola.curso SET nome = @nome, ativo = @ativo WHERE id = @id
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('curso', 'UPDATE', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--DISCIPLINA--
CREATE PROCEDURE UPDATEDisciplina
@nome VARCHAR(MAX), @ativo BIT, @id INT
AS
BEGIN
	BEGIN TRY
		UPDATE escola.disciplina SET nome = @nome, ativo = @ativo WHERE id = @id
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('disciplina', 'UPDATE', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--DISCIPLINA_CURSO--
CREATE PROCEDURE UPDATEDisciplinaXCurso
@ativo BIT, @id_curso INT , @id_disciplina INT, @id INT
AS
BEGIN
	BEGIN TRY
		UPDATE escola.disciplinaXcurso SET ativo = @ativo, id_curso = @id_curso, id_disciplina = @id_disciplina WHERE id = @id
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('disciplinaXcurso', 'UPDATE', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--TURMA--
CREATE PROCEDURE UPDATETurma
@nota1 DECIMAL(5,2), @nota2 DECIMAL(5,2), @nota3 DECIMAL(5,2), @nota4 DECIMAL(5,2), @notafinal DECIMAL(5,2), @ativo BIT , @id_aluno INT, @id_professor INT, @id_disciplina_curso INT, @id INT
AS
BEGIN
	BEGIN TRY
		UPDATE escola.turma SET nota1 = @nota1, nota2 = @nota2, nota3 = @nota3, nota4 = @nota4, notafinal = @notafinal, ativo = @ativo, id_aluno = @id_aluno, id_professor = @id_professor, id_disciplina_curso = @id_disciplina_curso WHERE id = @id
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('turma', 'UPDATE', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--PAGAMENTO--
CREATE PROCEDURE UPDATEPagamento
@boleto DATETIME, @id_aluno INT, @situacao VARCHAR(MAX)
AS
BEGIN
	BEGIN TRY
		UPDATE secretaria.pagamentos SET boleto = @boleto, situacao = @situacao WHERE id_aluno = @id_aluno
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('pagamentos', 'UPDATE', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


--INADIMPLENTES--
CREATE PROCEDURE UPDATEInadimplentes
@id_aluno INT
AS
BEGIN
	BEGIN TRY
		UPDATE secretaria.inadimplentes SET data_registro = GETDATE() WHERE id_aluno = @id_aluno
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('inadimplentes', 'UPDATE', ERROR_MESSAGE(), GETDATE())
	END CATCH
END
GO


------------------------- TRIGGERS EXERCICIO 03 ------------------------------------

CREATE TRIGGER trg_UPDATE_curso
ON escola.curso
AFTER UPDATE
AS
BEGIN
	DECLARE @situacao BIT
	DECLARE @id INT
	IF UPDATE(ativo)
	BEGIN
		SELECT @situacao = ativo FROM INSERTED
		SELECT @id = id FROM INSERTED
		IF(@situacao=0)
		BEGIN
			UPDATE escola.disciplinaXcurso SET ativo=@situacao WHERE id_curso=@id
		END
	END
END
GO


CREATE TRIGGER trg_UPDATE_disciplina
ON escola.disciplina
AFTER UPDATE
AS
BEGIN
	DECLARE @situacao BIT
	DECLARE @id INT
	IF UPDATE(ativo)
	BEGIN
		SELECT @situacao = ativo FROM INSERTED
		SELECT @id = id FROM INSERTED
		IF(@situacao=0)
		BEGIN
			UPDATE escola.disciplinaXcurso SET ativo=@situacao WHERE id_curso=@id
		END
	END
END
GO


CREATE TRIGGER trg_UPDATE_disciplinaXcurso
ON escola.disciplinaXcurso
AFTER UPDATE
AS
BEGIN
	DECLARE @situacao BIT
	DECLARE @id INT
	IF UPDATE(ativo)
	BEGIN
		SELECT @situacao = ativo FROM INSERTED
		SELECT @id = id FROM INSERTED
		IF(@situacao=0)
		BEGIN
			UPDATE escola.turma SET ativo=@situacao WHERE id_disciplina_curso=@id
		END
	END
END
GO


------------------------- EXERCICIO 04 ------------------------------------

CREATE PROCEDURE UPDATE_situacao_pagamento
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		UPDATE secretaria.pagamentos SET situacao = 'em atraso' WHERE boleto > GETDATE() AND situacao = 'pendente'

		INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) SELECT id_aluno, GETDATE() FROM secretaria.pagamentos GROUP BY id_aluno HAVING SUM(CASE WHEN situacao = 'em atraso' THEN 1 ELSE 0 END) > 3
	END TRY
	BEGIN CATCH
		INSERT INTO adm.log(tabela, comando, mensagem_de_erro, data_erro) VALUES ('pagamentos', 'UPDATE', ERROR_MESSAGE(), GETDATE())

		IF @@TRANCOUNT > 0  -- IF para verificar se há transação aberta
			ROLLBACK TRANSACTION;  -- se entro no CATCH, EXECuta um rollback para desfazer
	END CATCH
		
	IF @@TRANCOUNT > 0  -- IF para verificar se há transação aberta. CASo tenha entrado no CATCH acima, terá sido EXECutado o rollback, não existirá mais transação aberta e não entrará nesse if
		COMMIT TRANSACTION
END
GO


------------------------- EXERCICIO 05 ------------------------------------

CREATE VIEW notAS_alunos AS (
	SELECT escola.aluno.Nome AS 'Nome aluno', escola.disciplina.nome AS 'Nome disciplina', Nota1, Nota2, Nota3, Nota4, NotaFinal 
	FROM escola.turma 
	INNER JOIN escola.aluno ON escola.aluno.id = id_aluno 
	INNER JOIN escola.disciplinaXcurso ON escola.disciplinaXcurso.id = id_disciplina_curso 
	INNER JOIN escola.disciplina ON escola.disciplina.id = id_disciplina
)
GO
-- SELECT * FROM notAS_alunos order by [Nome aluno]

CREATE VIEW alunos_inadimplentes AS (
	SELECT escola.aluno.nome AS 'Nome Aluno' 
FROM secretaria.inadimplentes 
INNER JOIN escola.aluno ON escola.aluno.id = id_aluno
)
GO
-- SELECT * FROM alunos_inadimplentes order by [Nome aluno]


------------------------- EXERCICIO 06 ------------------------------------

CREATE FUNCTION alunos_turma (@id_disciplina INT, @id_curso INT)
RETURNS TABLE
AS
RETURN
	SELECT escola.aluno.Nome AS 'Nome aluno' 
	FROM escola.turma 
	INNER JOIN escola.aluno ON escola.aluno.id = id_aluno
	INNER JOIN escola.disciplinaXcurso ON escola.disciplinaXcurso.id = id_disciplina_curso
	WHERE escola.disciplinaXcurso.id_curso = @id_curso AND escola.disciplinaXcurso.id_disciplina = @id_disciplina
GO


CREATE FUNCTION disciplinAS_aluno (@id_aluno INT)
RETURNS TABLE
AS
RETURN
	SELECT escola.disciplina.Nome AS 'Nome aluno' 
	FROM escola.turma 
	INNER JOIN escola.aluno ON escola.aluno.id = id_aluno
	INNER JOIN escola.disciplinaXcurso ON escola.disciplinaXcurso.id = id_disciplina_curso
	INNER JOIN escola.disciplina ON escola.disciplina.id = escola.disciplinaXcurso.id_disciplina
	WHERE id_aluno = @id_aluno
GO


------------------------- EXERCICIO 07 ------------------------------------

CREATE NONCLUSTERED INDEX IId ON escola.aluno(id)
--  Temos o nome do indice, a tabela onde ele será criado e para qual coluna será criado


------------------------- EXERCICIO 08 ------------------------------------

CREATE LOGIN user1 WITH PASSWORD='123456789123'
CREATE USER user1 FROM LOGIN user1

CREATE LOGIN user2 WITH PASSWORD='123456789123'
CREATE USER user2 FROM LOGIN user2

CREATE LOGIN user3 WITH PASSWORD='123456789123'
CREATE USER user3 FROM LOGIN user3


GRANT ALL TO user1
GRANT ALTER, EXECUTE, VIEW DEFINITION TO user2 
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::escola TO user3


------------------------- EXERCICIO 09 ------------------------------------

INSERT INTO escola.aluno VALUES ('Edjalma', '12345678910', '2000-01-01', 1)
BACKUP DATABASE Banco TO DISK = 'C:\Banco.bak' WITH NOINIT
