select * from customers;
select * from accounts;
select * from transactions;
select * from branch;
select * from users;
select * from employees;
select * from credentials;
use CSKBank;

update accounts set created_at = opening_date;

update transactions set remarks = "None" where transaction_id = 90;
select * from accounts where account_number>3 and user_id between 2 and 5;
select * from users where user_id = '1' or first_name = 'Sharan';

select balance, status from accounts where account_number = 5;

insert into users(first_name, last_name, date_of_birth, gender, address, mobile, email, type) value ('ADMIN', 'USER', 1, 'MALE', 'Address', 9876543210, 'admin@email.com', 'EMPLOYEE');
insert into credentials value(1, 'd3fc50c8f714cebd16d6c827826df01205bf519529f9d34775293cf9b70a420e');
insert into credentials value(11, '3493a3cc08b41bbfec1665c867445ec22520db289570e220aef4a6e9ac2f4e25');
insert into branch(address, phone, email, ifsc_code) value('Karaikudi', 9775635324, 'karakudi@cskbank.in', 'CSKB0001111');
insert into employees(user_id, role, branch_id) value(1, '0', 1);

alter table transactions drop primary key;
alter table transactions add primary key (transaction_id, user_id, viewer_account_number);
drop table transactions;

update users set user_id = 1 where user_id = 1;
update credentials set password = 'd3fc50c8f714cebd16d6c827826df01205bf519529f9d34775293cf9b70a420e' where user_id = 1;
update credentials set password = '3493a3cc08b41bbfec1665c867445ec22520db289570e220aef4a6e9ac2f4e25' where user_id = 11;
update credentials set pin = '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4';

update employees set role = 'ADMIN' where role = '0';
select opening_date from accounts where account_number = 4;
update accounts set last_transacted_at =1709528357319 where account_number = 4;
select * from employees where branch_id = 1 limit 10 offset 0;
update users set type = 'EMPLOYEE' where user_id = 7;

insert into branch (address, phone, email) value ('cbe', 9999999998, 'cbe@lksng.ocm');
insert into branch (address, phone, email) value ('Chennai', 9909754836, 'chennai@cskbank.com');
update branch set ifsc_code = 'CSKB0000004' where branch_id = 4;
update transactions set transaction_type = '1' where transaction_id = 1 and viewer_account_number = 2;
update accounts set balance = 12500.0, status = '0', last_transacted_at = 1710234706172 where account_number = 1 and not status = '3';

select distinct users.*, customers.* from users, customers, accounts users where accounts.branch_id = 1 and accounts.user_id = customers.user_id and customers.user_id = users.user_id;

select * from transactions where viewer_account_number = 1 and time_stamp between 1704475707312 and 1712251707312 order by transaction_id desc limit 10 offset 30;
select count(*) from transactions where viewer_account_number = 1 and time_stamp between 1704475707312 and 1712251707312;

select * from transactions where viewer_account_number = 2 and time_stamp between 1712251118176 and 1709659118176 order by transaction_id desc limit 10 offset 0;

select * from accounts where branch_id = 1;

update accounts set status = "1" where account_number in (8, 15);

select * from transactions where viewer_account_number = 2 and time_stamp between 1709977871500 and 1712569871500 order by transaction_id desc limit 10 offset 0;
update accounts set status = '3' where account_number = 1 and branch_id = 7;


ALTER TABLE branch  
ADD COLUMN created_at BIGINT NOT NULL,
ADD COLUMN modified_by INT NOT NULL,
ADD COLUMN modified_at BIGINT NULL,
ADD FOREIGN KEY (modified_by) REFERENCES employees(user_id);

