-- create the guitar database
DROP DATABASE IF EXISTS guitarDB;
CREATE DATABASE guitarDB;

use guitarDB;

-- Table for guitars. 
drop table if exists guitars;
create table guitars (
    guitar_id int primary key AUTO_INCREMENT,
    guitar_name varchar(50) NOT NULL unique,
    guitar_type enum('Acoustic', 'Classic', 'Electric', 'Bass', 'Other') not null,
    guitar_model varchar(50) NOT NULL,
    guitar_brand varchar(50) NOT NULL,
    guitar_shortDescription varchar(500) NOT NULL,
    guitar_scale_length double NOT NULL,
    guitar_scale_width double NOT NULL,
    guitar_composite_finish varchar(50) NOT NULL,
    guitar_composite_top varchar(50) NOT NULL,
    guitar_composite_body varchar(50) NOT NULL,
    average_score int,
    lowest_price double 

);

-- Table for retailer store.
drop table if exists retailerStores;
create table retailerStores (
    store_id int auto_increment primary key,
    store_name varchar(50) not null unique,
    store_country varchar(50) not null,
    store_state varchar(50) not null,
    store_street varchar(50) not null,
    store_zipcode int not null,
    store_phone int not null,
    business_hour varchar(500) not null,
    security_code varchar(50) not null
);


-- Table for instrument Company
drop table if exists instrumentCompanies;
create table instrumentCompanies (
    company_id int AUTO_INCREMENT PRIMARY KEY,
    company_name varchar(50) not null unique,
    company_websitePage varchar(500) not null,
    company_email varchar(500) not null,
    company_phoneNum int not null,
	security_code varchar(50) not null
);

-- Table for museums
drop table if exists museums;
create table museums (
    museum_id int primary key AUTO_INCREMENT,
    museum_name varchar(50) NOT NULL unique,
    museum_address_country varchar(50) NOT NULL,
    museum_address_state varchar(50) NOT NULL,
    museum_address_street varchar(50) NOT NULL,
    museum_address_zipcode int NOT NULL,
    museum_phone int NOT NULL,
    business_hour varchar(500) NOT NULL,
	security_code varchar(50) not null
);


-- Table for exhibitions. Museum will post exhibitions of guitars, so it has foreign key of museum_id and guitar_id.
drop table if exists exhibitions;
create table exhibitions (
	exhibition_id int primary key AUTO_INCREMENT,
    museum_id int NOT NULL,
    guitar_id int NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    ticket_price int NOT NULL,
    CONSTRAINT exhibitions_fk_museum_id FOREIGN KEY (museum_id)
        REFERENCES museums (museum_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT exhibitions_fk_guitar_id FOREIGN KEY (guitar_id)
        REFERENCES guitars (guitar_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Table for users. There are four types of users: normal, company representatives, store representatives, museum representatives. 
-- There are four subclasses for each type.
drop table if exists users;
create table users (
    user_id int primary key AUTO_INCREMENT,
    user_name varchar(50) NOT NULL unique,
    user_password varchar(20) not null,
    user_type enum('normal', 'company_representatives', 'store_representatives', 'museum_representatives') not null,
    signup_date TIMESTAMP default current_timestamp not null,  
    user_phone int not null,
    user_address_country varchar(20) not null,
    user_address_state varchar(10) not null,
    user_address_street varchar(20) not null,
    user_address_zipcode int not null 
);

-- Table for normal users.
drop table if exists normal_users;
create table normal_users (
    user_id int primary key,
    user_level enum('lv1', 'lv2', 'lv3', 'lv4', 'lv5', 'lv MAX') default 'lv1',
    CONSTRAINT normal_fk_user_id FOREIGN KEY (user_id)
        REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table for company representatives user
drop table if exists companyRepresentative_users;
create table companyRepresentative_users (
    user_id int NOT NULL,
    company_id int NOT NULL,
    certificate_date TIMESTAMP default current_timestamp not null,  
    primary key (user_id , company_id),
    CONSTRAINT company_represent_fk_user_id FOREIGN KEY (user_id)
        REFERENCES users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT company_represent_fk_company_id FOREIGN KEY (company_id)
        REFERENCES instrumentCompanies (company_id)  ON DELETE CASCADE  ON UPDATE CASCADE
);


-- Table for store representatives user
drop table if exists storeRepresentative_users;
create table storeRepresentative_users (
    user_id int NOT NULL,
    store_id int NOT NULL,
    certificate_date TIMESTAMP default current_timestamp not null,  
    primary key (user_id , store_id),
    CONSTRAINT store_represent_fk_user_id FOREIGN KEY (user_id)
        REFERENCES users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT store_represent_fk_store_id FOREIGN KEY (store_id)
        REFERENCES retailerStores (store_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Table for museum representatives user
drop table if exists museumRepresentative_users;
create table museumRepresentative_users (
    user_id int NOT NULL,
    museum_id int NOT NULL,
    certificate_date TIMESTAMP default current_timestamp not null,  
    primary key (user_id , museum_id),
    CONSTRAINT museum_represent_fk_user_id FOREIGN KEY (user_id)
        REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT museum_represent_fk_museum_id FOREIGN KEY (museum_id)
        REFERENCES museums (museum_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Table for users comments to certain guitar.
drop table if exists comments;
create table comments (
    user_id int NOT NULL,
    guitar_id int NOT NULL,
    contents varchar(500) NOT NULL,
    score int NOT NULL,
    comments_date TIMESTAMP default current_timestamp not null,  
    hasThisGuitar varchar(3) default 'no',
    primary key (user_id , guitar_id),
    CONSTRAINT comments_fk_user_id FOREIGN KEY (user_id)
        REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT comments_fk_guitar_id FOREIGN KEY (guitar_id)
        REFERENCES guitars (guitar_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Table for sale infomation of guitars.
-- Each sale should involve a company, a store and a guitar.
drop table if exists saleInfo;
create table saleInfo (
    saleInfo_id int auto_increment primary key,
    company_id int,
    guitar_id int,
    store_id int,
    sale_price double,
    sale_date  TIMESTAMP default current_timestamp not null,  
    constraint saleInfo_fk_company_id foreign key (company_id)
        references instrumentCompanies (company_id) ON DELETE CASCADE ON UPDATE CASCADE,
    constraint saleInfo_fk_guitar_id foreign key (guitar_id)
        references guitars (guitar_id) ON DELETE CASCADE ON UPDATE CASCADE,
    constraint saleInfo_fk_store_id foreign key (store_id)
        references retailerStores (store_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table for user's favorite guitar list.
drop table if exists favoriteGuitarList;
create table favoriteGuitarList(
user_id int not null,
guitar_id int not null,
primary key (guitar_id, user_id),
constraint favoriteGuitarList_fk_guitar_id
 foreign key (guitar_id) references guitars (guitar_id) ON DELETE CASCADE ON UPDATE CASCADE,
constraint favoriteGuitarList_fk_user_id 
foreign key (user_id) references normal_users (user_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Procedures, functions, triggers and events:
  
-- Check the account name and password when users log in.
-- It will return true when user name and password are correct.
drop function if exists logCheck;
DELIMITER //
create function logCheck
( inputName varchar(50),
  inputPassword varchar(20)
)returns boolean
begin

DECLARE login boolean DEFAULT false;

if inputName in (select user_name from users)
then if inputPassword = (select user_password from users where inputName = user_name)
then set login = true;
end if;
else SIGNAL SQLSTATE 'ME001'
				SET MESSAGE_TEXT = 'Given user name does not exists.';
end if;
return login;
end //
DELIMITER ;


-- A trigger to check if the information user provide is valid when they sign up an account.
drop trigger if exists validUser;
DELIMITER //
create trigger validUser
before insert on users
for each row 
begin 
if new.user_name in (select user_name from users)
then SIGNAL SQLSTATE 'ME001'
				SET MESSAGE_TEXT = 'This user name is already occupied.';
end if;

if char_length(new.user_name) > 50
then signal sqlstate 'ME001' set message_text = 'Length of user name is too long. It should be no more than 50 characters.';
end if;

if char_length(new.user_password) > 20
then signal sqlstate 'ME001' set message_text = 'Length of password is too long. It should be no more than 20 characters or numbers.';
end if;

if new.user_phone > 99999999999
then signal sqlstate 'ME001' set message_text = 'The length of phone is too long. It should be 10 or 11 digits.';
end if;

if new.user_phone in (select user_phone from users)
then signal sqlstate 'ME001' set message_text = 'This phone number have been used to sign up before.
 You can find your account, by seding message to us.';
end if;

if char_length(new.user_address_country) > 20
then signal sqlstate 'ME001' set message_text = 'Length of country name is too long. It should not be more than 20 characters.';
end if;

if char_length(new.user_address_state) > 10
then signal sqlstate 'ME001' set message_text = 'Length of state is too long, It should not be more than 10 characters.';
end if;

if char_length(new.user_address_street) > 20
then signal sqlstate 'ME001' set message_text = 'Length of street is too long. It should not be more than 20 characters.';
end if;

if new.user_address_zipcode > 999999
then signal sqlstate 'ME001' set message_text = 'Length of the zip code is too long. It should be less than 6 numbers.';
end if;

end // 
DELIMITER ;


-- sign up:
-- Sign up a normal account. 
-- To sign up an account users need to type user name, password, phone number, country, state, street and zipcode.
drop procedure if exists signUpNormal;
DELIMITER //
create procedure signUpNormal(
  user_name varchar(50),
  user_password varchar(20), 
  user_phone int,
  user_address_country varchar(20) ,
  user_address_state varchar(10) ,
  user_address_street varchar(20) ,
  user_address_zipcode int
)begin

insert into users values(0, user_name,  user_password, 'normal', null, user_phone, user_address_country,
user_address_state, user_address_street, user_address_zipcode);
end //
DELIMITER ;

-- A trigger when normal user is signed up, it will help to add this user to normal user table.
drop trigger if exists insertANormal;
DELIMITER //
create trigger insertANormal
after insert on users
for each row
begin
if new.user_type = 'normal'
then insert into normal_users values(new.user_id, 'lv1'); 
end if;

end //
DELIMITER ;



-- sign up a company representative.
-- It will ask user name, password, phone number, country, state, street, zipcode, companyName 
-- and securtiy code issued by that company.
drop procedure if exists signUpCompanyR;
DELIMITER //
create procedure signUpCompanyR(
  user_name varchar(50),
  user_password varchar(20), 
  user_phone int,
  user_address_country varchar(20),
  user_address_state varchar(10),
  user_address_street varchar(20),
  user_address_zipcode int,
  companyName varchar(50),
  securityCode varchar(50)
)begin
declare insertedId int;
declare companyId varchar(50);

if companyName not in (select company_name from instrumentCompanies)
then signal sqlstate 'ME001' set message_text = 'Given company name does not exsit. Try again.';
end if;

set companyId = (select company_id from instrumentCompanies where company_name = companyName);

if (securityCode = (select security_code from instrumentCompanies where companyName = company_name))
then insert into users values(0, user_name,  user_password, 'company_representatives', null, user_phone, user_address_country,
user_address_state, user_address_street, user_address_zipcode);
set insertedId = (select user_id from users us where user_name = us.user_name);
insert into companyRepresentative_users values(insertedId, companyId, current_timestamp);

end if;
end //
DELIMITER ;


-- To sign up a store representative. It's similar to sign up a company representative, but will ask store name and the security code.
drop procedure if exists signUpStoreR;
DELIMITER //
create procedure signUpStoreR(
  user_name varchar(50),
  user_password varchar(20), 
  user_phone int,
  user_address_country varchar(20),
  user_address_state varchar(10),
  user_address_street varchar(20),
  user_address_zipcode int,
  storeName varchar(50),
  securityCode varchar(50)
)begin
declare insertedId int;
declare storeId int;


if storeName not in (select store_name from retailerStores)
then signal sqlstate 'ME001' set message_text = 'Given store name does not exsit. Try again.';
end if;

set storeId = (select store_id from retailerStores where store_name = storeName);


if (securityCode = (select security_code from retailerStores rs where rs.store_name = storeName))
then insert into users values(0, user_name,  user_password, 'store_representatives', null, user_phone, user_address_country,
user_address_state, user_address_street, user_address_zipcode);
set insertedId = (select user_id from users us where user_name = us.user_name);
insert into storeRepresentative_users values(insertedId, storeId, current_timestamp);

end if;
end //
DELIMITER ;

-- To sign up a museum representative. 
-- It's similar to sign up a copmany representative but will ask museum name and the security code.
drop procedure if exists signUpMuseumR;
DELIMITER //
create procedure signUpMuseumR(
  user_name varchar(50),
  user_password varchar(20), 
  user_phone int,
  user_address_country varchar(20),
  user_address_state varchar(10),
  user_address_street varchar(20),
  user_address_zipcode int,
  museumName varchar(50),
  securityCode varchar(50)
)begin
declare insertedId int;
declare museumId int;

if museumName not in (select museum_name from museums)
then signal sqlstate 'ME001' set message_text = 'Given museum name does not exsit. Try again.';
end if;

set museumId = (select museum_id from museums where museum_name = museumName);

if (securityCode = (select security_code from museums ms where ms.museum_name = museumName))
then insert into users values(0, user_name,  user_password, 'museum_representatives', null, user_phone, user_address_country,
user_address_state, user_address_street, user_address_zipcode);
set insertedId = (select user_id from users us where user_name = us.user_name);
insert into museumRepresentative_users values(insertedId, museumId, current_timestamp);


end if;
end //
DELIMITER ;


-- Users can use this procedure to check its own information according to their user types.
drop procedure if exists showOwnUserInfor;
DELIMITER //
create procedure showOwnUserInfor
( 
   user_name_given varchar(50),
   password_gvien varchar(50)
)
begin
	declare get_user_id  int;
    declare user_type_given varchar(50);
    
	if user_name_given not in (select user_name from users)
    then SIGNAL SQLSTATE 'ME001'
				SET MESSAGE_TEXT = 'Given user name does not exists.';
	elseif password_gvien <> (select user_password from users where  user_name = user_name_given ) 
    then SIGNAL SQLSTATE 'ME001'
				SET MESSAGE_TEXT = 'Incorrect Password.';
	else  
	select user_id, user_type into get_user_id, user_type_given from users 
    where user_name = user_name_given and user_password = password_gvien;
    end if; 
    
    if (user_type_given = 'normal') then
    select * from users join normal_users using (user_id) where get_user_id = user_id;
    elseif (user_type_given = 'store_representatives') then
    select * from users join storerepresentative_users using (user_id) where get_user_id = user_id;
	elseif (user_type_given = 'company_representatives') then
    select * from users join companyrepresentative_users using (user_id) where get_user_id = user_id;
	elseif (user_type_given = 'museum_representatives') then
	select * from users join museumrepresentative_users using (user_id) where get_user_id = user_id;
    else SIGNAL SQLSTATE 'ME001'
				SET MESSAGE_TEXT = 'Wrong type for user name'; 
	end if;
  
end //
DELIMITER ;

/*
call showOwnUserInfor('first', 'password');
call showOwnUserInfor('companyWang', '1234');
call showOwnUserInfor('storeLi', '1235');
call showOwnUserInfor('museumLiu', '1236');
*/


-- Users can use this procedure to update their personal information.
-- They can edit any field they want. They could leave some filed as blank and those blank filed will be set as null and won't update
-- the filed in the database.
drop procedure if exists editCommonUserInformation;
DELIMITER //
create procedure editCommonUserInformation
( 
	user_name_given varchar(50),
    password_gvien varchar(50),

	user_name_new varchar(50),
    user_password_new varchar(50),
    user_phone_new int,
    user_address_country_new varchar(50),
    user_address_state_new varchar(50),
    user_address_street_new varchar(50),
    user_address_zipcode_new int(11)
   
)
begin
	declare get_user_id  int;
    
	if user_name_given not in (select user_name from users)
    then SIGNAL SQLSTATE 'ME001'
				SET MESSAGE_TEXT = 'Given user name does not exists.';
	elseif password_gvien <> (select user_password from users where  user_name = user_name_given ) 
    then SIGNAL SQLSTATE 'ME001'
				SET MESSAGE_TEXT = 'Incorrect Password.';
	else  
	select user_id into get_user_id from users 
    where user_name = user_name_given and user_password = password_gvien;
    end if; 


	if (user_name_new is not null) then
	update users set user_name = user_name_new where user_id = get_user_id;
    end if;
    
	if (user_password_new is not null) then
	update users set user_password = user_password_new where user_id = get_user_id;
    end if;
    
	if (user_phone_new is not null) then
	update users set user_phone = user_phone_new where user_id = get_user_id;
    end if;
    
	if (user_address_country_new is not null) then
	update users set user_address_country = user_address_country_new where user_id = get_user_id;
    end if;
    
	if (user_address_state_new is not null) then
	update users set user_address_state = user_address_state_new where user_id = get_user_id;
    end if;
    
	if (user_address_street_new is not null) then
	update users set user_address_street = user_address_street_new where user_id = get_user_id;
    end if;
    
	if (user_address_zipcode_new is not null) then
	update users set user_address_zipcode = user_address_zipcode_new where user_id = get_user_id;
    end if;
end //
DELIMITER ;

/*
call showOwnUserInfor('second', '123');
call showOwnUserInfor('companyWang', '1234');
call showOwnUserInfor('storeLi', '1235');
call showOwnUserInfor('museumLiu', '1236');

select * from users;
call editCommonUserInformation('second', '123', null, 'lala' , null , null, null, null, null);
call editCommonUserInformation('second', 'lala', 'haha', '123' , null , null, null, null, null);
call editCommonUserInformation('second', '123', null, null , 672139994 , 'China', 'XiAn', 'anyWhere', 13244321);
*/


-- This procedure is designed for company representatives to check all information of the companies they represent.
drop procedure if exists showCompanyInforByrepresentative;
DELIMITER //
create procedure showCompanyInforByrepresentative
( 
   company_name_given varchar(50)
)
begin
    
    if (company_name_given not in (select company_name from instrumentcompanies))
    then SIGNAL SQLSTATE 'ME001'
				SET MESSAGE_TEXT = 'Given company name is not availbale for company representatives';
	else select company_id, company_name, company_websitePage, 
         company_email, company_phoneNum from instrumentcompanies where company_name = company_name_given;
	end if;
  
end //
DELIMITER ;



-- This procedure is designed for store representatives to check all information of the stores they represent.
drop procedure if exists showRetailInforByrepresentative;
DELIMITER //
create procedure showRetailInforByrepresentative
( 
   store_name_given varchar(50)
)
begin
    
    if (store_name_given not in (select store_name from retailerstores))
    then SIGNAL SQLSTATE 'ME001'
				SET MESSAGE_TEXT = 'Given store is not availbale for retail representatives';
	else  select store_id, store_name, store_country, store_state, store_street, store_zipcode, store_phone, 
		   business_hour from retailerstores  where store_name = store_name_given;
	end if;

end //
DELIMITER ;


-- This procedure is designed for museum representatives to check all information of the museums they represent.
drop procedure if exists showMuseumInforByrepresentative;
DELIMITER //
create procedure showMuseumInforByrepresentative
( 
   museum_name_given varchar(50)
)
begin
    
    if (museum_name_given not in (select museum_name from museums))
    then SIGNAL SQLSTATE 'ME001'
				SET MESSAGE_TEXT = 'Given museum name is not availbale for retail representatives';
	else  select museum_id, museum_name, museum_address_country, museum_address_state, 
    museum_address_street, museum_address_zipcode, museum_phone, business_hour 
    from museums where museum_name = museum_name_given;
	end if;

end //
DELIMITER ;


-- To Edit company information by representative, 
-- Representative needs to provide secuty code, representative id and other information he wants to update.
drop procedure if exists editCompanyInfor;
DELIMITER //
create procedure editCompanyInfor
(
	security_code_given varchar(50),
    user_name_given varchar(50),
    company_name_given varchar(50),
    company_websitePage_given varchar(500),
    company_email_given varchar(500),
    company_phoneNum_given int
)

begin
	declare get_company_id  int;
    declare get_user_id int;
    
	if (user_name_given not in (select user_name from users))
    then SIGNAL SQLSTATE 'ME001'
				SET MESSAGE_TEXT = 'Given user id is not availbale for company representatives';
	else select user_id into get_user_id from users where user_name = user_name_given;
	end if;
    
	select company_id into get_company_id from companyrepresentative_users where user_id = get_user_id;
    
    
    if (security_code_given <> (select security_code from instrumentcompanies where company_id = get_company_id))
	then SIGNAL SQLSTATE 'ME001' 
         SET MESSAGE_TEXT = 'Incorrrect security and cannot modify the company information';
	end if;
    
		if (company_name_given is not null) then
	update instrumentcompanies set company_name = company_name_given where company_id = get_company_id;
    end if;
    
    	if (company_websitePage_given is not null) then
	update instrumentcompanies set company_websitePage = company_websitePage_given where company_id = get_company_id;
    end if;
    
    	if (company_email_given is not null) then
	update instrumentcompanies set company_email = company_email_given where company_id = get_company_id;
    end if;
    
    	if (company_phoneNum_given is not null) then
	update instrumentcompanies set company_phoneNum = company_phoneNum_given where company_id = get_company_id;
    end if;
    
end //
DELIMITER ;

/*
select * from instrumentcompanies;
call editCompanyInfor('AdqwF', 'companyWang', 'anyone', 'https://www.fender.com/', 'ewqfqewa', 312412);
call editCompanyInfor('AdqwF', 'companyWang', 'Martin', 'https://www.martinguitar.com/',
 'info@martinguitar.com <info@martinguitar.com>', null);
*/

-- To edit retailer information by representative, 
-- Representative needs to provide secuty code, representative id and other information he wants to edit.
drop procedure if exists editStoreInfor;
DELIMITER //
create procedure editStoreInfor
(
	security_code_given varchar(50),
    user_name_given varchar(50),
    
    store_name_given varchar(50),
    store_country_given varchar(50),
    store_state_given varchar(50),
    store_street_given varchar(50),
    store_zipcode_given varchar(50),
    store_phone_given int,
    business_hour_given varchar(500)
)
begin
	declare get_retail_id  int;
    declare get_user_id int;
    
    if (user_name_given not in (select user_name from users))
    then SIGNAL SQLSTATE 'ME001'
				SET MESSAGE_TEXT = 'Given user id is not availbale for retail representatives';
	else   select user_id into get_user_id from users where user_name = user_name_given;
	end if;
    
	select store_id into get_retail_id from storerepresentative_users where user_id = get_user_id;
    
    if (security_code_given <> (select security_code from retailerstores where store_id = get_retail_id))
	then SIGNAL SQLSTATE 'ME001' 
         SET MESSAGE_TEXT = 'Incorrrect security and cannot modify the store information';
	end if;
    
		if (store_name_given is not null) then
	update retailerstores set store_name = store_name_given where store_id = get_retail_id;
    end if;
    
		if (store_country_given is not null) then
	update retailerstores set store_country = store_country_given where store_id = get_retail_id;
    end if;
    
		if (store_state_given is not null) then
	update retailerstores set store_state = store_state_given where store_id = get_retail_id;
    end if;
    
		if (store_street_given is not null) then
	update retailerstores set store_street = store_street_given where store_id = get_retail_id;
    end if;
    
    		if (store_zipcode_given is not null) then
	update retailerstores set store_zipcode = store_zipcode_given where store_id = get_retail_id;
    end if;
    
    		if (store_phone_given is not null) then
	update retailerstores set store_phone = store_phone_given where store_id = get_retail_id;
    end if;
    
    		if (business_hour_given is not null) then
	update retailerstores set business_hour = business_hour_given where store_id = get_retail_id;
    end if;
    
  
end //
DELIMITER ;

/*
select * from retailerstores;
call editStoreInfor('EDADASF', 'storeLi', 'Guitar Center', 'Africa', 'test', 'test', 132324, 31124312, 'test');
call editStoreInfor('EDADASF', 'storeLi', 'Guitar Center', 'United States', 'MA', 
   '1295 Huntington Ave # 304, Boston', 2115, 61726077, 'Wednesday 10AM–9PM Thursday 
   10AM–9PM Friday 10AM–9PM Saturday 10AM–8PM Sunday 11AM–7PM
 Monday 10AM–9PM Tuesday 10AM–9PM');
*/

-- To edit museum information by representative, 
-- Representative needs to input secuty code, representative id and other information he wants to edit.
drop procedure if exists editMuseumInfor;
DELIMITER //
create procedure editMuseumInfor
(
	security_code_given varchar(50),
    user_name_given  varchar(50),
    
    museum_name_given varchar(50),
    museum_country_given varchar(50),
    museum_state_given varchar(50),
    museum_street_given varchar(50),
    museum_zipcode_given varchar(50),
    museum_phone_given int,
    business_hour_given varchar(500)
)
begin
	declare get_museum_id  int;
	declare get_user_id int;
    
    if (user_name_given not in (select user_name from users))
    then SIGNAL SQLSTATE 'ME001'
				SET MESSAGE_TEXT = 'Given user id is not availbale for museum representatives';
	else   select user_id into get_user_id from users where user_name = user_name_given;
	end if;
    
	select museum_id into get_museum_id from museumrepresentative_users where  user_id = get_user_id;


    if (security_code_given <> (select security_code from museums where museum_id = get_museum_id))
	then SIGNAL SQLSTATE 'ME001' 
         SET MESSAGE_TEXT = 'Incorrrect security and cannot modify the museum information';
	end if;
    
		if (museum_name_given is not null) then
	update museums set museum_name = museum_name_given where  museum_id = get_museum_id;
    end if;
    
		if (museum_country_given is not null) then
	update museums set museum_address_country = museum_country_given where  museum_id = get_museum_id;
    end if;
    
		if (museum_state_given is not null) then
	update museums set museum_address_state = museum_state_given where  museum_id = get_museum_id;
    end if;
    
		if (museum_street_given is not null) then
	update museums set museum_address_street = museum_street_given where  museum_id = get_museum_id;
    end if;
    
		if (museum_zipcode_given is not null) then
	update museums set museum_address_zipcode = museum_zipcode_given where  museum_id = get_museum_id;
    end if;
    
		if (museum_phone_given is not null) then
	update museums set museum_phone = museum_phone_given where  museum_id = get_museum_id;
    end if;
    
		if (business_hour_given is not null) then
	update museums set business_hour = business_hour_given where  museum_id = get_museum_id;
    end if;
    
  
end //
DELIMITER ;


/*
insert into companyrepresentative_users value(3, 1, null);
insert into storerepresentative_users value(4, 1, null);
insert into museumrepresentative_users value(5, 1, null);
*/
/*
select * from museums;
call editMuseumInfor('132143', 'museumLiu', 'Sphone Hall',  'test', 'test', 'test', 123, 3321, 'test');
call editMuseumInfor('132143', 'museumLiu', 'Sphone Hall',  'USA', 'MA', 'K vermint Street', 321, 43214, '9:00 - 18:00');
*/


-- After users log in sueccessully, they can leave comment for guitars. They could only leave one comment and score for each guitar.
drop procedure if exists leaveComments;
DELIMITER //
create procedure leaveComments
( 
	user_name_given varchar(50),
    guitar_name_given varchar(50),
    comments varchar(500),
    score_given int,
    hasThisGuitar TINYINT 
)
begin
	declare find_guitar_id int;
    declare find_user_id int;

    -- If user log in sucessfully, this will never throw exception.
	if user_name_given not in (select user_name from users)
    then signal sqlstate 'ME001' set message_text = 'User name does not exist.';
    else set find_user_id = (select user_id from users where user_name_given = user_name);
    end if;
    
	if (guitar_name_given not in (select guitar_name from guitars))
    then SIGNAL SQLSTATE 'ME001'
				SET MESSAGE_TEXT = 'Cannot find existing guitar';
	else  select guitar_id into find_guitar_id from guitars where guitar_name = guitar_name_given;
	end if;
    
    -- every id only can score and add comments for one same guitar,
    -- if score twice just exchange with previous one
    if find_user_id in (select user_id from comments where guitar_id = find_guitar_id) then
    update comments set score = score_given where user_id = find_user_id;
    else 
    insert into comments value(find_user_id, find_guitar_id, comments, score_given, null, hasThisGuitar);
    end if;
  
end //
DELIMITER ;

/*

select * from comments;
select * from guitars where guitar_id = 1;

call leaveComments('first', 'Martin 00-42SC', 'that was one wonderful guitar', 45, 0);
call leaveComments('first', 'Martin 00-42SC', 'that was one wonderful guitar', 100, 0);
call leaveComments('second', 'Martin 00-42SC', 'that was one wonderful guitar', 55, 0);
call leaveComments('second', 'Martin 00-42SC', 'that was one wonderful guitar', 70, 0);

select * from favoriteGuitarList;

call addFavouriteList('first', 'Martin 00-42SC');
call addFavouriteList('second', 'Martin 00-42SC');

*/

-- updater average score when the one comment is udpated for one guitar
-- the range of score should become 0 to 100
drop trigger if exists scoreInsert;
DELIMITER //
create trigger scoreInsert
after insert on comments
for each row
begin 
	declare find_guitar_id int;
    declare sum_score int;
    declare count_comments_for_guitar int;
    declare average_score_find int;
	declare add_score int;
    
    set find_guitar_id = new.guitar_id;
    set add_score = new.score;
    
    select average_score into average_score_find from guitars where guitar_id = find_guitar_id;
    select count(distinct user_id) into count_comments_for_guitar from comments where guitar_id = find_guitar_id;
	select sum(score) into sum_score from comments where guitar_id = find_guitar_id;
    
    if (count_comments_for_guitar = 0) then
	update guitars set average_score = add_score where guitar_id = find_guitar_id;
	else
    update guitars set average_score = ( (sum_score + add_score) /  (count_comments_for_guitar + 1) )
    where guitar_id = find_guitar_id;
    end if;
    
    if new.score > 100 or new.score < 0
	then SIGNAL SQLSTATE 'ME001'
				SET MESSAGE_TEXT = 'Incorrect range of score';
end if;


end // 
DELIMITER ;

-- update score of guitar in comments, calculate the average score of guitar again
drop trigger if exists scoreUpdate;
DELIMITER //
create trigger scoreUpdate
after update on comments
for each row 
begin 
	declare find_guitar_id int;
    declare sum_score int;
    declare count_comments_for_guitar int;
    declare average_score_find int;
	declare add_score int;
    
    set find_guitar_id = new.guitar_id;
    set add_score = new.score;
    
    select average_score into average_score_find from guitars where guitar_id = find_guitar_id;
    select count(distinct user_id) into count_comments_for_guitar from comments where guitar_id = find_guitar_id;
	select sum(score) into sum_score from comments where guitar_id = find_guitar_id;
    
    if (count_comments_for_guitar = 0) then
	update guitars set average_score = add_score where guitar_id = find_guitar_id;
	else
    update guitars set average_score = ((sum_score + add_score - old.score) /  count_comments_for_guitar)
    where guitar_id = find_guitar_id;
    end if;
    
    if new.score > 100 or new.score < 0
	then SIGNAL SQLSTATE 'ME001'
				SET MESSAGE_TEXT = 'Incorrect range of score';
end if;


end // 
DELIMITER ;



-- trigger for preventing users from repeating adding same guitars to their favorite lists.
drop trigger if exists favouritelistCheck;
DELIMITER //
create trigger favouritelistCheck
before insert on favoriteguitarlist
for each row 
begin 
if new.guitar_id in (select guitar_id from favoriteguitarlist where user_id = new.user_id)
then SIGNAL SQLSTATE 'ME001'
				SET MESSAGE_TEXT = 'You have added this guitar in your favourite list';
end if;

end // 
DELIMITER ;


-- To add a guitar to favourite list of normal users.
drop procedure if exists addFavouriteList;
DELIMITER //
create procedure addFavouriteList
( 
	user_name_given varchar(50),
    guitar_name_given varchar(50)
)
begin
	declare find_guitar_id int;
    declare find_user_id int;

-- If user log in sucessfully, this will never throw exception.
	if user_name_given not in (select user_name from users)
    then signal sqlstate 'ME001' set message_text = 'User name does not exist.';
    else set find_user_id = (select user_id from users where user_name_given = user_name);
    end if;

	if (guitar_name_given not in (select guitar_name from guitars))
    then SIGNAL SQLSTATE 'ME001'
				SET MESSAGE_TEXT = 'Cannot find existing guitar';
	else  select guitar_id into find_guitar_id from guitars where guitar_name = guitar_name_given;
	end if;
    
    insert into favoriteguitarlist value(find_user_id, find_guitar_id);
  
end //
DELIMITER ;

/*
select * from favoriteGuitarList;
call addFavouriteList('second', 'Martin 00-42SC');
call addFavouriteList('first', 'Martin 00-42SC');
*/

-- To search comments for given guitar's name,
drop procedure if exists searchComments;
DELIMITER //
create procedure searchComments
( 
    guitar_name_given varchar(50)
)
begin
	declare find_guitar_id int;

	if (guitar_name_given not in (select guitar_name from guitars))
    then SIGNAL SQLSTATE 'ME001'
				SET MESSAGE_TEXT = 'Cannot find existing guitar';
	else  select guitar_id into find_guitar_id from guitars where guitar_name = guitar_name_given;
	end if;

    select * from comments where guitar_id = find_guitar_id; 
end //
DELIMITER ;

-- call searchComments('Martin 00-42SC');


/* Show guitar information part */
-- show all guitas information in database.
drop procedure if exists showAllGuitars;
DELIMITER //
create procedure showAllGuitars
( 
)
begin
  select * from guitars;
end //
DELIMITER ;

-- Show guitars by certain brand.
drop procedure if exists searchByBrand;
DELIMITER //
create procedure searchByBrand
( 
   guitar_brand_given varchar(50)
)
begin
  
  select * from guitars where guitar_brand = guitar_brand_given;
  
end //
DELIMITER ;

-- Show guitars by certain type.
drop procedure if exists searchGuitarType;
DELIMITER //
create procedure searchGuitarType
( 
   guitar_type_given varchar(50)
)
begin
  
  select * from guitars where guitar_type = guitar_type_given;
  
end //
DELIMITER ;



-- Post the sale info of guitars.
-- It will need company name, store name, and price of guitars.
drop procedure if exists postSale;
DELIMITER //
create procedure postSale(
companyName varchar(50),
guitarName varchar(50),
storeName varchar(50),
price double
) begin

declare companyId int;
declare guitarId int;
declare storeId int;

if companyName not in (select company_name from instrumentCompanies)
then signal sqlstate 'ME001' set message_text = 'Given company does not exist.';
end if;

if storeName not in (select store_name from retailerStores)
then signal sqlstate 'ME001' set message_text = 'Given store does not exist.';
end if;


if guitarName not in (select guitar_name from guitars)
then signal sqlstate 'ME001' set message_text = 'Given guitar does not exist.';
end if;

if price < 0
then signal sqlstate 'ME001' set message_text = 'Price cannot be negative.';
end if;

set companyId = (select company_id from instrumentCompanies where company_name = companyName);
set guitarId = (select guitar_id from guitars where guitar_name = guitarName);
set storeId = (select store_id from retailerStores where store_name = storeName);

insert into saleinfo values (0, companyId, guitarId, storeId, price, current_timestamp);
end //
DELIMITER ;

/*
select  * from  saleinfo;
select * from guitars;
call postSale('Fender', 'Fender CP-100', 'Guitar Center', 40.0);
call postSale('Fender', 'Fender CP-100', 'Guitar Center', 50.0);
call postSale('Fender', 'Fender CP-100', 'Guitar Center', 30.0);

*/

-- A trigger to update the lowest price of the guitar if there's a new sale posted with lower price.
drop trigger if exists updateLowest;
DELIMITER //
create trigger updateLowest
after insert on saleInfo
for each row
begin

declare higherPrice double;

set higherPrice = (select lowest_price from guitars where guitar_id = new.guitar_id);

if higherPrice is null or higherPrice > new.sale_price
then update guitars set lowest_price = new.sale_price
where  guitar_id = new.guitar_id;
end if;
end //
DELIMITER ;


-- This is for museums to post an exhibition of guitars.
-- It will need gutarName, museumName, start date, end date and ticket price.
drop procedure if exists postExhibition;
DELIMITER //
create procedure postExhibition(
museumName varchar(50),
guitarName varchar(50),
start_date date,
end_date date,
price double
)begin 

declare museumId int;
declare guitarId int;

if museumName not in (select museum_name from museums)
then signal sqlstate 'ME001' set message_text = 'Given museum name does not exist.';
end if;

if guitarName not in (select guitar_name from guitars)
then signal sqlstate 'ME001' set message_text = 'Given guitar does not exist.';
end if;

if price < 0
then signal sqlstate 'ME001' set message_text = 'Price cannot be negative.';
end if;

if end_date < start_date
then signal sqlstate 'ME001' set message_text = 'Please give a correct date.';
end if;


set museumId = (select museum_id from museums where museum_name = museumName);
set guitarId = (select guitar_id from guitars where guitar_name = guitarName);

insert into exhibitions values(0, museumId, guitarId, start_date, end_date, price);
end //
DELIMITER ;

/*
select * from exhibitions;
call postExhibition('museunA', 'Yamaha CSF60', '2012-01-19', '2013-01-19', 100);
*/
-- A procedure to check the end date of exhibtion drop the expired exhibtion.
drop procedure if exists expiredExhibition;
DELIMITER //
create procedure expiredExhibition(
) begin
DECLARE exhibition_var int;
DECLARE endDate_var date;
DECLARE row_not_found	TINYINT DEFAULT FALSE;
DECLARE table_cursor CURSOR FOR 
		SELECT exhibition_id, end_date from exhibitions;
DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET row_not_found = TRUE;
        
SET SQL_SAFE_UPDATES = 0;

OPEN table_cursor;
    
FETCH table_cursor INTO exhibition_var, endDate_var;
 
WHILE row_not_found = FALSE DO

 IF endDate_var < current_date  THEN
 delete from exhibitions where exhibition_id = exhibition_var;
		END IF;
        FETCH table_cursor INTO exhibition_var, endDate_var;
	END WHILE;

    CLOSE table_cursor;
end //
DELIMITER ;

call expiredExhibition;


-- A procedure to chek the date and update normal users level according to their singup date.
drop procedure if exists updateLevel;
DELIMITER //
create procedure updateLevel(
) begin 

    DECLARE userId_var int;
    DECLARE signDate_var timestamp;
    DECLARE yearDiffer int;
    DECLARE totalMonth int;
    DECLARE row_not_found	TINYINT DEFAULT FALSE;
    DECLARE table_cursor CURSOR FOR
		SELECT user_id, signup_date from users where user_type = 'normal';
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET row_not_found = TRUE;
    OPEN table_cursor;
	FETCH table_cursor INTO userId_var, signDate_var;
    WHILE row_not_found = FALSE DO
    set yearDiffer = year(current_date) - year(signDate_var);
    select yearDiffer;
	if yearDiffer = 0
   then set totalMonth = month(current_date) - month(signDate_var);
   else set totalMonth = yearDiffer * 12 + 12 - month(signDate_var) + month(current_timestamp);
   end if;
   select totalMonth;

   IF totalMonth >= 1 && totalMonth < 3 then
   update normal_users set user_level = 'lv2' where user_id = userId_var;
   elseif totalMonth >= 3 && totalMonth < 5 then
   update normal_users set user_level = 'lv3' where user_id = userId_var;
   elseif totalMonth >= 5 && totalMonth <7 then
   update normal_users set user_level = 'lv4' where user_id = userId_var;
   elseif totalMonth >= 7 && totalMonth < 12 then
   update normal_users set user_level = 'lv5' where user_id = userId_var;
   elseif totalMonth >= 12 then
   update normal_users set user_level = 'lv Max' where user_id = userId_var;
   END IF;
FETCH table_cursor INTO userId_var, signDate_var;
END WHILE;
    
    CLOSE table_cursor;

end //
DELIMITER ;

insert into users values(6, 'saleGood', 'password', 'normal', '2012-01-19', 012331326, 'US', 'MA', 'C st.', 01000);
call updateLevel();

set global event_scheduler = on; 

-- A event call expiredExhibition, updateLevel everday.
drop event if exists guitar_engine;
delimiter //
create event guitar_engine
on schedule every 1 day
do begin
call expiredExhibition;
call updateLevel;
end //

delimiter ;



-- insert a guitar information
drop procedure if exists createAGuitar;
DELIMITER //
create procedure createAGuitar(
gName varchar(50),
gType varchar(50),
gModel varchar(50),
gBrand varchar(50),
gShortD varchar(500),
gLength double,
gWidth double,
gFinish varchar(50),
gTop varchar(50),
gBody varchar(50)
)begin

if char_length(gName) > 50
then signal  sqlstate 'ME001' set message_text = 'Guitar name is too long.';
end if;

if gType not in ('Acoustic', 'Classic', 'Electric', 'Bass', 'Other')
then signal  sqlstate 'ME001' set message_text = 'Guitar type did not exist.';
end if;


if char_length(gModel) > 50
then signal  sqlstate 'ME001' set message_text = 'Guitar model lentgh is too long.';
end if;

if char_length(gBrand) > 50
then signal  sqlstate 'ME001' set message_text = 'Guitar brand length is too long.';
end if;


if char_length(gShortD) > 500
then signal  sqlstate 'ME001' set message_text = 'Guitar short description is too long.';
end if;


if gLength < 0
then signal  sqlstate 'ME001' set message_text = 'Guitar length cannot be negative.';
end if;

if gWidth < 0
then signal  sqlstate 'ME001' set message_text = 'Guitar width cannot be negative.';
end if;

if char_length(gFinish) > 50
then signal  sqlstate 'ME001' set message_text = 'Guitar finish is too long.';
end if;

if char_length(gTop) > 50
then signal  sqlstate 'ME001' set message_text = 'Guitar top is too long.';
end if;

if char_length(gBody) > 50
then signal  sqlstate 'ME001' set message_text = 'Guitar body is too long.';
end if;

insert into guitars values(0, gName, gType, gModel, gBrand, gShortD, gLength, gWidth, gFinish, gTop, gBody, null, null);
end //
DELIMITER ;

/*
call createAGuitar('Martif', 'Classic', '00-42SC', 'Martin', 'This parlor guitar is born out of the success of the limited edition (25 pieces) 00-45SC, which were quickly sold out after being launched.',
1, 2, 'Polished Gloss', 'Solid Sitka Spruce', 'Cocobolo');
*/

-- insert a piece of company information
drop procedure if exists createAComp;
DELIMITER //
create procedure createAComp(
cName varchar(50),
cWeb varchar(50),
cEmail varchar(50),
cPhone int,
cSecurity varchar(50)
)begin

if char_length(cName) > 50
then signal  sqlstate 'ME001' set message_text = 'Company name is too long.';
end if;

if char_length(cWeb) > 500
then signal  sqlstate 'ME001' set message_text = 'Company website is too long.';
end if;

if char_length(cEmail) > 50
then signal  sqlstate 'ME001' set message_text = 'Company email is too long.';
end if;

if cPhone > 99999999999
then signal  sqlstate 'ME001' set message_text = 'Check your phone number. It should 10 or 11 digits.';
end if;

if char_length(cSecurity) > 50
then signal  sqlstate 'ME001' set message_text = 'Secrutiy code is too long.';
end if;

insert into instrumentCompanies values(0, cName, cWeb, cEmail, cPhone, cSecurity);
end //
DELIMITER ;

/*
call createAComp('Taylor_kingSaff', 'https://www.taylorguitars.com/', 
'support@taylorguitars.com',  802182, '321423');
*/

-- insert a piece of retail information
drop procedure if exists createAStore;
DELIMITER //
create procedure createAStore(
sName varchar(50),
sCountry varchar(50),
sState varchar(50),
sStreet varchar(50),
sZipcode int,
sPhone int,
sBusinessH varchar(500),
sSecurity varchar(50)
)begin

if char_length(sName) > 50
then signal  sqlstate 'ME001' set message_text = 'Store name is too long.';
end if;

if char_length(sCountry) > 50
then signal  sqlstate 'ME001' set message_text = 'Country name is too long.';
end if;

if char_length(sState) > 50
then signal  sqlstate 'ME001' set message_text = 'State name is too long.';
end if;

if char_length(sStreet) > 50
then signal  sqlstate 'ME001' set message_text = 'Street name is too long.';
end if;

if sZipcode > 999999
then signal  sqlstate 'ME001' set message_text = 'Check your zipcode number. It should be no more than 6 digits.';
end if;

if sPhone > 99999999999
then signal  sqlstate 'ME001' set message_text = 'Check your phone number. It should be no more than 11 digits.';
end if;

if char_length(sBusinessH) > 500
then signal  sqlstate 'ME001' set message_text = 'Retype your bussiness hour. It should be no more than 500 characters.';
end if;


if char_length(sSecurity) > 50
then signal  sqlstate 'ME001' set message_text = 'Security code is too long.';
end if;

insert into retailerStores values(0, sName, sCountry, sState, sStreet, sZipcode, sPhone, sBusinessH, sSecurity);
end //
DELIMITER ;

call createAStore('Guitar Power', 'United States', 'MA', 
  '1295 Huntington Ave # 304, Boston', 02115, 614126077, 
'Wednesday 10AM–9PM Thursday 10AM–9PM Friday 10AM–9PM Saturday 10AM–8PM Sunday 11AM–7PM
Monday 10AM–9PM Tuesday 10AM–9PM', 'EDADASF');


-- insert a piece of museum information
drop procedure if exists createAMu;
DELIMITER //
create procedure createAMu(
mName varchar(50),
mCountry varchar(50),
mState varchar(50),
mStreet varchar(50),
mZipcode int,
mPhone int,
mBusinessH varchar(500),
mSecurity varchar(50)
)begin

if char_length(mName) > 50
then signal  sqlstate 'ME001' set message_text = 'Museun name is too long.';
end if;

if char_length(mCountry) > 50
then signal  sqlstate 'ME001' set message_text = 'Country name is too long.';
end if;

if char_length(mState) > 50
then signal  sqlstate 'ME001' set message_text = 'State name is too long.';
end if;

if char_length(mStreet) > 50
then signal  sqlstate 'ME001' set message_text = 'Street name is too long.';
end if;

if mZipcode > 999999
then signal  sqlstate 'ME001' set message_text = 'Check your zipcode number. It should be no more than 6 digits.';
end if;

if mPhone > 99999999999
then signal  sqlstate 'ME001' set message_text = 'Check your phone number. It should be no more than 11 digits.';
end if;

if char_length(mBusinessH) > 500
then signal  sqlstate 'ME001' set message_text = 'Retype your bussiness hour. It should be no more than 500 characters.';
end if;


if char_length(mSecurity) > 50
then signal  sqlstate 'ME001' set message_text = 'Security code is too long.';
end if;



insert into museums values(0, mName, mCountry, mState, mStreet, mZipcode, mPhone, mBusinessH, mSecurity);
end //
DELIMITER ;

/*
call createAMu('museunWHad', 'USA', 'MA', 'A street', 021132, 00131, '9:00 - 18:00', '13afds3');
*/

-- All Delete!!!
-- Delete comments for users.

/*
DeleteComments: A procedure to delete the certain 
comment. Users will specify the guitar name of the comment they want to delete.
*/
drop procedure if exists deleteComments;
DELIMITER //
create procedure deleteComments(
userName varchar(50),
guitarName varchar(50)
)begin

declare userId int;
declare guitarId int;

if userName not in (select user_name from users)
then signal sqlstate 'ME001' set message_text = 'User name does not exist.';
else set userId = (select user_id from users where user_name = userName);
end if;

if userId not in (select user_id from comments)
then signal sqlstate 'ME001' set message_text ='User did not comment before';
end if;

if guitarName not in (select guitar_name from guitars)
then signal sqlstate 'ME001' set message_text = 'Guitar name does not exist.';
else set guitarId = (select guitar_id from guitars where guitar_name = guitarName);
end if;

if guitarId = (select guitar_id from comments where user_id = userId)
then delete from comments where user_id = userId && guitar_id = guitarId;
else signal sqlstate 'ME001' set message_text = 'User does not comment this guitar before.';
end if;

end//
DELIMITER ;
/*
call leaveComments('saleGood', 'Martin 00-42SC', 'that was one wonderful guitar', 45, 0);
call leaveComments('companyWang', 'Martin 00-42SC', 'that was one wonderful guitar', 100, 0);
call leaveComments('companyWang', 'Yamaha CSF60', 'that was one wonderful guitar', 55, 0);
call leaveComments('second', 'Yamaha CSF60', 'that was one wonderful guitar', 70, 0);
call deleteComments('saleGood', 'Martin 00-42SC' );
*/


-- delete a user
drop procedure if exists deleteUser;
DELIMITER //
create procedure deleteUser(
userName varchar(50),
userPassWord varchar(50)
)begin

declare userId int;
SET SQL_SAFE_UPDATES = 0;


if logcheck(userName, userPassWord)
then set userId = (select user_id from users where user_name = userName);
delete from users where userId = user_id;
else signal sqlstate 'ME001' set message_text = 'Wrong password!!';
end if;
end//
DELIMITER ;



-- Guitars
Insert into guitars values(0, 'Martin 00-42SC', 'Classic', '00-42SC', 'Martin', 'This parlor guitar is born out of the success of the limited edition (25 pieces) 00-45SC, which were quickly sold out after being launched.',
24.9, 1.9, 'Polished Gloss', 'Solid Sitka Spruce', 'Cocobolo', null, null);

Insert into guitars values(0, 'Fender CP-100', 'Acoustic', 'CP-100', 'Fender', 'The CP-100 is a good example of how Fender can lower the price while still retaining respectable quality.',
24.875, 1.69, 'Satin Sunburst', 'Laminated Spruce', 'Laminated Mahogany', null, null);

Insert into guitars values(0, 'Taylor Swift Baby Taylor', 'Acoustic', 'Baby Taylor', 'Taylor', 'Taylor Guitars have granted her a signature version of the popular Baby Taylor, following the same basic features but with a unique design that sets it apart.',
18.8, 1.27, 'Natural', 'Spruce', 'Laminate Sapele', null, null);

Insert into guitars values(0, 'Yamaha CSF60', 'Acoustic', 'CSF60', 'Yamaha', 'If you are looking for a good quality parlor guitar in the second hand market, you should keep your eye out for the Yamaha CSF60.',
24.8, 1.75, 'Tobacco sunburst color', 'Solid Sitka Spruce', 'Solid Sapele', null, null);


Insert into guitars values(0, 'SBG1820A', 'Electric', 'SBG1820A', 'Yamaha', 'Black hardware and parts on the monotone body create a cool look.',
24.75, 1.89, 'Curved Maple', 'Mahogan', 'Mahogany', null, null);

Insert into guitars values(0, 'SBG1802-BL', 'Electric', 'SBG1802-BL', 'Yamaha', 'Vintage SBG look with a pair of Seymour Duncan SP90s. Delivers a wide palette of tone rangingfrom warm solo to bright, crisp comping.',
24.75, 1.79, 'Golden', 'Rosewood', 'Curved Maple',  null, null);

-- Museum
insert into museums values (1, 'museunA', 'USA', 'MA', 'A street', 02120, 00001, '9:00 - 18:00', '132143'), 
(2, 'museunB', 'USA', 'MA', 'B street', 02130, 00002, '9:00 - 18:00', 'qweqw'),
(3, 'museunC', 'USA', 'MA', 'C street', 02120, 00003, '9:00 - 18:00', 'eqw2');

-- Users 
insert into users values(1, 'first', 'password', 'normal', null, 0123345666, 'US', 'MA', 'C st.', 01000);
insert into users values(2, 'second','123', 'normal', null, 894839444, 'US', 'BA', 'Star st.', 02020);
insert into users values(3, 'companyWang','1234', 'company_representatives',
   null, 672139994, 'US', 'LA', 'Vermont.', 08211);
insert into users values(4, 'storeLi','1235', 'store_representatives',
   null, 631239994, 'US', 'LA', 'Vermont.', 08311);
insert into users values(5, 'museumLiu','1236', 'museum_representatives', 
   null, 123329994, 'US', 'LA', 'Vermont.', 08121);

-- Stores
insert into retailerStores value(0, 'Guitar Center', 'United States', 'MA', 
  '1295 Huntington Ave # 304, Boston', 02115, 61726077, 
'Wednesday 10AM–9PM Thursday 10AM–9PM Friday 10AM–9PM Saturday 10AM–8PM Sunday 11AM–7PM
Monday 10AM–9PM Tuesday 10AM–9PM', 'EDADASF');

insert into retailerStores value(0, 'Bay State Vintage Guitars', 'United States', 'MA', 
  '159 Massachusetts Ave Massachusetts Ave, Boston', 02115, 6104311, '
Wednesday 10AM–6PM Thursday 10AM–6PM Friday 10AM–6PM Saturday 10AM–6PM Sunday closed
Monday 10AM–6PM Tuesday 10AM–6PM', 'ED123');

insert into retailerStores value(0, 'Hub Guitar Boston', 'United States', 'MA', 
  '236 Huntington Ave #215, Boston', 02115, 85351947, '
Wednesday Closed Thursday 4–9PM Friday 4–9PM
Saturday 10AM–6PM Sunday 10AM–6PM Monday 4–9PM Tuesday 4–9PM', 'Ada1SF');


-- Companies
Insert into instrumentCompanies value(1, 'Martin', 'https://www.martinguitar.com/', 
'info@martinguitar.com <info@martinguitar.com>',  61075837, 'AdqwF');

Insert into instrumentCompanies value(2, 'Fender', 'https://www.fender.com/', 
'support@fenderguitar.com <info@martinguitar.com>',  8420924, '13213F');

Insert into instrumentCompanies value(3, 'Taylor', 'https://www.taylorguitars.com/', 
'support@taylorguitars.com',  800782, '321423');

Insert into instrumentCompanies value(4, 'Yamaha', 'https://usa.yamaha.com/support/contacts/index.html', 
'support@yamahaguitar.com <info@martinguitar.com>;',  71229011, '43fwq');

insert into instrumentCompanies value(5, 'Aaron Green', 'http://www.aarongreenguitars.com/',
  'aarongreenguitars@gmail.com', 9480006, '1234f');
  
  
insert into companyrepresentative_users value(3, 1, null);
insert into storerepresentative_users value(4, 1, null);
insert into museumrepresentative_users value(5, 1, null);