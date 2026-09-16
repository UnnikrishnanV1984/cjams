/*
select allegationid, "name", updatedby, updatedon
from cjams.allegation
where allegationid = '19233c90-707c-482c-93c8-b33738685fc6'
and activeflag = 1;
*/

update allegation
set "name" = 'Sexual Abuse',
updatedby = 'CDM-17278',
updatedon = now()
where allegationid = '19233c90-707c-482c-93c8-b33738685fc6'
and activeflag = 1;