-- drop database oficina;
create database if not exists oficina;
use oficina;

create table clients (
id_client int not null auto_increment primary key,
Fname varchar (20),
Minit char (3),
Lname varchar (45),
address varchar (60),
cpf char(11),
phone_number varchar(30)
);
alter table clients auto_increment =1;

create table vehicles(
id_vehicle int not null auto_increment primary key,
idVclient int,
manufacturer varchar(15) not null,
caryear year not null,
collor varchar(25) not null,
model varchar(20),
license char (10) not null,
observ varchar (250),
constraint fk_idclient_vehicle foreign key (idVclient) references clients(id_client)
);
alter table vehicles auto_increment =1;

create table evaluation(
id_evaluation int not null auto_increment primary key,
id_Evehicle int,
team_responsible varchar(20) not null,
evaluation ENUM('Revisão', 'Manutenção'),
descriptions varchar(250),
constraint fk_id_Evehicle foreign key (id_Evehicle) references vehicles(id_vehicle)
);
alter table evaluation auto_increment =1;

create table service_order (
id_order int not null auto_increment primary key,
id_evaluation int,
inicial_date date,
status_ ENUM('Aguardando', 'Em andamento', 'Finalizado'),
finish_date date,
descriptions varchar (250)
);
alter table service_order auto_increment =1;

create table services(
id_Sservices int primary key not null auto_increment,
service_name enum('limpeza de bico', 'troca de óleo', 'troca bico ejetor', 'troca de filtro de óleo', 'troca carreia', 
'embreagem', 'freio', 'revisão mil km', 'Revisão 10 mil km', 'Revisão 20 mil km', 'Revisão 30 mil km', 'Revisão 50 mil km',
 'Revisão 90 mil km') not null,
price decimal (6,2) not null,
descriptions varchar(250)
);
alter table services auto_increment =1;

create table performedServices(
id_Sevaluation int,
id_Sservices int,
Quantity int not null,
constraint fk_id_Sevaluation foreign key (id_Sevaluation) references evaluation(id_evaluation),
constraint fk_id_Sservices foreign key (id_Sservices) references services(id_Sservices)
);
alter table performedServices auto_increment =1;

create table material(
id_material int not null auto_increment primary key,
material_name enum('óleo', 'bico ejetor', 'filtro óleo', 'correia', 'pastilha de freio', 'fluído de freio', 'embreagem', 
'farol', 'parafuso'),
price decimal (6,2) not null,
descriptions varchar(250)
);
alter table material auto_increment =1;

create table usedMaterial(
id_Mevaluation int,
id_Mmaterial int,
Quantity int not null,
constraint fk_id_Mevaluation foreign key (id_Mevaluation) references evaluation(id_evaluation),
constraint fk_id_Mmaterial foreign key (id_Mmaterial) references material(id_material)
);
alter table usedMaterial auto_increment =1;

create table Payment(
idpayment int not null auto_increment primary key,
id_Porder int,
payment_form enum('crédito', 'débito', 'pix') not null,
total decimal (6,2),
cc_name varchar (45),
cc_number int,
cc_validity date,
constraint fk_Porder foreign key (id_Porder) references service_order(id_order)
);
alter table payment auto_increment =1;

-- select*from services;
-- select*from evaluation;
-- select*from usedmaterial;
--- show tables;
-- select*from clients;

insert into clients(Fname, Minit, Lname, address, cpf, phone_number) 
values ('Adamastor', 'L', 'Franco', 'Rua dois, 23. Vl Jesus. Campinas-SP', 12345678910, '199999999'),
('Fernanda', 'J', 'Barra', 'Rua Iacanga, 85. Vl Carmem. Campinas-SP', 52325789632, '198889888'),    
('Amâncio', 'G', 'Silva', 'Rua seis, 48. Vl Jesus. Campinas-SP', 88898565745, '1912345655'),
('Alisson', 'B', 'Oliveira', 'Rua Cristal, 165. Vl Iris. Campinas-SP', 23654897821, '197779888'),
('Lúcia', 'A', 'Costa', 'Rua cinco, 789. Vl Jesus. Campinas-SP', 98785213645, '199999333'),
('Fabiana', 'L', 'Cia', 'Rua Itapemirim, 24. Vl Carmem. Campinas-SP', 87968532148, '197789877'),    
('Carla', 'G', 'Luz', 'Rua um, 21. Vl Jesus. Campinas-SP', 77788852368, '1985745242'),
('Ailson', 'Q', 'Neto', 'Rua Carvão, 265. Vl Iris. Campinas-SP', 27825624529, '197129821');

-- select*from vehicles;

insert into vehicles (idVclient, manufacturer, caryear, collor, model, license, observ)
values (1, 'ford', '2018', 'branco', 'fiesta', '1234586281', 'sem riscos'),
(1, 'ford', '2008', 'preto', 'focus', '5554586281', 'arranhão lado esquerdo'),
(2, 'Peugeout', '2020', 'azul', '208', '6874586771', 'calota raspada'),
(3, 'WV', '2019', 'branco', 'Gol', '1544581111', 'sem riscos'),
(3, 'Honda', '2021', 'Dourado', 'fit', '1989586777', 'sem riscos'),
(4, 'Fiat', '2022', 'branco', 'Toro', '2222586781', 'sem riscos'),
(5, 'Fiat', '2018', 'Amarelo', 'Punto', '2344586124', 'Porta motorista amassada'),
(5, 'WV', '2018', 'Prata', 'Pollo', '8888586288', 'sem riscos'),
(6, 'Ford', '2018', 'Vermelho', 'Focus', '5554555281', 'sem riscos'),
(6, 'Fiat', '2016', 'branco', 'Uno', '7237586787', 'sem riscos'),
(6, 'Honda', '2022', 'Prata', 'Civi', '2222586281', 'sem riscos');

-- select*from evaluation;
insert into evaluation (id_Evehicle, team_responsible, evaluation, descriptions)
values (1, 'Jairo', 'Revisão', 'Fazer revisão - verificar km painel'),
(2, 'Fernanda', 'Revisão', 'Fazer revisão - verificar km painel'),
(3, 'Jairo', 'Manutenção', 'trocar óleo'),
(4, 'Jairo', 'Manutenção', 'limpeza de bico'),
(5, 'Carlos', 'Revisão', 'Fazer revisão - verificar km painel'),
(6, 'Fernanda', 'Manutenção', 'Troca de freios'),
(7, 'Fernanda', 'Manutenção', 'Pneu'),
(8, 'Fernanda', 'Revisão', 'Fazer revisão - verificar km painel'),
(9, 'Jairo', 'Revisão', 'Fazer revisão - verificar km painel'),
(10, 'Carlos', 'Revisão', 'Fazer revisão - verificar km painel'),
(11, 'Carlos', 'Manutenção', 'Troca de óleo'),
(3, 'Fernanda', 'Manutenção', 'trocar bico'),
(4, 'Carlos', 'Manutenção', 'Pneu'),
(11, 'Jairo', 'Manutenção', 'limpeza de bico'),
(1, 'Carlos', 'Manutenção', 'limpeza de bico');

insert into services(service_name, price, descriptions) 
values 
('limpeza de bico', 80, 'Padrão'),
('troca de óleo', 120, 'Padrão'),
('troca bico ejetor', 180, 'Padrão'),
('troca de filtro de óleo', 90, 'Padrão'),
('troca carreia', 150, 'Padrão'),
('embreagem', 125, 'Padrão'),
('freio', 220, 'Padrão'),
('revisão mil km', 190, 'óleo e filtros'),
('Revisão 10 mil km', 200, 'óleo e filtros'),
('Revisão 20 mil km', 250, 'óleo, fluídos e filtros'),
('Revisão 30 mil km', 350, 'óleo, fluídos, freios e filtros'),
('Revisão 50 mil km', 250, 'óleo e filtros'),
('Revisão 90 mil km', 350, 'óleo, embreagem e filtros');

-- select*from material;
insert into material (material_name, price, descriptions)
values 
('óleo', 180, 'Shell 4 litros'),
('bico ejetor', 200, 'Jogo com 6'),
( 'filtro óleo', 80, 'Marca Y 30 mil km'),
('correia', 350, 'Genérico'),
('pastilha de freio', 120, 'Genérico'),
('fluído de freio', 150, '1 litro'),
('embreagem', 200, 'Uma unidade'), 
('farol', 65, 'Modelo único'),
('parafuso', 5, 'Genérico');

select*from service_order;
insert into service_order(id_evaluation, inicial_date, status_, finish_date, descriptions) 
values (1, '2022/05/15', 'Finalizado', '2022/05/20', 'Nenhuma nova falha encontrada'),
(2, '2022/05/20', 'Finalizado', '2022/05/20', 'Nenhuma nova falha encontrada'),
(3, '2022/05/22', 'Finalizado', '2022/05/22', 'Incluído balanceamento'),
(4, '2022/05/22', 'Finalizado', '2022/05/22', 'Nenhuma nova falha encontrada'),
(5, '2022/05/25', 'Finalizado', '2022/05/29', 'Incluído balanceamento e troca de vidro'),
(6, '2022/06/01', 'Em andamento', '2022/09/25', 'Nenhuma nova falha encontrada'),
(7, '2022/06/02', 'Finalizado', '2022/06/02', 'Incluído balanceamento'),
(8, '2022/06/20', 'Finalizado', '2022/06/20', 'Nenhuma nova falha encontrada'),
(9, '2022/06/22', 'Finalizado', '2022/06/22', 'Incluído balanceamento'),
(10, '2022/06/27', 'Finalizado', '2022/06/27', 'Nenhuma nova falha encontrada'),
(11, '2022/07/01', 'Em andamento', '2022/09/22', 'Incluído balanceamento'),
(12, '2022/07/02', 'Finalizado', '2022/07/12', 'Nenhuma nova falha encontrada'),
(13, '2022/08/01', 'Finalizado', '2022/08/01', 'Incluído balanceamento'),
(14, '2022/08/20', 'Finalizado', '2022/07/20', 'Nenhuma nova falha encontrada'),
(15, '2022/09/22', 'Aguardando', '2022/10/22', 'Incluído balanceamento');


insert into payment(id_Porder, payment_form, total, cc_name, cc_number, cc_validity) 
values 
(1, 'pix', 350, null, null, null),
(2, 'débito', 550, null, null, null),
(3, 'crédito', 750, 'Lindomar S Silva', 321321321, '2023/08/20'),
(4, 'pix', 450, null, null, null),
(5, 'débito', 950, null, null, null),
(6, 'crédito', 1650, 'Alberto S Silva', 123213456, '2023/08/25'),
(7, 'pix', 1350, null, null, null),
(8, 'débito', 158, null, null, null),
(9, 'crédito', 1050, 'Cláudia A Silva', 123521351, '2023/08/29'),
(10, 'pix', 990, null, null, null),
(11, 'débito', 800, null, null, null),
(12, 'crédito', 450, 'Solange Arruda', 821321321, '2023/08/21'),
(13, 'pix', 3910, null, null, null),
(14, 'débito', 2150, null, null, null),
(15, 'crédito', 8650, 'Marcos Silva', 143213213, '2023/08/22');

-- select*from service_order;
-- select*from performedServices;

insert into performedServices(id_Sevaluation, id_Sservices, Quantity)
values 
(1, 8, 1), 
(2, 9, 1),
(3, 2, 2),
(4, 3, 2),
(5, 10, 1),
(6, 7, 1),
(7, 1, 1),
(8, 13, 1),
(9, 12, 1),
(10, 8, 1),
(11, 4, 1),
(12, 3, 1),
(13, 1, 1),
(14, 3, 1),
(15, 3, 1);

-- select*from material;
insert into usedMaterial(id_Mevaluation, id_Mmaterial, Quantity)
values
(1, 2, 2), 
(2, 9, 4),
(3, 1, 2),
(4, 3, 2),
(5, 4, 5),
(6, 7, 3),
(7, 1, 2),
(8, 8, 2),
(9, 5, 1),
(10, 3, 1),
(11, 4, 2),
(12, 6, 1),
(13, 1, 1),
(14, 8, 2),
(15, 7, 1);