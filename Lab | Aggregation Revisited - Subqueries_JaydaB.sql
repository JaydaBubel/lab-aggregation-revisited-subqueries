use sakila;

#Select the first name, last name, and email address of all the customers who have rented a movie.
select c.first_name, c.last_name, c.email
from customer c
join rental r on c.customer_id = r.customer_id;

#average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
select c.customer_id,
concat(c.first_name, ' ', c.last_name) as customer_name,
avg(p.amount) as average_payment
from customer c
join payment p on c.customer_id = p.customer_id
group by c.customer_id, customer_name;

#Select the name and email address of all the customers who have rented the "Action" movies.
select c.first_name, c.last_name, c.email
from customer c
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
join film_category fc on f.film_id = fc.film_id
join category cat on fc.category_id = cat.category_id
where cat.name = 'Action';

#Same query, using sub queries with multiple WHERE clause and IN condition
select first_name, last_name, email
from customer
where customer_id in (
select distinct c.customer_id
from customer c
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
join film_category fc on f.film_id = fc.film_id
join category cat on fc.category_id = cat.category_id
where cat.name = 'Action'
);
#Yes; both queries produce the same results.


#Use the case statement to create a new column, classifying existing columns as either or high value transactions based on the amount of payment
select payment_id,
amount,
case
when amount between 0 and 2 then 'low'
when amount between 2 and 4 then 'medium'
when amount > 4 then 'high'
end as payment_label
from payment;