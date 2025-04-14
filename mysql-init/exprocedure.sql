--  ip da maquina 10.89.240.86


DELIMITER $$

CREATE PROCEDURE resumo_evento(IN pid_evento INT)
BEGIN
    SELECT
        e.nome AS nome,
        e.data_hora AS data,
        total_ingressos_vendidos(pid_evento) AS ingressos_vendidos,
        renda_total_evento(pid_evento) AS renda_arrecadada
    FROM
        evento e
    WHERE
        e.id_evento = pid_evento;
END $$

DELIMITER ;

DELIMITER $$


call resumo_evento(1);






