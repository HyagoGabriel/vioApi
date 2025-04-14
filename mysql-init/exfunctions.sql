--  ip da maquina 10.89.240.86

delimiter //

create function total_ingressos_vendidos(id_evento int)
returns int
d0eterministic
begin
    declare total int;

    select ifnull(sum(ic.quantidade), 0) into total
    from ingresso_compra ic
    join ingresso i on ic.fk_id_ingresso = i.id_ingresso
    where i.fk_id_evento = id_evento;

    return total;
end; //

delimiter ;



delimiter //

create function renda_total_evento(id_evento int)
returns decimal(10,2)
deterministic
begin
    declare total_renda decimal(10,2);

    select ifnull(sum(i.preco * ic.quantidade), 0) into total_renda
    from ingresso_compra ic
    join ingresso i on ic.fk_id_ingresso = i.id_ingresso
    where i.fk_id_evento = id_evento;

    return total_renda;
end; //

delimiter ;



SELECT total_ingressos_vendidos(1) as total_ingressos_vendidos;
SELECT renda_total_evento(1) as renda_total_evento;











