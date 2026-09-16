/* Update the existing personimmunizationconfigids with the new personimmunizationconfigids */

with newpersonimmunizationconfigids as (
	select personimmunizationconfigid, value_text, description from personimmunizationconfig where immunizationkey is not null
), oldpersonimmunizationconfigids as (
	select personimmunizationconfigid, value_text, description from personimmunizationconfig p where immunizationkey is null
)
update personimmunization p
set personimmunizationconfigid = id.personimmunizationconfigid,
old_id = od.personimmunizationconfigid,
updatedby = 'CIDM-8099', updatedon = now()
from oldpersonimmunizationconfigids od, newpersonimmunizationconfigids id
where od.personimmunizationconfigid = p.personimmunizationconfigid
and p.vaccineadministered is null 
and p.personimmunizationconfigid is not null
and id.value_text = od.value_text;
