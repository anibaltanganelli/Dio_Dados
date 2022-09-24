-- Criação do Banco de Dados para ocenário do E-commerce

create database if not exists ecommerce;
use ecommerce;

create table clients(
idClient int not null auto_increment primary key,
Fname varchar(45) not null,
Minimit char(3),
Lname varchar(30),
CPF char(9),
CNPJ char(15),
Gender enum ('F', 'M', 'Pessoa Jurídica') default 'Pessoa Jurídica',
constraint unique_cpf_client unique (CPF),
constraint unique_cnpj_client unique (CNPJ),
Street_name varchar (45),
Street_number int,
District varchar(20),
City varchar(25),
State char (2),
Birth_date date not null,
Phone_number int
);
alter table clients auto_increment =1;

select*from clients;

create table if not exists supplier(
id_supplier int not null auto_increment primary key,
SocialName varchar(50),
CNPJ char(15) unique not null,
supplier_phone char(11),
contact varchar(20),
constraint unique_supplier unique (CNPJ)
);
alter table supplier auto_increment= 1;

create table product(
idproduct int not null auto_increment primary key,
Pname varchar(45) not null,
Psupplier int,
classification_kids bool not null default 0,
category enum('Brinquedo', 'Eletrônico', 'Vestuário', 'Alimento', 'Móveis') not null,
price decimal (10,2) not null,
descriptio varchar(10),
avaliation float default 0,
constraint fk_product_supplier foreign key (Psupplier) references supplier(id_supplier)
);
alter table product auto_increment =1;
select*from product;

create table payment(
idpayment int not null auto_increment primary key,
idClient int,
payment_form enum('cartão', 'dois cartões', 'boleto') not null,
cc_name varchar (45),
cc_number int,
cc_validity date,
constraint fk_payment_client foreign key (idClient) references clients(idClient)
);
alter table payment auto_increment =1;

create table order_(
idorder int not null auto_increment primary key,
idOrderClient int, 
Id_payment int,
order_status ENUM('Em andamento', 'Processando', 'Enviado', 'Cancelado', 'Entregue') default 'Processando',
order_description varchar(450),
Send_value float default 10 not null,
Date_order date not null,
constraint fk_order_client foreign key(idOrderClient) references clients(idClient),
constraint fk_payment foreign key (Id_payment) references payment(idpayment)
on update cascade
on delete set null
);
alter table order_ auto_increment =1;

select*from order_;

create table if not exists productStorage(
id_Pstorage int not null auto_increment primary key,
id_product int,
Pstorage_location varchar(80) not null,
Quantity int default 0,
constraint fk_id_product foreign key (id_product) references product(idproduct)
);
alter table productStorage auto_increment =1;

create table if not exists seller(
id_seller int not null auto_increment primary key,
SellerSocialName varchar(50),
Abstname varchar(255),
CNPJ char(15) unique,
CPF char (9) unique,
location varchar(45),
seller_phone char(11) not null,
constraint unique_cpf_seller unique (CPF),
constraint unique_cnpj_seller unique (CNPJ)
);
alter table seller auto_increment= 1;

create table productSeller(
idPpseller int,
idPproduct int, 
ProdQuantity int default 1,
primary key (idPpseller, idPproduct),
constraint fk_product_seller foreign key(idPpseller) references seller(id_Seller),
constraint fk_product_product foreign key(idPproduct) references product(idproduct)
);
alter table productSeller auto_increment= 1;

create table productOrder(
idproduct_order int,
idpedido_order int,
PoQuantity int default 0,
poStatus ENUM('Disponível', 'Fora de estoque') default 'Disponível',
primary key (idproduct_order, idpedido_order),
constraint idproduct_order foreign key (idproduct_order) references product(idproduct),
constraint idepedido_order foreign key (idpedido_order) references order_(idorder)
);
alter table productOrder auto_increment= 1;

create table storage_location(
idLstorage int,
idLproduct int,
Estado char(2) not null,
primary key (idLstorage, idLproduct),
constraint fk_product_storage foreign key(idLstorage) references productStorage(id_Pstorage),
constraint fk_product_location foreign key(idLproduct) references product(idproduct)
);
alter table storage_location auto_increment= 1;

create table product_supplier(
idPsSupplier int,
idPsProduct int,    
primary key (idPsSupplier, idPsProduct),
constraint fk_product_Ssupplier foreign key (idPsSupplier) references supplier(id_supplier),
constraint fk_product_Sproduct foreign key (idPsproduct) references product(idproduct)
);
alter table product_supplier auto_increment= 1;

insert into clients (Fname, Minimit, Lname, CPF, CNPJ, Gender, Street_name, Street_number, District, City, State,  Birth_date, Phone_number)
values ('João', 'F', 'Paula', '252321589', null, 'M', 'Rua Nova', '256', 'Novo Mundo', 'Sumaré', 'SP', '1987/12/23', 1788562255),
('Cláudia', 'C', 'Porto', '87532697', null, 'F','Rua Sol','25', 'Colina', 'Santos', 'SP', '1955/01/29', 1399885522),
('Maria', 'S', 'Loureiro', '356789452', null, 'F','Rua Cravo','15', 'Girassol', 'Santos', 'SP', '1955/01/29', 1998885555),
('Natália', 'T', 'Oliveira', '555889452', null, 'F','Rua dois', '18', 'Jd Itália', 'Campinas', 'SP', '1982/12/5', 1977785555),
('Auto Escola Dois', null, null, null,'12345678912345', null, 'Av Indústria',  '158', 'Santa Maria', 'Americana', 'SP', '1980/05/14', 1992225314),
('Funilaria Camargo', null, null, null, '98745678912365', null, 'Rua Uruguai','33', 'Molon', 'Americana', 'SP', '1980/05/14', 1992225314),
('Paulo', 'C', 'Carmo', '298987651', null, 'M','Rua da curva', '168', 'Jd Amanda', 'Carapicuiba', 'SP', '1978/06/29', 1119885555),
('Adilson', 'S', 'Tarso', '123689458', null, 'M','Rua Brasil', '125', 'Dom Pedro', 'Santos', 'SP', '1955/01/29', 1998885555),
('Amália', 'V', 'Antunes', '574289452', null, 'F','Rua oito', '18', 'Jd Cláudia', 'Campinas', 'SP', '1990/11/5', 1877785555),
('Casa dos freios', null, null, null,'33345655512345', null,'Av Suíça',  '150', 'Guanabara', 'Americana', 'SP', '1980/05/14', 1997985314),
('Josiele', 'W', 'Oliveira', '333889452', null, 'F','Rua A', '155', 'Jd Europa', 'Campinas', 'SP', '1999/11/5', 1976560555),
('A. Comércio de Doces', null, null, null,'89875678912345', null,'Rua Etiópia',  '11', 'Pq das Nações', 'Natal', 'RN', '1980/05/14', 1992225314),
('Clara', 'T', 'Badaró', '123489452', null, 'F','Rua diamante', '1238', 'Jd dos Lírios', 'BH', 'Mg', '2000/09/5', 1971455555),
('Auto Escola Dois', null, null, null, '12348878912345', null,'Av Indústria',  '158', 'Santa Maria', 'Americana', 'SP', '1980/05/14', 1992225314),
('Marcos', 'P', 'Camargo', '513889411', null, 'M','Rua Pau Brasil', '14', 'Jd Santana', 'Terezina', 'PI', '2001/01/08', 1473785522),
('Auto Escola Dois', null, null, null, '88845678912345', null,'Av Indústria',  '158', 'Santa Maria', 'Americana', 'SP', '1980/05/14', 1992225314);

insert into supplier (SocialName, CNPJ, supplier_phone, contact) values
                    ('Faz de tudo', 123456789127896, '199198459', 'Cláudia'),
                    ('Casa João', 889658789127201, '193365459', 'João'),
                    ('Dois Irmãos', 563017891278124, '198798459', 'Lúcio'),
                    ('EMF Ltda', 245639789127855, '199174501', 'Adelaide'),
                    ('AjK comércio', 887965849127874, '192256459', 'Lindomar'),
                    ('Silva & Silva', 165432189121123, '199198459', 'Cláudia');
select*from product;
Insert into product (Psupplier, Pname, classification_kids, category, price, descriptio, avaliation)
values (1,'Boneca Maria', 1, 'Brinquedo', 95, 'pequena', 4.3),
(1,'Boneco Rambo', 1, 'Brinquedo', 105, 'pequeno', 4.1),
(1,'Boneca Barbie', 1, 'Brinquedo', 190, 'pequena', 4.2),
(1,'Boneca Xuxa', 1, 'Brinquedo', 250, 'grande', 4.8),
(2,'Boneco Fofão', 1, 'Brinquedo', 240, 'grande', 4.4),
(2,'Carrinho corrida', 1, 'Brinquedo', 23.9, 'pequeno', 5),
(3,'Bola futebol', 1, 'Brinquedo', 35, 'padrão', 5),
(3,'Skate', 1, 'Brinquedo', 195, 'padrão', 4),
(4,'Pc Gamer', 0, 'Eletrônico',3000, 'Completo', 4.9),
(5,'PS4', 0, 'Eletrônico',2000, 'Completo', 4.9),
(5,'Iphone2', 0, 'Eletrônico',1000, 'Antigo', 4.5),
(6,'Calça Jeans', 0, 'Vestuário',150, '44', 3.5),
(6,'Calça Jeans', 0, 'Vestuário',150, '46', 3.5),
(6,'Calça Jeans', 0, 'Vestuário',150, '48', 3.5),
(6,'Calça Jeans Feminina', 0, 'Vestuário',150, '38', 3.5),
(6,'Calça Jeans Feminina', 0, 'Vestuário',150, '40', 3.5),
(6,'Calça Jeans Feminina', 0, 'Vestuário',150, '42', 3.5),
(6,'Calça Jeans Feminina', 0, 'Vestuário',150, '44', 3.5),
(4,'Miojo', 0, 'Alimento',3, 'Galinha', 3.5),
(4,'Miojo', 0, 'Alimento',3, 'Carne', 3.5),
(4,'Biscoito Polvinho', 0, 'Alimento',2.90, '300 gr', 4),
(4,'Bala toffe', 0, 'Alimento',8, '100 gr', 5),
(2,'Mesa', 0, 'Móveis',1500.00 , '2x09', 3.5),
(2,'Armário', 0, 'Móveis',900.00 , '2x2', 4);

select * from payment;
Insert into payment (idClient, payment_form, cc_name, cc_number, cc_validity)
values (1, 'boleto', null, null, null),
	   (2, 'boleto', null, null, null),
       (3, 'boleto', null, null, null),
       (4, 'cartão', 'Lídio Aldo', 155555556, '2030/08/12'),
       (5, 'boleto', null, null, null),
	   (6, 'boleto', null, null, null),
       (7, 'cartão', 'Paula Cristina', 876542314, '2028/01/10'),
       (8, 'boleto', null, null, null),
       (3, 'boleto', null, null, null),
       (4, 'cartão', 'Lídio Aldo', 898586987, '2030/08/15'),
       (5, 'boleto', null, null, null),
	   (6, 'boleto', null, null, null),
       (7, 'cartão', 'Paula Cristina', 876542314, '2028/01/10'),
       (8, 'boleto', null, null, null),
       (9, 'cartão', 'Pompeu Gomes', 555333269, '2023/12/30'),
       (10, 'cartão', 'Giovana Silva', 689567832, '2025/01/15'),
       (11, 'cartão', 'Tereza de Souza', 234578932, '2025/01/10'),
       (12, 'boleto', null, null, null),
       (13, 'boleto', null, null, null),
       (14, 'boleto', null, null, null),
       (15, 'cartão', 'Pedro Souza', 1888567892, '2026/01/10'),
       (16, 'boleto', null, null, null);

select * from payment;
insert into order_ (id_payment, order_status, order_description, Send_Value, Date_order)
values  (1,'Entregue', 'compra via app', default, '2022/05/12'),
        (2,'Entregue', 'compra via web site', default, '2022/08/10'),
        (3,default, 'compra via app', default, '2022/04/10'),
        (4,default, 'compra via app', default, '2022/02/10'),
        (5,'Entregue', 'compra via app', default, '2022/07/14'),
        (6,default, 'compra via web site', default, '2022/06/19'),
        (7,'Enviado', 'compra via app', default, '2022/05/13'),
        (8,default, 'compra via web site', default, '2022/09/16'),
        (9,'Enviado', 'compra via app', default, '2022/05/17'),
        (10,default, 'compra via app', 20, '2022/05/13'),
		(11,'Entregue', 'compra via app', 15, '2022/04/18'),
        (12,'Entregue', 'compra via web site', 30, '2022/01/10'),
        (13,default, 'compra via app', 18, '2022/05/17'),
        (14,default, 'compra via app', 45, '2022/08/10'),
        (15,default, 'compra via web site', default, '2022/06/19'),
        (16,'Enviado', 'compra via app', default, '2022/05/13'),
        (17,default, 'compra via web site', default, '2022/09/16'),
        (18,'Enviado', 'compra via app', default, '2022/05/17'),
        (19,default, 'compra via app', 20, '2022/05/13'),
		(20,'Entregue', 'compra via app', 15, '2022/04/18'),
        (21,'Entregue', 'compra via web site', 30, '2022/01/10'),
        (22,default, 'compra via app', 18, '2022/05/17');

select*from product;

insert into productStorage (id_product, Pstorage_location, Quantity) values
			(1,'Campinas', 5000),
            (2,'Lindóia', 1000),
            (3,'São Paulo', 200),
            (4,'São Paulo', 1560),
            (5,'Sumaré', 10),
            (6,'Americana', 230),
            (7,'Campinas', 100),
            (8,'Lindóia', 300),
            (9,'São Paulo', 200),
            (10,'São Paulo', 162),
            (11,'Sumaré', 10),
            (12,'Campinas', 90),
            (13,'Campinas', 1100),
            (14,'Lindóia', 1300),
            (15,'São Paulo', 200),
            (16,'São Paulo', 5000),
            (17,'Campinas', 100),
            (18,'Lindóia', 300),
            (19,'São Paulo', 200),
            (20,'São Paulo', 100),
            (20,'São Paulo', 500),
            (20,'São Paulo', 1200),
            (20,'São Paulo', 80),
            (20,'São Paulo', 14);



insert into seller (SellerSocialName, Abstname, CNPJ, CPF, location, seller_phone) values
					('E.A Varejo', 'Casa Cláudia', 123456789127896, '185398459', 'Iguape-SP', 'Cláudia'),
                    ('M&E Comérico', 'Marinho', 889123549127201, '113365459', 'São Paulo - SP', 'Marinho'),
                    ('Dois Irmãos', 'Dois irmãos', 134617891278155, '218798459', 'Rio de Janeiro - RJ', 'Lúcio'),
                    ('Ell Ltda', 'Eleonor lojas', 115639789127818, '199555501', 'Americana - SP', 'Leonor'),
                    ('ALL comércio', 'Altamir roupas', 697965849127814, '152256459', 'Paraty - RJ', 'Vera'),
                    ('Silva & Silva', 'Silva Festas', 233232189121158, '192228459', 'Campinas - SP', 'Cláudia');
select * from seller;

desc productSeller;
select*from productSeller;
insert into productSeller (idPpseller, IdPproduct, ProdQuantity) values
						  (1,20,3),
                          (2,19,2),
                          (3,18,5),
                          (4,17,2),
                          (5,16,2),
                          (6,15,5);
						  
select*from product;
select*from order_;
select * from productOrder;
insert into productOrder (idproduct_order, idpedido_order, poQuantity, poStatus) values
(1,22,3,'Disponível'),
(2,21,6,'Disponível'),
(3,19,12,'Disponível'),
(4,20,1,'Disponível'),
(5,17,4,'Disponível'),
(6,18,1,'Disponível'),
(7,15,6,'Disponível'),
(8,16,8,'Disponível'),
(9,14,5,'Disponível'),
(10,12,13,'Disponível'),
(11,13,22,'Disponível'),
(12,11,5,'Disponível'),
(12,9,2,'Disponível'),
(14,10,12,'Disponível'),
(15,6,6,'Disponível'),
(16,8,4,'Disponível'),
(17,7,6,'Disponível'),
(18,5,9,'Disponível'),
(19,3,7,'Disponível'),
(20,4,1,'Disponível'),
(21,2,6,'Disponível'),
(24,1,4,'Disponível');


select*from productStorage;
insert into storage_location (idLstorage, idLproduct, Estado) values
(1,1,'SP'),
(2,2,'SP'),
(3,3,'SP'),
(4,4,'SP'),
(5,5,'SP'),
(6,6,'SP'),
(7,7,'SP'),
(8,8,'SP'),
(9,9,'SP'),
(10,10,'SP'),
(11,11,'SP'),
(12,12,'SP'),
(13,13,'SP'),
(14,14,'SP'),
(15,15,'SP'),
(16,16,'SP'),
(17,17,'SP'),
(18,18,'SP'),
(19,19,'SP'),
(20,20,'SP'),
(20,21,'SP'),
(20,22,'SP'),
(20,23,'SP'),
(20,24,'SP');


show tables;


-- Quantos clientes temos por estado?
select State, count(*) from clients Group by State order by 1 desc;

-- Como está a avaliação de nossos produtos?
select avaliation, count(*) from product Group by avaliation order by 1 desc;

-- Desde quando os produtos estão em processamento?
select idorder as numero_pedido, Date_order as data_pedido
from order_ Pedido
where order_status = 'Processando';

-- Selecione o número do pedido, qual o cliente e qual foi a forma de pagamento.
select idorder as numero_pedido, Fname as Nome, Minimit as Inicial, Lname as Sobrenome,  payment_form as Forma_Pagamento
from Clients as c, Payment as p, order_ as o
where c.idClient = p.idClient and o.idorder = p.idpayment;

-- Qual o nome e sobrenome dos clientes de Campinas?
select Fname, Lname
From suppliers
where city like'%Campinas%';

-- Mais consultas serão elaboradas.