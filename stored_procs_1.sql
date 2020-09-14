

drop table if exists accounts;

create table accounts (
    id int generated by default as identity,
    name varchar(100) not null,
    balance dec(15, 2) not null,
    primary key(id)
);

insert into accounts(name, balance)
values('Raju', 10000);

insert into accounts(name, balance)
values('Nikhil', 10000);


select * from accounts;


-- The following query creates a stored procedure named transfer that transfers
-- a specified amount of money from one account to another.


create or replace procedure transfer(
   sender int,
   receiver int, 
   amount dec
)
language plpgsql    
as $$
begin
    -- subtracting the amount from the sender's account 
    update accounts 
    set balance = balance - amount 
    where id = sender;

    -- adding the amount to the receiver's account
    update accounts 
    set balance = balance + amount 
    where id = receiver;

    commit;
end;$$


-- The below statement invokes the transfer stored procedure to transfer $1, 000 from Raju’s account to Nikhil’s account:
call transfer(1, 2, 1000);

SELECT * FROM accounts;

call transfer(2, 1, 5000);

SELECT * FROM accounts;

call transfer(1, 2, 5000);