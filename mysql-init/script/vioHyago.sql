create database vio_hyago;

use vio_hyago;

create table usuario (
    id_usuario int auto_increment primary key,
    name varchar(100) not null,
    email varchar(100) not null unique,
    password varchar(255) not null,
    cpf char(11) not null unique,
    data_nascimento date not null
);

insert into usuario (name, email, password, cpf, data_nascimento) values
('João Silva', 'joao.silva@example.com', 'senha123', '16123456789', '1990-01-15'),
('Maria Oliveira', 'maria.oliveira@example.com', 'senha123', '16987654321', '1985-06-23'),
('Carlos Pereira', 'carlos.pereira@example.com', 'senha123', '16123987456', '1992-11-30'),
('Ana Souza', 'ana.souza@example.com', 'senha123', '16456123789', '1987-04-18'),
('Pedro Costa', 'pedro.costa@example.com', 'senha123', '16789123456', '1995-08-22'),
('Laura Lima', 'laura.lima@example.com', 'senha123', '16321654987', '1998-09-09'),
('Lucas Alves', 'lucas.alves@example.com', 'senha123', '16654321987', '1993-12-01'),
('Fernanda Rocha', 'fernanda.rocha@example.com', 'senha123', '16741852963', '1991-07-07'),
('Rafael Martins', 'rafael.martins@example.com', 'senha123', '16369258147', '1994-03-27'),
('Juliana Nunes', 'juliana.nunes@example.com', 'senha123', '16258147369', '1986-05-15'),
('Paulo Araujo', 'paulo.araujo@example.com', 'senha123', '16159753486', '1997-10-12'),
('Beatriz Melo', 'beatriz.melo@example.com', 'senha123', '16486159753', '1990-02-28'),
('Renato Dias', 'renato.dias@example.com', 'senha123', '16753486159', '1996-11-11'),
('Camila Ribeiro', 'camila.ribeiro@example.com', 'senha123', '16963852741', '1989-08-03'),
('Thiago Teixeira', 'thiago.teixeira@example.com', 'senha123', '16852741963', '1992-12-24'),
('Patrícia Fernandes', 'patricia.fernandes@example.com', 'senha123', '16741963852', '1991-01-10'),
('Rodrigo Gomes', 'rodrigo.gomes@example.com', 'senha123', '16963741852', '1987-06-30'),
('Mariana Batista', 'mariana.batista@example.com', 'senha123', '16147258369', '1998-09-22'),
('Fábio Freitas', 'fabio.freitas@example.com', 'senha123', '16369147258', '1994-04-16'),
('Isabela Cardoso', 'isabela.cardoso@example.com', 'senha123', '16258369147', '1985-11-08');

create table organizador (
id_organizador int auto_increment primary key,
nome varchar(100) not null,
email varchar(100) not null unique,
senha varchar(50) not null,
telefone char(11) not null
);

insert into organizador (nome, email, senha, telefone) values
('Organização ABC', 'contato@abc.com', 'senha123', '11111222333'),
('Eventos XYZ', 'info@xyz.com', 'senha123', '11222333444'),
('Festivais BR', 'contato@festbr.com', 'senha123', '11333444555'),
('Eventos GL', 'support@gl.com', 'senha123', '11444555666'),
('Eventos JQ', 'contact@jq.com', 'senha123', '11555666777');

create table evento (
    id_evento int auto_increment primary key,
    nome varchar(100) not null,
    descricao varchar(255) not null,
    data_hora datetime not null,
    local varchar(255) not null,
    fk_id_organizador int not null,
    foreign key (fk_id_organizador) references organizador(id_organizador)
);

insert into evento (nome, data_hora, local, descricao, fk_id_organizador) values
    ('Festival de Verão', '2024-12-31 07:00:00', 'Praia Central', 'Evento de Verão', '1'),
    ('Congresso de Tecnologia', '2024-12-31 07:00:00', 'Centro de Convenções', 'Evento de Tecnologia', '2'),
    ('Show Internacional', '2024-12-31 07:00:00', 'Arena Principal', 'Evento Internacional', '3'),
    ('Feira Cultural de Inverno', '2025-07-20 18:00:00', 'Parque Municipal', 'Evento cultural com música e gastronomia', 1);    

create table ingresso (
    id_ingresso int auto_increment primary key,
    preco decimal(5,2) not null,
    tipo varchar(10) not null,
    fk_id_evento int not null,
    foreign key (fk_id_evento) references evento(id_evento)
);

insert into ingresso (preco, tipo, fk_id_evento) values
    (500, 'VIP', '1'),
    (150, 'PISTA', '1'),
    (200, 'PISTA', '2'),
    (600, 'VIP', '3'),
    (250, 'PISTA', '3');

create table compra(
    id_compra int auto_increment primary key,
    data_compra datetime not null,
    fk_id_usuario int not null,
    foreign key (fk_id_usuario) references usuario(id_usuario)
);

insert into compra (data_compra, fk_id_usuario) values
    ("2025-12-30 23:00", 1),
    ("2025-12-30 23:00", 1),
    ("2025-12-30 23:00", 2),
    ("2025-12-30 23:00", 2);

create table ingresso_compra(
    id_ingresso_compra int auto_increment primary key,
    quantidade int not null,
    fk_id_ingresso int not null,
    foreign key (fk_id_ingresso) references ingresso(id_ingresso),
    fk_id_compra int not null,
    foreign key (fk_id_compra) references compra(id_compra)
);

insert into ingresso_compra(fk_id_compra, fk_id_ingresso, quantidade) values
    (1, 4, 5),
    (1, 5, 2),
    (2, 1, 1),
    (2, 2, 2);
     
create table presenca(
    id_presenca int auto_increment primary key,
    data_hora_checkin datetime,
    fk_id_evento int not null,
    foreign key (fk_id_evento) references evento(id_evento),
    fk_id_compra int not null,
    foreign key (fk_id_compra) references compra(id_compra)
);

create table log_evento (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    mensage VARCHAR(255),
    data_log datetime DEFAULT current_timestamp
);
