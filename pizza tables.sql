create database Dominos;
use Dominos;

create table orders (
order_id int not null,
order_date date not null,
ordet_tiem time not null,
primary key(order_id)
);

alter table orders rename column ordet_tiem to order_time;

create table orders_details (
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key(order_details_id)
);