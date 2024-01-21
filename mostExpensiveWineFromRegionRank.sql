/* Which province has the highest average wine price? */

with
province_avg as
	(
	select
		province 
		,round(avg(price), 2) as avg_price
	from winemag_data wd 
	group by 1
	),
no_duplicate as 
	(
	select 
		province 
		,count(province) as province_designation_nr 
	from winemag_data wd2
	group by 1 
	having count(wd2.province) > 1 
	)
select
	nd.province
	,pa.avg_price
	,rank() over 
		(order by pa.avg_price desc) as price_rank_nr
from winemag_data wd  
join province_avg pa 	on pa.province = wd.province
join no_duplicate nd 	on nd.province = pa.province
group by 1, 2
limit 17 
