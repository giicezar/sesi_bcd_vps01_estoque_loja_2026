drop database if exists estoque_loja;
create database estoque_loja;
use estoque_loja;

create table produto(
    id int primary key auto_increment,
    nome varchar(100) not null,
    descricao text not null,
    preco decimal(10,2) not null,
    marca varchar(50) not null,
    id_categoria int not null,
    id_fornecedor int not null
);

create table categoria(
    id int primary key auto_increment,
    nome varchar(100) not null,
    descricao text not null
);

create table fornecedor(
    id int primary key auto_increment,
    razao_social varchar(100) not null,
    nome_fantasia varchar(100) not null,
    cnpj varchar(18) not null,
    email varchar(50) not null,
    telefone varchar(15) not null,
    endereco varchar(200) not null
);

create table estoque(
    id_estoque int primary key auto_increment,
    id_produto int not null,
    quantidade int not null,
    quantidade_minima int not null,
    localizacao varchar(100) not null
);

create table movimentacao(
    id_movimentacao int primary key auto_increment,
    id_produto int not null,
    tipo_movimentacao enum('ENTRADA', 'SAIDA') not null,
    quantidade int not null,
    data_movimentacao datetime not null
);

alter table produto add constraint fk_produto_categoria foreign key (id_categoria) references categoria(id);
alter table produto add constraint fk_produto_fornecedor foreign key (id_fornecedor) references fornecedor(id);
alter table estoque add constraint fk_estoque_produto foreign key (id_produto) references produto(id);
alter table movimentacao add constraint fk_movimentacao_produto foreign key (id_produto) references produto(id);

show tables;
describe produto;
describe categoria;
describe fornecedor;
describe estoque;
describe movimentacao;