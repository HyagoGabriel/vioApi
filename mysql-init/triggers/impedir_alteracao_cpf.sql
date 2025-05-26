delimiter // 
create trigger impedir_alteracao_cpf
before update usuario
for each row
BEGIN
    if old.cpf <> new.cpf then 
        signal sqlstate '45000'
        set message_text = 'Não é permitido alterar o CPF de um usuario ja cadastrado';
    end if;
    end; //

    delimiter ;

-- Tentativa de atualizar o nome (valido)
update usuario
set name = 'João da Silva'
where id_usuario = 1;

-- Tentiva de atualizar o CPF (deve gerar erro)
update usuario 
set cpf = '1000000000'
where id_usuario = 1;

create table historico_compra (
    id_historico int auto_increment primary key,
    id_compra int not null,
    data_compra datetime not null,
    id_usuario int not null,
    data_exclusao datetime default current_timestamp
);