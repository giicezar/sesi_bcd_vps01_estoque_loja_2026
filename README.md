# Projeto: Estoque de Loja de Roupas de Bebê

![MER DER Conceitual](./mer_der_conceitual.png)
![MER DER Lógico](./mer_der_logico.png)

## Dicionário de Dados

| Entidade | Atributo | Tipo | Tamanho| Descrição |
|-|-|-|-|-|
| categoria | id | Inteiro | 11 | Identificador, PK, Auto incrementável |
| categoria | nome | Texto | 100 | Nome da categoria |
| categoria | descricao | Texto | - | Descrição da categoria |
| fornecedor | id | Inteiro | 11 | Identificador, PK, Auto incrementável |
| fornecedor | razao_social | Texto | 100 | Razão social do fornecedor |
| fornecedor | nome_fantasia | Texto | 100 | Nome fantasia do fornecedor |
| fornecedor | cnpj | Texto | 18 | CNPJ do fornecedor |
| fornecedor | email | Texto | 50 | Email do fornecedor |
| fornecedor | telefone | Texto | 15 | Telefone do fornecedor |
| fornecedor | endereco | Texto | 200 | Endereço do fornecedor |
| produto | id | Inteiro | 11 | Identificador, PK, Auto incrementável |
| produto | nome | Texto | 100 | Nome do produto |
| produto | descricao | Texto | - | Descrição do produto |
| produto | preco | Decimal | 10,2 | Preço do produto |
| produto | marca | Texto | 50 | Marca do produto |
| produto | id_categoria | Inteiro | 11 | Identificador da categoria, FK referenciando Categoria (id) |
| produto | id_fornecedor | Inteiro | 11 | Identificador do fornecedor, FK referenciando Fornecedor (id) |
| estoque | id_estoque | Inteiro | 11 | Identificador, PK, Auto incrementável |
| estoque | id_produto | Inteiro | 11 | Identificador do produto, FK referenciando Produto (id) |
| estoque | quantidade | Inteiro | 11 | Quantidade em estoque |
| estoque | quantidade_minima | Inteiro | 11 | Quantidade mínima permitida |
| estoque | localizacao | Texto | 100 | Localização física do produto |
| movimentacao | id_movimentacao | Inteiro | 11 | Identificador, PK, Auto incrementável |
| movimentacao | id_produto | Inteiro | 11 | Identificador do produto, FK referenciando Produto (id) |
| movimentacao | tipo_movimentacao | Enum | - | Tipo da movimentação ('ENTRADA', 'SAIDA') |
| movimentacao | quantidade | Inteiro | 11 | Quantidade movimentada |
| movimentacao | data_movimentacao | Datetime | - | Data e hora da movimentação |

## Dados de teste em CSV
- [categoria.csv](./categoria.csv)
- [fornecedor.csv](./fornecedor.csv)
- [produto.csv](./produto.csv)
- [estoque.csv](./estoque.csv)
- [movimentacao.csv](./movimentacao.csv)

## Script SQL DDL
```sql
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
```

## Script SQL DML
```sql
use estoque_loja;

insert into categoria (id, nome, descricao) values
(1, 'bodies', 'bodies de algodao para bebes'),
(2, 'macacoes', 'macacoes fofos'),
(3, 'vestidos', 'vestidos infantis fofos'),
(4, 'conjuntos', 'conjuntos de roupa para bebes');

insert into fornecedor (id, razao_social, nome_fantasia, cnpj, telefone, email, endereco) values
(1, 'tecidos & mimos ltda', 'algodao doce', '12.345.678/0001-99', '(11) 98765-4321', 'algodaodoce.fornecedor@gmail.com', 'av. paulista 1000'),
(2, 'mini moda ltda', 'mini estilo', '98.765.432/0001-11', '(21) 97654-3210', 'miniestilo.vendas@gmail.com', 'rua oscar freire 250'),
(3, 'confecção & malharia ltda', 'sonho de criança', '34.567.890/0001-12', '(31) 96543-2109', 'sonhodecrianca.atendido@gmail.com', 'rua das flores 321');

insert into produto (id, nome, descricao, preco, marca, id_categoria, id_fornecedor) values
(1, 'body de verao', 'body 100% algodao organico', 80.00, 'algodao doce', 1, 1),
(2, 'macacao de leao', 'macacao com lã suave', 100.00, 'mini estilo', 2, 2),
(3, 'vestido floral', 'vestido com estampa floral', 120.00, 'sonho de criança', 3, 3),
(4, 'conjunto safari', 'conjunto com estampa safari', 200.00, 'mini estilo', 4, 2);

insert into estoque (id_estoque, id_produto, quantidade, quantidade_minima, localizacao) values
(1, 1, 30, 5, 'prateleira 2'),
(2, 2, 20, 3, 'prateleira 1'),
(3, 3, 15, 2, 'prateleira 5'),
(4, 4, 10, 2, 'armario conjuntos');

insert into movimentacao (id_movimentacao, id_produto, tipo_movimentacao, quantidade, data_movimentacao) values
(1, 1, 'ENTRADA', 10, '2026-09-10 00:00:00'),
(2, 2, 'SAIDA', 5, '2026-09-12 00:00:00'),
(3, 3, 'ENTRADA', 8, '2026-09-15 00:00:00'),
(4, 4, 'SAIDA', 3, '2026-09-18 00:00:00');

select * from categoria;
select * from fornecedor;
select * from produto;
select * from estoque;
select * from movimentacao;
```
