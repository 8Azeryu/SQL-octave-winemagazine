/* Does the number of points predict the price of the wine? If so, how strong is the correlation? */
with 
point_ranking_a as
(
select 
	id
	,points
	,dense_rank () over 
		(order by points desc)  as point_rank
from winemag_data wd 
group by 1, 2
),
price_ranking_b as
(
select 
	id
	,price 
	,row_number () over (order by price desc) as price_rank
from winemag_data wd
group by 1, 2
),
base as
(
select
	points
	,price
	,id
from winemag_data wd
group by 1, 2 ,3 
),
price_points_ratio as 
(
select
	id 
	,price/points as ratio
from winemag_data wd 
),
ratio_table as
(
select 
	b.id
	,pra.points
	,pra.point_rank
	,prb.price
	,prb.price_rank
	,ppr.ratio
from base b
join point_ranking_a 	pra 	on b.id   = pra.id
join price_ranking_b 	prb		on pra.id = prb.id
join price_points_ratio ppr		on prb.id = ppr.id
having pra.point_rank < 10
order by 3, 5 asc
) 
select *
from ratio_table
where ratio is not null and point_rank < 5

-- average ratio sorted by point rank
