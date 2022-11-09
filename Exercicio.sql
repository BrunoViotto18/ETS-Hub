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
	Ativo BIT NOT NULL,
	CursoId INT FOREIGN KEY REFERENCES Escola.Curso(Id),
	DisciplinaId INT FOREIGN KEY REFERENCES Escola.Disciplina(Id)
);
GO

CREATE TABLE Escola.Turma(
	Id INT PRIMARY KEY IDENTITY,
	Nota1 INT CHECK(Nota1 >= 0 AND Nota1 <= 100),
	Nota2 INT CHECK(Nota2 >= 0 AND Nota2 <= 100),
	Nota3 INT CHECK(Nota3 >= 0 AND Nota3 <= 100),
	Nota4 INT CHECK(Nota4 >= 0 AND Nota4 <= 100),
	NotaFinal INT CHECK(NotaFinal >= 0 AND NotaFinal <= 100),
	Ativo BIT NOT NULL,
	AlunoId INT FOREIGN KEY REFERENCES Escola.Aluno(Id),
	ProfessorId INT FOREIGN KEY REFERENCES Escola.Professor(Id),
	DisciplinaCursoId INT FOREIGN KEY REFERENCES Escola.DisciplinaCurso(Id)
);
GO

CREATE TABLE Secretaria.Pagamentos(
	Id INT PRIMARY KEY IDENTITY,
	Boleto DATE NOT NULL,
	Situacao INT NOT NULL CHECK(Situacao >= 0 AND  Situacao <= 2),
	AlunoId INT FOREIGN KEY REFERENCES Escola.Aluno(Id)
);
GO

CREATE TABLE Secretaria.Inadimplentes(
	Id INT PRIMARY KEY IDENTITY,
	DataRegistro DATE NOT NULL,
	AlunoId INT FOREIGN KEY REFERENCES Escola.Aluno(Id)
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
		PRINT('Nome deve ter 3 caracteres no mínimo.')
		RETURN
	END
	IF (LEN(@CPF) <> 11)
	BEGIN
		PRINT('CPF deve ter 11 caracteres obrigatoriamente.')
		RETURN
	END
	IF (dbo.MaiorDeIdade(@DataNascimento) = 0)
	BEGIN
		PRINT('O usuário deve ter 18 anos de idade ou mais.')
		RETURN
	END

	INSERT
		INTO Escola.Aluno
		VALUES (@Nome, @CPF, @DataNascimento, 1)										/* Situação de novo */
END
GO


CREATE PROCEDURE PInsertProfessor(@Nome VARCHAR(100), @CPF CHAR(11))
AS
BEGIN
	IF (LEN(@Nome) < 3)
	BEGIN
		PRINT('Nome deve ter 3 caracteres no mínimo.')
		RETURN
	END
	IF (LEN(@CPF) <> 11)
	BEGIN
		PRINT('CPF deve ter 11 caracteres obrigatoriamente.')
		RETURN
	END

	INSERT
		INTO Escola.Professor
		VALUES (@Nome, @CPF)
END
GO


CREATE PROCEDURE PInsertCurso(@Nome VARCHAR(50))
AS
BEGIN
	IF (LEN(@Nome) < 3)
	BEGIN
		PRINT('Nome deve ter 3 caracteres no mínimo.')
		RETURN
	END

	INSERT
		INTO Escola.Curso
		VALUES (@Nome, 1)
END
GO

CREATE PROCEDURE PInsertDisciplina(@Nome VARCHAR(50))
AS
BEGIN
	IF (LEN(@Nome) < 3)
	BEGIN
		PRINT('Nome deve ter 3 caracteres no mínimo.')
		RETURN
	END

	INSERT
		INTO Escola.Disciplina
		VALUES (@Nome, 1)
END
GO

CREATE PROCEDURE PInsertDisciplinaCurso(@NomeCurso VARCHAR(50), @NomeDisciplina VARCHAR(50))
AS
BEGIN
	DECLARE @CursoId INT
	DECLARE @DisciplinaId INT

	SELECT
		@CursoId = Id
		FROM Escola.Curso
		WHERE Nome = @NomeCurso
	
	SELECT
		@DisciplinaId = Id
		FROM Escola.Disciplina
		WHERE Nome = @NomeDisciplina

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


CREATE PROCEDURE PInsertTurma(@AlunoId INT, @ProfessorId INT, @DisciplinaCursoId INT)
AS
BEGIN
	
END
GO

/*
CREATE PROCEDURE PInsertPagamentos(@AlunoId INT, @Boleto DATE)
AS
BEGIN
	
END
GO

CREATE PROCEDURE PInsertInadimplentes(@AlunoId INT, @DataRegistro DATE)
AS
BEGIN
	
END
GO

CREATE PROCEDURE PInsertLog(@Tabela VARCHAR(25), @Comando VARCHAR(50), @MensagemErro VARCHAR(MAX), @Data DATE)
AS
BEGIN
	
END
GO


 Updates 

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

CREATE PROCEDURE PUpdatePagamentos(@AlunoId INT, @Boleto DATE)
AS
BEGIN
	
END
GO

CREATE PROCEDURE PUpdateInadimplentes(@AlunoId INT, @DataRegistro DATE)
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

CREATE PROCEDURE PDeletePagamentos(@AlunoId INT, @Boleto DATE)
AS
BEGIN
	
END
GO

CREATE PROCEDURE PDeleteInadimplentes(@AlunoId INT, @DataRegistro DATE)
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
