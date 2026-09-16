CREATE OR REPLACE FUNCTION cjams.nextbusinessday(from_date date, num_days integer)
 RETURNS date
 LANGUAGE plpgsql
AS $function$ 
declare
v_date date;
begin
	
select d
from (
    select d::date, row_number() over (order by d)
    from generate_series(from_date+ 1, from_date+ num_days* 2+ 5, '1d') d
    where 
        extract('dow' from d) not in (0, 6) 
        ) s into v_date
    where row_number = num_days ;	
   
return v_date;

end    
 $function$
