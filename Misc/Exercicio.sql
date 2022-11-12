USE Master;
GO

DROP DATABASE Banco;
GO


/* Criação do Banco de Dados */

CREATE DATABASE Banco;
GO

USE Banco;
GO


/* Config */

SET DATEFORMAT ymd
GO


/* Schemas */

CREATE SCHEMA Escola;
GO

CREATE SCHEMA Secretaria;
GO

CREATE SCHEMA ADM;
GO


/* Tabelas */

CREATE TABLE Escola.Aluno(
	Id INT PRIMARY KEY IDENTITY,
	Nome VARCHAR(100) NOT NULL,
	Cpf CHAR(11) UNIQUE NOT NULL,
	DataNascimento DATE NOT NULL,
	Situacao BIT NOT NULL
);
GO

CREATE TABLE Escola.Professor(
	Id INT PRIMARY KEY IDENTITY,
	Nome VARCHAR(100) NOT NULL,
	Cpf CHAR(11) UNIQUE NOT NULL
);
GO

CREATE TABLE Escola.Curso(
	Id INT PRIMARY KEY IDENTITY,
	Nome VARCHAR(50) UNIQUE NOT NULL,
	Ativo BIT NOT NULL
);
GO

CREATE TABLE Escola.Disciplina(
	Id INT PRIMARY KEY IDENTITY,
	Nome VARCHAR(50) UNIQUE NOT NULL,
	Ativo BIT NOT NULL
);
GO

CREATE TABLE Escola.DisciplinaCurso(
	Id INT PRIMARY KEY IDENTITY,
	CursoId INT FOREIGN KEY REFERENCES Escola.Curso(Id) NOT NULL,
	DisciplinaId INT FOREIGN KEY REFERENCES Escola.Disciplina(Id) NOT NULL,
	Ativo BIT NOT NULL
);
GO

CREATE TABLE Escola.Turma(
	Id INT PRIMARY KEY IDENTITY,
	AlunoId INT FOREIGN KEY REFERENCES Escola.Aluno(Id) NOT NULL,
	ProfessorId INT FOREIGN KEY REFERENCES Escola.Professor(Id) NOT NULL,
	DisciplinaCursoId INT FOREIGN KEY REFERENCES Escola.DisciplinaCurso(Id) NOT NULL,
	Nota1 INT CHECK(Nota1 >= -1 AND Nota1 <= 100) NOT NULL,
	Nota2 INT CHECK(Nota2 >= -1 AND Nota2 <= 100) NOT NULL,
	Nota3 INT CHECK(Nota3 >= -1 AND Nota3 <= 100) NOT NULL,
	Nota4 INT CHECK(Nota4 >= -1 AND Nota4 <= 100) NOT NULL,
	NotaFinal INT CHECK(NotaFinal >= -1 AND NotaFinal <= 100) NOT NULL,
	Ativo BIT NOT NULL
);
GO

CREATE TABLE Secretaria.Pagamento(
	Id INT PRIMARY KEY IDENTITY,
	AlunoId INT FOREIGN KEY REFERENCES Escola.Aluno(Id) NOT NULL,
	Boleto DATE NOT NULL,
	Situacao INT CHECK(Situacao >= 0 AND  Situacao <= 2) NOT NULL -- Pendente, Pago, Atrasado
);
GO

CREATE TABLE Secretaria.Inadimplente(
	Id INT PRIMARY KEY IDENTITY,
	AlunoId INT FOREIGN KEY REFERENCES Escola.Aluno(Id) NOT NULL,
	DataRegistro DATE NOT NULL
);
GO

CREATE TABLE ADM.Log(
	Id INT PRIMARY KEY IDENTITY,
	Tabela VARCHAR(25) NOT NULL,
	Comando VARCHAR(50) NOT NULL,
	MensagemErro VARCHAR(MAX) NOT NULL,
	Data SMALLDATETIME NOT NULL
);
GO


/* 2 - Crie uma procedure de insert, uma de update e uma de delete para cada tabela */


/* Functions */

CREATE FUNCTION MaiorDeIdade(@Data DATE)
RETURNS BIT
AS
BEGIN
	IF (DATEADD(year, -18, GETDATE()) >= @Data)
		RETURN 1
	RETURN 0
END
GO


/* Inserts */

CREATE PROCEDURE PInsertAluno(@Nome VARCHAR(100), @CPF CHAR(11), @DataNascimento DATE)
AS
BEGIN
	IF (LEN(@Nome) < 3)
	BEGIN
		PRINT('ERROR in PInsertAluno: Nome deve ter 3 caracteres no mínimo.')
		RETURN
	END
	IF (LEN(@CPF) <> 11)
	BEGIN
		PRINT('ERROR in PInsertAluno: CPF deve ter 11 caracteres obrigatoriamente.')
		RETURN
	END
	IF (dbo.MaiorDeIdade(@DataNascimento) = 0)
	BEGIN
		PRINT('ERROR in PInsertAluno: O usuário deve ter 18 anos de idade ou mais.')
		RETURN
	END

	INSERT
		INTO Escola.Aluno
		VALUES (@Nome, @CPF, @DataNascimento, 1)
END
GO

/*
EXEC PInsertAluno 'Aluno', '12345678910', '2000-01-01'
SELECT * FROM Escola.Aluno
*/


CREATE PROCEDURE PInsertProfessor(@Nome VARCHAR(100), @CPF CHAR(11))
AS
BEGIN
	IF (LEN(@Nome) < 3)
	BEGIN
		PRINT('ERROR in PInsertProfessor: Nome deve ter 3 caracteres no mínimo.')
		RETURN
	END
	IF (LEN(@CPF) <> 11)
	BEGIN
		PRINT('ERROR in PInsertProfessor: CPF deve ter 11 caracteres obrigatoriamente.')
		RETURN
	END

	INSERT
		INTO Escola.Professor
		VALUES (@Nome, @CPF)
END
GO

/*
EXEC PInsertProfessor 'Professor', '12345678910'
SELECT * FROM Escola.Professor
*/


CREATE PROCEDURE PInsertCurso(@Nome VARCHAR(50))
AS
BEGIN
	IF (LEN(@Nome) < 3)
	BEGIN
		PRINT('ERROR in PInsertCurso: Nome deve ter 3 caracteres no mínimo.')
		RETURN
	END

	INSERT
		INTO Escola.Curso
		VALUES (@Nome, 1)
END
GO

/*
EXEC PInsertCurso 'Curso'
SELECT * FROM Escola.Curso
*/


CREATE PROCEDURE PInsertDisciplina(@Nome VARCHAR(50))
AS
BEGIN
	IF (LEN(@Nome) < 3)
	BEGIN
		PRINT('ERROR in PInsertDisciplina: Nome deve ter 3 caracteres no mínimo.')
		RETURN
	END

	INSERT
		INTO Escola.Disciplina
		VALUES (@Nome, 1)
END
GO

/*
EXEC PInsertDisciplina 'Disciplina'
SELECT * FROM Escola.Disciplina
*/


CREATE PROCEDURE PInsertDisciplinaCurso(@NomeCurso VARCHAR(50), @NomeDisciplina VARCHAR(50))
AS
BEGIN
	DECLARE @CursoId INT
	DECLARE @DisciplinaId INT

	SELECT
		@CursoId = Id
		FROM
			Escola.Curso
		WHERE
			Nome = @NomeCurso

	IF (@CursoId IS NULL)
	BEGIN
		PRINT('ERROR in PInsertDisciplinaCurso: Não existe um curso com o nome provido.')
		RETURN
	END

	SELECT
		@DisciplinaId = Id
		FROM
			Escola.Disciplina
		WHERE
			Nome = @NomeDisciplina

	IF (@DisciplinaId IS NULL)
	BEGIN
		PRINT('ERROR in PInsertDisciplinaCurso: Não existe uma disciplina com o nome provido.')
		RETURN
	END

	INSERT
		INTO Escola.DisciplinaCurso
		VALUES (1, @CursoId, @DisciplinaId)
END
GO

/*
EXEC PInsertCurso 'Curso'
EXEC PInsertDisciplina 'Disciplina'
EXEC PInsertDisciplinaCurso 'Curso', 'Disciplina'
SELECT * FROM Escola.DisciplinaCurso
*/


CREATE PROCEDURE PInsertTurma(@AlunoNome VARCHAR(100), @ProfessorNome VARCHAR(100), @CursoNome VARCHAR(50), @DisciplinaNome VARCHAR(50))
AS
BEGIN
	DECLARE @AlunoId INT
	DECLARE @ProfessorId INT
	DECLARE @DisciplinaCursoId INT

	SELECT
		@AlunoId = Id
		FROM
			Escola.Aluno
		WHERE
			Nome = @AlunoNome

	IF (@AlunoId IS NULL)
	BEGIN
		PRINT('ERROR in PInsertTurma: O nome de aluno inserido não existe.')
		RETURN
	END

	SELECT
		@ProfessorId = Id
		FROM
			Escola.Professor
		WHERE
			Nome = @ProfessorNome

	IF (@ProfessorId IS NULL)
	BEGIN
		PRINT('ERROR in PInsertTurma: O nome de professor inserido não existe.')
		RETURN
	END

	SELECT
		@DisciplinaCursoId = dc.Id
		FROM
			Escola.DisciplinaCurso AS dc
		INNER JOIN
			Escola.Disciplina AS d ON dc.DisciplinaId = d.Id
		INNER JOIN
			Escola.Curso AS c ON dc.CursoId = c.Id
		WHERE
			c.Nome = @CursoNome AND d.Nome = @DisciplinaNome

	IF (@DisciplinaCursoId IS NULL)
	BEGIN
		PRINT('ERROR in PInsertTurma: O nome de curso ou disciplina inseridos não existem.')
		RETURN
	END
	
	INSERT
		INTO Escola.Turma
		VALUES (@AlunoId, @ProfessorId, @DisciplinaCursoId, -1, -1, -1, -1, -1, 1)
END
GO

/*
EXEC PInsertAluno 'Aluno', '12345678910', '2000-01-01'
EXEC PInsertProfessor 'Professor', '12345678910'
EXEC PInsertCurso 'Curso'
EXEC PInsertDisciplina 'Disciplina'
EXEC PInsertDisciplinaCurso 'Curso', 'Disciplina'
EXEC PInsertTurma 'Aluno', 'Professor', 'Curso', 'Disciplina'
SELECT * FROM Escola.Turma
*/


-- TODO: Data padrão de 1 mes após hoje? -- TODO: Nome ou CPF do aluno? -- TODO: Qual verificação de insercao do boleto?
CREATE PROCEDURE PInsertPagamento(@AlunoNome VARCHAR(100), @Boleto DATE)
AS
BEGIN
	DECLARE @AlunoId INT

	SELECT
		@AlunoId = Id
		FROM
			Escola.Aluno
		WHERE
			Nome = @AlunoNome

	IF (@AlunoId IS NULL)
	BEGIN
		PRINT('ERROR in PInsertPagamentos: O nome de aluno inserido não existe.')
		RETURN
	END

	INSERT
		INTO Secretaria.Pagamento
		VALUES (@AlunoId, @Boleto, 0)
END
GO

/*
EXEC PInsertAluno 'Aluno', '12345678910', '2000-01-01'
EXEC PInsertPagamento 'Aluno', '2022-11-30'
SELECT * FROM Secretaria.Pagamento
*/


CREATE PROCEDURE PInsertInadimplente(@AlunoNome VARCHAR(100), @DataRegistro DATE)
AS
BEGIN
	DECLARE @AlunoId INT

	SELECT
		@AlunoId = Id
		FROM
			Escola.Aluno
		WHERE
			Nome = @AlunoNome

	IF (@AlunoId IS NULL)
	BEGIN
		PRINT('ERROR in PInsertPagamentos: O nome de aluno inserido não existe.')
		RETURN
	END

	INSERT
		INTO Secretaria.Inadimplente
		VALUES (@AlunoId, @DataRegistro)
END
GO

/*
EXEC PInsertAluno 'Aluno', '12345678910', '2000-01-01'
EXEC PInsertInadimplente 'Aluno', '2022-11-30'
SELECT * FROM Secretaria.Inadimplente
*/


-- TODO: Fix Log error handling
CREATE PROCEDURE PInsertLog(@Tabela VARCHAR(25), @Comando VARCHAR(50), @MensagemErro VARCHAR(MAX))
AS
BEGIN
	IF (LEN(@Tabela) = 0)
	BEGIN
		SET @Tabela = 'Nenhuma tabela foi provida ao log.'
	END
	
	IF (LEN(@Comando) = 0)
	BEGIN
		SET @Tabela = 'Nenhum comando foi provido ao log.'
	END
	
	IF (LEN(@MensagemErro) = 0)
	BEGIN
		SET @Tabela = 'Nenhuma mensagem de erro foi provida ao log.'
	END

	INSERT
		INTO ADM.Log
		VALUES (@Tabela, @Comando, @MensagemErro, GETDATE())
END
GO

/*
EXEC PInsertLog 'Tabela', 'Comando', 'Erro'
SELECT * FROM ADM.Log
*/


/* Updates */

 /*
CREATE PROCEDURE PUpdateAluno(@Nome VARCHAR(100), @CPF CHAR(11), @DataNascimento DATE)
AS
BEGIN
	
END
GO

CREATE PROCEDURE PUpdateProfessor(@Nome VARCHAR(100), @CPF CHAR(11))
AS
BEGIN
	
END
GO

CREATE PROCEDURE PUpdateCurso(@Nome VARCHAR(50))
AS
BEGIN
	
END
GO

CREATE PROCEDURE PUpdateDisciplina(@Nome VARCHAR(50))
AS
BEGIN
	
END
GO

CREATE PROCEDURE PUpdateDisciplinaCurso(@NomeDisciplina VARCHAR(50), @NomeCurso VARCHAR(50))
AS
BEGIN
	
END
GO

CREATE PROCEDURE PUpdateTurma(@AlunoId INT, @ProfessorId INT, @DisciplinaCursoId INT)
AS
BEGIN
	
END
GO

CREATE PROCEDURE PUpdatePagamento(@AlunoId INT, @Boleto DATE)
AS
BEGIN
	
END
GO

CREATE PROCEDURE PUpdateInadimplente(@AlunoId INT, @DataRegistro DATE)
AS
BEGIN
	
END
GO

CREATE PROCEDURE PUpdateLog(@Tabela VARCHAR(25), @Comando VARCHAR(50), @MensagemErro VARCHAR(MAX), @Data SMALLDATETIME)
AS
BEGIN
	
END
GO


 Deletes 

CREATE PROCEDURE PDeleteAluno(@Nome VARCHAR(100), @CPF CHAR(11), @DataNascimento DATE)
AS
BEGIN
	
END
GO

CREATE PROCEDURE PDeleteProfessor(@Nome VARCHAR(100), @CPF CHAR(11))
AS
BEGIN
	
END
GO

CREATE PROCEDURE PDeleteCurso(@Nome VARCHAR(50))
AS
BEGIN
	
END
GO

CREATE PROCEDURE PDeleteDisciplina(@Nome VARCHAR(50))
AS
BEGIN
	
END
GO

CREATE PROCEDURE PDeleteDisciplinaCurso(@NomeDisciplina VARCHAR(50), @NomeCurso VARCHAR(50))
AS
BEGIN
	
END
GO

CREATE PROCEDURE PDeleteTurma(@AlunoId INT, @ProfessorId INT, @DisciplinaCursoId INT)
AS
BEGIN
	
END
GO

CREATE PROCEDURE PDeletePagamento(@AlunoId INT, @Boleto DATE)
AS
BEGIN
	
END
GO

CREATE PROCEDURE PDeleteInadimplente(@AlunoId INT, @DataRegistro DATE)
AS
BEGIN
	
END
GO

CREATE PROCEDURE PDeleteLog(@Tabela VARCHAR(25), @Comando VARCHAR(50), @MensagemErro VARCHAR(MAX), @Data DATE)
AS
BEGIN
	
END
GO
*/
