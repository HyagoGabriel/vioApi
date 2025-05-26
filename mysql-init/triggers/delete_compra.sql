delimiter //
create trigger trg_after_delete_compra
after delete on compra 
for each row
begin 
    insert into historico_compra (id_compra,
    data_compra, id_usuario) value
    (old.id_compra, old.data_compra, old.fk_id_usuario);
end; //

delimiter ;

delete from compra where id_compra = 4;

select * from historico_compra;





CREATE TABLE resumo_evento (
    id_evento INT PRIMARY KEY,
    total_ingressos INT
);

DELIMITER //

CREATE TRIGGER atualizar_total_ingressos
AFTER INSERT ON ingresso_compra
FOR EACH ROW
BEGIN
    DECLARE v_id_evento INT;
    DECLARE v_quantidade_comprada INT;


    SELECT i.fk_id_evento, NEW.quantidade
    INTO v_id_evento, v_quantidade_comprada
    FROM ingresso AS i
    WHERE i.id_ingresso = NEW.fk_id_ingresso;

    
    IF EXISTS (SELECT 1 FROM resumo_evento WHERE id_evento = v_id_evento) THEN
        
        UPDATE resumo_evento
        SET total_ingressos = total_ingressos + v_quantidade_comprada
        WHERE id_evento = v_id_evento;
    ELSE
       
        INSERT INTO resumo_evento (id_evento, total_ingressos)
        VALUES (v_id_evento, v_quantidade_comprada);
    END IF;
END //

DELIMITER ;



UPDATE evento
SET data_hora = '2025-08-15 19:00:00'
WHERE id_evento IN (1, 2, 3);



DELETE FROM resumo_evento;


INSERT INTO ingresso_compra(fk_id_compra, fk_id_ingresso, quantidade)
VALUES (1, 1, 4); -- Supondo fk_id_compra = 1 já existe

SELECT * FROM resumo_evento;


INSERT INTO ingresso_compra(fk_id_compra, fk_id_ingresso, quantidade)
VALUES (2, 1, 2);



INSERT INTO ingresso_compra(fk_id_compra, fk_id_ingresso, quantidade)
VALUES (3, 3, 7); 

SELECT * FROM resumo_evento;

