use assignmenty;

## 1 . Create a new table named 'bajaj1' containing the date, close price, 20 Day MA and 50 Day MA. (This has to be done for all 6 stocks)

# bajaj1
create table bajaj1
as (select str_to_date(date, '%e-%M-%Y') as `date`, `close price`, 
avg(`close price`) OVER (ORDER BY str_to_date(date, '%e-%M-%Y') asc ROWS between 19 preceding and current row) AS `20 day MA`, 
avg(`close price`) OVER (ORDER BY str_to_date(date, '%e-%M-%Y') asc ROWS between 49 preceding and current row) AS `50 day MA`
from bajaj);

# eicher1
create table eicher1
as (select str_to_date(date, '%e-%M-%Y') as `date`, `close price`, 
avg(`close price`) OVER (ORDER BY str_to_date(date, '%e-%M-%Y') asc ROWS between 19 preceding and current row) AS `20 day MA`, 
avg(`close price`) OVER (ORDER BY str_to_date(date, '%e-%M-%Y') asc ROWS between 49 preceding and current row) AS `50 day MA`
from eicher);

# hero1
create table hero1
as (select str_to_date(date, '%e-%M-%Y') as `date`, `close price`, 
avg(`close price`) OVER (ORDER BY str_to_date(date, '%e-%M-%Y') asc ROWS between 19 preceding and current row) AS `20 day MA`, 
avg(`close price`) OVER (ORDER BY str_to_date(date, '%e-%M-%Y') asc ROWS between 49 preceding and current row) AS `50 day MA`
from hero);

# infosys1
create table infosys1
as (select str_to_date(date, '%e-%M-%Y') as `date`, `close price`, 
avg(`close price`) OVER (ORDER BY str_to_date(date, '%e-%M-%Y') asc ROWS between 19 preceding and current row) AS `20 day MA`, 
avg(`close price`) OVER (ORDER BY str_to_date(date, '%e-%M-%Y') asc ROWS between 49 preceding and current row) AS `50 day MA`
from infosys);

# TCS1
create table tcs1
as (select str_to_date(date, '%e-%M-%Y') as `date`, `close price`, 
avg(`close price`) OVER (ORDER BY str_to_date(date, '%e-%M-%Y') asc ROWS between 19 preceding and current row) AS `20 day MA`, 
avg(`close price`) OVER (ORDER BY str_to_date(date, '%e-%M-%Y') asc ROWS between 49 preceding and current row) AS `50 day MA`
from tcs);

# TVS1
create table tvs1
as (select str_to_date(date, '%e-%M-%Y') as `date`, `close price`, 
avg(`close price`) OVER (ORDER BY str_to_date(date, '%e-%M-%Y') asc ROWS between 19 preceding and current row) AS `20 day MA`, 
avg(`close price`) OVER (ORDER BY str_to_date(date, '%e-%M-%Y') asc ROWS between 49 preceding and current row) AS `50 day MA`
from tvs
);

## 2. Create a master table containing the date and close price of all the six stocks. (Column header for the price is the name of the stock)

# Master_Table
create table master_table 
as (select `date` ,b.`close price` Bajaj, e.`close price` Eicher, 
h.`close price` Hero, i.`close price` Infosys, t.`close price` TCS, v.`close price` TVS
from bajaj1 b
inner join eicher1 e using (`date`)
inner join hero1 h using (`date`)
inner join infosys1 i using (`date`)
inner join tcs1 t using (`date`)
inner join tvs1 v using (`date`)
);
select * from master_table;

## 3. Use the table created in Part(1) to generate buy and sell signal. Store this in another table named 'bajaj2'. Perform this operation for all stocks.

# bajaj2
create table bajaj2 as
select 
date_value as "date", close_price as "close price",
case when first_value(short_term_greater) over w = nth_value(short_term_greater,2) over w then  'Hold'
	when NTH_VALUE(short_term_greater,2) over w = 'Y' then 'Buy'
	when NTH_VALUE(short_term_greater,2) over w = 'N' then 'Sell'
	else 'Hold'
	end
			
	 AS "Signal" 
	FROM
(
select
		`Date` as date_value,
		`Close Price` AS close_price,
		if(`20 Day MA`>`50 Day MA`,'Y','N') short_term_greater
	from
		bajaj1 
) temp_table
window w as (order by date_value rows between 1 preceding and 0 following);
select * from bajaj2;

# eicher2
create table eicher2 as
select 
date_value as "date", close_price as "close price",
case when first_value(short_term_greater) over w = nth_value(short_term_greater,2) over w then  'Hold'
	when NTH_VALUE(short_term_greater,2) over w = 'Y' then 'Buy'
	when NTH_VALUE(short_term_greater,2) over w = 'N' then 'Sell'
	else 'Hold'
	end
			
	 AS "Signal" 
	FROM
(
select
		`Date` as date_value,
		`Close Price` AS close_price,
		if(`20 Day MA`>`50 Day MA`,'Y','N') short_term_greater
	from
		eicher1
) temp_table
window w as (order by date_value rows between 1 preceding and 0 following);

# hero2
create table hero2 as
select 
date_value as "date", close_price as "close price",
case when first_value(short_term_greater) over w = nth_value(short_term_greater,2) over w then  'Hold'
	when NTH_VALUE(short_term_greater,2) over w = 'Y' then 'Buy'
	when NTH_VALUE(short_term_greater,2) over w = 'N' then 'Sell'
	else 'Hold'
	end
			
	 AS "Signal" 
	FROM
(
select
		`Date` as date_value,
		`Close Price` AS close_price,
		if(`20 Day MA`>`50 Day MA`,'Y','N') short_term_greater
	from
		hero1
) temp_table
window w as (order by date_value rows between 1 preceding and 0 following);

# infosys2
create table infosys2 as
select 
date_value as "date", close_price as "close price",
case when first_value(short_term_greater) over w = nth_value(short_term_greater,2) over w then  'Hold'
	when NTH_VALUE(short_term_greater,2) over w = 'Y' then 'Buy'
	when NTH_VALUE(short_term_greater,2) over w = 'N' then 'Sell'
	else 'Hold'
	end
			
	 AS "Signal" 
	FROM
(
select
		`Date` as date_value,
		`Close Price` AS close_price,
		if(`20 Day MA`>`50 Day MA`,'Y','N') short_term_greater
	from
		infosys1 
) temp_table
window w as (order by date_value rows between 1 preceding and 0 following);

# TCS2
create table tcs2 as
select 
date_value as "date", close_price as "close price",
case when first_value(short_term_greater) over w = nth_value(short_term_greater,2) over w then  'Hold'
	when NTH_VALUE(short_term_greater,2) over w = 'Y' then 'Buy'
	when NTH_VALUE(short_term_greater,2) over w = 'N' then 'Sell'
	else 'Hold'
	end
			
	 AS "Signal" 
	FROM
(
select
		`Date` as date_value,
		`Close Price` AS close_price,
		if(`20 Day MA`>`50 Day MA`,'Y','N') short_term_greater
	from
		tcs1 
) temp_table
window w as (order by date_value rows between 1 preceding and 0 following);

# TVS2
create table tvs2 as
select 
date_value as "date", close_price as "close price",
case when first_value(short_term_greater) over w = nth_value(short_term_greater,2) over w then  'Hold'
	when NTH_VALUE(short_term_greater,2) over w = 'Y' then 'Buy'
	when NTH_VALUE(short_term_greater,2) over w = 'N' then 'Sell'
	else 'Hold'
	end
			
	 AS "Signal" 
	FROM
(
select
		`Date` as date_value,
		`Close Price` AS close_price,
		if(`20 Day MA`>`50 Day MA`,'Y','N') short_term_greater
	from
		tvs1
) temp_table
window w as (order by date_value rows between 1 preceding and 0 following);

## 4. Create a User defined function, that takes the date as input and returns the signal for that particular day (Buy/Sell/Hold) for the Bajaj stock.

# A function has been created for this.
# date format - yyyy-mm-dd
select signal_for_date('2015-09-29') as `signal`;