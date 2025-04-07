-- cria tabela log_evento
create table log_evento (
    id_log int auto_increment primary key,
    mensage varchar(255),
    data_log datetime default current_timestamp
);

-- cria função para calcular a idade de um usuário com base na data de nascimento
create function calcula_idade(datanascimento date) returns int
deterministic
contains sql
begin
    declare idade int;
    set idade = timestampdiff(year, datanascimento, curdate());
    return idade;
end $$

delimiter ;

-- cria função para verificar o status do sistema
delimiter $$

create function status_sistema() 
returns varchar(50)
no sql
begin
   return 'sistema em funcionamento';
end $$

delimiter ;

-- cria função para calcular o total de compras de um usuário
delimiter $$

create function total_compras_usuario(id_usuario int)
returns int
reads sql data
begin
    declare total int;
    select count(*) into total
    from compra c
    where id_usuario = c.fk_id_usuario;
    return total;
end $$

delimiter ;

-- cria função para registrar um log de evento
delimiter $$

create function registrar_log_evento(texto varchar(255))
returns varchar(50)
deterministic
modifies sql data
begin
    insert into log_evento (mensage) 
    values (texto);
    return 'log registrado com sucesso!';
end $$

delimiter ;

-- verifica se a função foi criada corretamente
show create function calcula_idade;

-- testa a function calcula_idade
select calcula_idade('1990-01-01') as idade;

-- testa a function calcula_idade com dados da tabela usuario
select name, calcula_idade(data_nascimento) as idade
from usuario;

-- testa a function status_sistema
select status_sistema();

-- testa a function total_compras_usuario
select total_compras_usuario(1) as total_compras_usuario;

-- deleta as funções criadas
drop function if exists calcula_idade;
drop function if exists status_sistema;
drop function if exists total_compras_usuario;
drop function if exists registrar_log_evento;

-- exibe o create da função registrar_log_evento
show create function registrar_log_evento;

show variables like 'log_bin_trust_function_creators' ;

set global log_bin_trust_function_creators = 1;

select registrar_log_evento('teste') as log; 

delimiter $$
create function mensagem_boas_vindas(nome_usuario varchar(100))
returns varchar(255)
deterministic
contains sql
begin
   declare msg varchar(255);
   set msg = concat('Ola,', nome_usuario, '! Seja bem-vindo ao Sistema VIO.' );
   return msg;
end $$
delimiter ;
