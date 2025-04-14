-- Criação de function
delimiter $$
create function calcula_idade(datanascimento date)
returns int 
deterministic
contains sql
begin
    declare idade int;
    set idade = timestampdiff(year, datanascimento, curdate());
    return idade ;
end; $$
delimiter ;

-- Verifica s e a função especificada foi criada

SHOW CREATE FUNCTION calcula_idade;

SELECT  name, calcula_idade(data_nascimento) AS idade FROM usuario;


delimiter $$
create function status_sistema()
returns varchar(50)
no sql
begin
    return "Sistema operando normalmente";
end; $$
delimiter ;

select status_sistema();

delimiter $$
create function total_compras_usuario(id_usuario int)
returns int
reads sql data
begin
    declare total int;

    select count(*) into total
    from compra
    where id_usuario = compra.fk_id_usuario;

    return total;

end; $$
delimiter ;

select total_compras_usuario(3)  as "total de compras";

-- Tabela para testar a clausula modifies sql data

create table log_evento (
    id_log int auto_increment primary key,
    mensagem varchar(255),
    data_log datetime default current_timestamp
);

delimiter $$
create function registrar_log_evento(texto varchar(255))
returns varchar(50)
 not deterministic
modifies sql data
begin
    insert into log_evento(mensagem)
    values (texto);

    return 'Log inserido com sucesso';

end; $$
delimiter ;

SHOW CREATE FUNCTION registrar_log_evento;

-- Vizualiza o estado da variavel de controle para permissoes de criação de funções

show variables like 'log_bin_trust_function_creators' ;

-- Alterar a variavel global do MYSQL 
-- precisa ter permissao de adiministrador do banco
set global log_bin_trust_function_creators = 1 ;

select registrar_log_evento('teste') ;

delimiter $$
create function mensagem_boas_vindas(nome_usuario varchar(100))
returns varchar(255)
deterministic
contains sql 
begin
    declare msg varchar(255);
    set msg = concat('Ola, ',nome_usuario, '! Seja bem-vindo(a) ao sistema VIO.');
    return msg;
end; $$
delimiter ;

select mensagem_boas_vindas("Marcos");

select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_schema = 'vio_hyago';

-- maior idade
delimiter $$

create function is_maior_idade(data_nascimento date)
returns boolean
not deterministic
contains sql
begin
declare idade int;
set idade = calcula_idade(data_nascimento);
return idade >= 18;
end; $$

delimiter ;

-- categorizar usuario por faixa etaria
delimiter $$
create function faixa_etaria(data_nascimento date)
returns varchar(20)
not deterministic
contains sql
begin
declare idade int;
set idade = calcula_idade(data_nascimento);
if idade < 18 then
    return 'Menor de idade';
elseif idade < 60 then
    return 'Adulto';
else
    return 'Idoso';
end if;
end; $$
delimiter ;

-- agrupar usuario por faixa etaria

select faixa_etaria(data_nascimento) as faixa, count(*) as quantidade
from usuario
group by faixa;

-- identificar um faixa etaria especifica
select name from usuario
where faixa_etaria(data_nascimento) = 'Adulto';

-- calcula a media de idade de usuarios
delimiter $$
create function media_idade()
returns decimal(5,2)
not deterministic 
reads sql data
begin
declare media decimal(5,2);
select avg(timestampdiff(year, data_nascimento, curdate())) into media
from usuario;
return  ifnull(media, 0);
end; $$
delimiter ;

-- selecionar idade especifica
select "A  media de idade dos cliente é maior que 30: " as resultado where media_idade() > 30;

-- exercicio direcionado
-- calculodo total gasto por usuario
delimiter $$

create function calcula_total_gasto(pid_usuario int)
returns decimal(10,2)
not deterministic
reads sql data
begin
    declare total decimal(10,2);
    
    select sum(i.preco * ic.quantidade) into total
    from compra c
    join ingresso_compra ic on c.id_compra = ic.fk_id_compra
    join ingresso i on i.id_ingresso = ic.fk_id_ingresso
    where c.fk_id_usuario = pid_usuario;
    
    return ifnull(total, 0);
end; $$

delimiter ;

DROP FUNCTION IF EXISTS calcula_total_gasto;

-- buscar a faixa etario de um usuario
DELIMITER $$

CREATE FUNCTION buscar_faixa_etaria_usuario(pid INT)
RETURNS VARCHAR(20)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE faixa VARCHAR(20);
    DECLARE nascimento DATE;

    SELECT data_nascimento INTO nascimento
    FROM usuario
    WHERE id_usuario = pid;

    SET faixa = faixa_etaria(nascimento);

    RETURN faixa;
END$$

DELIMITER ;









