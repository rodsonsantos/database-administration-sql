-- ========================================================================================
--        FUNDAMENTOS DE SQL – MODELAGEM E ESTRUTURA DE DATABASE (PARTE 1)
-- ========================================================================================

-- Autor: Rodson dos Santos
-- Descrição: Implementação da camada estrutural de um banco de dados corporativo
-- para gestão de Recursos Humanos (RH), contemplando modelagem relacional,
-- criação de tabelas, relacionamentos, histórico funcional e otimização por índices.
-- Objetivo: Evidenciar domínio dos fundamentos de Banco de Dados SQL, com foco em
-- arquitetura, integridade referencial e preparação do ambiente para operações,
-- transações e segurança nas próximas etapas do projeto.

-- ========================================================================================
--                                Reset do Ambiente
-- ========================================================================================
DROP DATABASE IF EXISTS Sistema_corporativo_rh;
CREATE DATABASE Sistema_corporativo_rh
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci;
USE Sistema_corporativo_rh;

-- ========================================================================================
--                                Create table: Criação de Tabelas
-- ========================================================================================
create table funcionarios (
	id_funcionario int not null auto_increment,
	nome varchar(30) not null,
	sobrenome varchar(50),
	telefone char(11),
	data_admissao date,
	id_cargo int not null,
	id_departamento int not null,
	id_gestor int,
	status_funcionario enum('ATIVO','INATIVO','FERIAS','AFASTADO'),
	primary key (id_funcionario)
) default charset = utf8mb4;

create table departamentos (
	id_departamento int not null auto_increment,
    nome_departamento varchar(40) not null,
    id_localizacao int,
    id_gestor int,
    data_criacao date,
    primary key (id_departamento)
) default charset = utf8mb4;

create table cargos (
	id_cargo int not null auto_increment,
    titulo_cargo varchar(50) not null,
    salario_minimo decimal(10,2),
    salario_maximo decimal(10,2),
    nivel_cargo varchar(15),
    primary key (id_cargo)
) default charset = utf8mb4;

create table localizacoes (
	id_localizacao int not null auto_increment,
    cidade varchar(30),
    estado varchar(2),
    pais varchar(20),
    endereco varchar(80),
    cep char(8) not null,
    primary key (id_localizacao)
) default charset = utf8mb4;

create table salarios (
	id_salario int not null auto_increment,
    id_funcionario int not null,
    valor_salario decimal(10,2) not null,
    data_inicio date not null,
    data_fim date,
    salario_ativo boolean not null default 0,
    primary key (id_salario)
) default charset = utf8mb4;

create table historico_funcional (
	id_historico int not null auto_increment,
    id_funcionario int not null,
    id_cargo_anterior int not null,
    id_cargo_novo int not null,
    id_departamento_anterior int not null,
	id_departamento_novo int not null,
    data_alteracao date,
    motivo_alteracao varchar(50),
    primary key (id_historico)
) default charset = utf8mb4;

create table usuarios_sistema (
	id_usuario int not null auto_increment,
    nome_usuario varchar(15) not null,
	perfil_acesso varchar(20) not null,
	id_funcionario int not null,
	data_criacao date,
	ultimo_login datetime,
	usuario_ativo boolean,
    primary key (id_usuario),
    unique (nome_usuario)
) default charset = utf8mb4;

-- ========================================================================================
--              Alter Table: Adicionando Foreign Keys nas tabelas
-- ========================================================================================

-- Funcionarios -> Cargos, Departamentos, Gestores
alter table funcionarios
	add constraint fk_funcionario_cargo
	foreign key (id_cargo)
	references cargos(id_cargo)
	on delete restrict  
	on update cascade,
    
    add constraint fk_funcionario_departamento
    foreign key (id_departamento)
    references departamentos(id_departamento)
    on delete restrict
    on update cascade,
    
	add constraint fk_funcionario_gestor
    foreign key (id_gestor)
    references funcionarios(id_funcionario)
    on delete set null
    on update cascade;
    
-- Departamentos -> Localizacoes, Gestores
alter table departamentos
	add constraint fk_departamento_localizacao
	foreign key (id_localizacao)
	references localizacoes(id_localizacao)
    on delete set null
    on update cascade,
    
	add constraint fk_departamentos_gestor
    foreign key (id_gestor)
    references funcionarios(id_funcionario)
    on delete set null
    on update cascade;

-- Salarios -> Funcionarios
alter table salarios
	add constraint fk_salarios_funcionarios
    foreign key (id_funcionario)
    references funcionarios(id_funcionario)
    on delete cascade
    on update cascade,
    
    add constraint uq_salario_ativo
	unique (id_funcionario, salario_ativo);

-- Historico_funcional -> Funcionarios, Cargos, Departamentos
alter table historico_funcional
-- Conectar funcionarios
	add constraint fk_historico_funcionarios
    foreign key (id_funcionario)
    references funcionarios(id_funcionario)
    on delete restrict
    on update cascade,

	add constraint fk_historico_cargo_anterior
    foreign key (id_cargo_anterior)
    references cargos(id_cargo)
    on delete cascade
    on update cascade,

	add constraint fk_historico_cargo_novo
    foreign key (id_cargo_novo)
    references cargos(id_cargo)
    on delete cascade
    on update cascade,
    
	add constraint fk_historico_departamento_anterior
    foreign key (id_departamento_anterior)
    references departamentos(id_departamento)
    on delete cascade
    on update cascade,
    
	add constraint fk_historico_departamento_novo
    foreign key (id_departamento_novo)
    references departamentos(id_departamento)
    on delete cascade
    on update cascade;
    
-- Usuarios_sistema -> Funcionarios
alter table usuarios_sistema
	add constraint fk_usuarios_funcionarios
    foreign key (id_funcionario)
    references funcionarios(id_funcionario)
    on delete restrict
    on update cascade;

-- ========================================================================================
--                               Create Index: Criando Índices nos ID
-- ========================================================================================

-- Funcionários
create index idx_funcionario_cargo 
on funcionarios(id_cargo);

create index idx_funcionario_departamento
on funcionarios(id_departamento);

create index idx_funcionario_gestor
on funcionarios(id_gestor);

-- Departamentos
create index idx_departamento_localizacao
on departamentos(id_localizacao);

create index idx_departamento_gestor
on departamentos(id_gestor);

-- Salários
create index idx_salario_funcionario
on salarios(id_funcionario);

-- Histórico funcional
create index idx_historico_funcionario 
on historico_funcional(id_funcionario);

create index idx_historico_cargo_novo 
on historico_funcional(id_cargo_novo);

create index idx_historico_departamento_novo 
on historico_funcional(id_departamento_novo);

-- Usuários do sistema
create index idx_usuario_funcionario 
on usuarios_sistema(id_funcionario);

-- Final do Arquivo 1: Verificação de Estrutura
-- Este comando lista as tabelas criadas para confirmar o sucesso do dump.
SHOW TABLES;

-- FIM DA PARTE 1: ESTRUTURA E RELACIONAMENTOS