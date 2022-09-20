use sakila;

-- Select the first name, last name, and email address of all the customers who have rented a movie.

select * from rental;
select first_name, last_name, email from customer;

select c.first_name, c.last_name, c.email, r.rental_id from customer c
left join rental r
using(customer_id)
group by email
order by rental_id asc;



-- What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

select * from payment; -- customer_id, amount, rental_id
select * from customer; -- customer_id, names

select c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS 'Customer Name', avg(p.amount) as average from customer c
left join payment p
using(customer_id)
group by customer_id
;



-- Select the name and email address of all the customers who have rented the "Action" movies.

select * from customer; -- customer_id, first/last_name♥, email♥ 1
select * from category; -- category_id♥, name (Action = 1) 5
select * from film_category; -- film_id, category_id 4 
select * from inventory; -- inventory_id, film_id 3
select * from rental; -- inventory_id, customer_id 2
	
    
    # Write the query using multiple join statements
    
select c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS 'Customer Name', c.email from customer c
left join rental r using(customer_id)
left join inventory i using(inventory_id)
left join film_category fc using( film_id)
left join category ca using(category_id)
where category_id = 1
group by customer_id
order by customer_id asc;

    #Write the query using sub queries with multiple WHERE clause and IN condition
    
select customer_id, CONCAT(first_name, ' ', last_name) AS 'Customer Name', email from customer
where customer_id in (
	select customer_id from (
		select inventory_id, customer_id from rental
        where inventory_id in (
			select inventory_id from (
					select inventory_id, film_id from inventory
                    where film_id in (
						select film_id from (
							select film_id, category_id from film_category
                            where category_id in (
								select category_id from (
									select category_id, name from category
                                    where category_id = 1
								)sub1
							)
						)sub2
					)
			)sub3
		)
	)sub4
)
group by customer_id
order by customer_id asc;
								
    
    
-- Verify if the above two queries produce the same results or not

		# Yes, they produce the exact same result
        
        
        
-- Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment.
-- If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.

select * from payment;

select *,
case
when amount between 0 and 2 then "LOW"
when amount between 2 and 4 then "MEDIUM"
when amount > 4 then 'HIGH'
else null
end as "Classification"
from payment;