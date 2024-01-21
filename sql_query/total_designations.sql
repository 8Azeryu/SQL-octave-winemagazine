/*most popular province ranking by amount of designations, among tasters */

with
nrd as
(
select	
	province 
	,count(id) as nr_of_designations 
from winemag_data wd 
group by 1
)
select 
	province
	,nr_of_designations
from nrd
order by nr_of_designations desc
limit 17
