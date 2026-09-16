/*
Create Date :  03/16/2026
Author : Agathya
Description :
Below updates are for registering the CJAMS Ids that are not registered in MDM.
This has 3 sets.
1. Provider data 
2. Adoptive Parents
3. Adoptive Clients

Also updating the DQ issues. 
- Null gendertypekey data is updated to 'U'.
- Blank/empty string ssn no are updated to null. 

*/


update 
cjams.person set 
etl_load_date = '2026-04-09' 
,updatedby= 'CIDM-11251'
,updatedon=now()
where personid in 
( select personid from person p where activeflag = 1
and  EXISTS (
            SELECT 1
            FROM cjams.actor ac
            JOIN cjams.intakeservicerequestactor iar
                ON iar.actorid = ac.actorid AND iar.activeflag = 1
            JOIN prov.tb_provider tp
                ON tp.provider_id::varchar = iar.objectid
                AND iar.objecttype = 'prov_provider'
                AND tp.delete_sw = 'N'
            WHERE
                ac.personid = p.personid
                AND ac.activeflag = 1
        )and not  exists (
select 1 from cjams.personidentifier p2  where p2.personid = p.personid and p2.personidentifiertypekey = 'MDM_ID' and p2.activeflag=1
)  
)
--group by 1
;


update 
cjams.person set 
etl_load_date = '2026-04-09' 
,updatedby= 'CIDM-11251'
,updatedon=now()
where personid in 
( select personid 
from person pr
where pr.activeflag = 1
and not exists
(select pid.personidentifiervalue
from personidentifier pid
where pid.personid = pr.personid
and pid.activeflag = 1
and pid.personidentifiertypekey = 'MDM_ID'
)
and exists
(select adc.*
from adoptioncaseactor adc
where adc.personid = pr.personid
and adc.activeflag = 1
and adc.actortypekey <> 'ADOPTIVEPARENT'
)
)
;

-- 12950
update 
cjams.person set 
etl_load_date = '2026-04-09' 
,updatedby= 'CIDM-11251'
,updatedon=now()
where personid in 
( select personid 
from person pr
where pr.activeflag = 1
and not exists
(select pid.personidentifiervalue
from personidentifier pid
where pid.personid = pr.personid
and pid.activeflag = 1
and pid.personidentifiertypekey = 'MDM_ID'
)
and exists
(select adc.*
from adoptioncaseactor adc
where adc.personid = pr.personid
and adc.activeflag = 1
and adc.actortypekey = 'ADOPTIVEPARENT'
) 
)
;


update person 
set gendertypekey = 'U'
,updatedby= 'CIDM-11251'
,updatedon=now()
where etl_load_date = '2026-04-09'
and gendertypekey is null
; 
     

update cjams.person 
set updatedby= 'CIDM-11251'
,updatedon=now()
	, ssnno = null 
where etl_load_date = '2026-04-09'::date
and ssnno = ''
;
	 
--select count(1) from person where etl_load_date = '2026-04-09';

--select count(1) from person where etl_load_date = '2026-04-09' and gendertypekey is null ; 

--select count(1) from person where etl_load_date = '2026-04-09' and ssnno = ''; 

--select dob,insertedon, * from person where etl_load_date = '2026-04-09' and dob <= '1900-01-01' ; --8 - invalid dob

/*

-- Provider persons not in MDM.
select  count(1)
from person p 
where p.activeflag = 1
and  EXISTS (
            SELECT 1
            FROM cjams.actor ac
            JOIN cjams.intakeservicerequestactor iar
                ON iar.actorid = ac.actorid AND iar.activeflag = 1
            JOIN prov.tb_provider tp
                ON tp.provider_id::varchar = iar.objectid
                AND iar.objecttype = 'prov_provider'
                AND tp.delete_sw = 'N'
            WHERE
                ac.personid = p.personid
                AND ac.activeflag = 1
        )
and not  exists (
select 1 from cjams.personidentifier p2  where p2.personid = p.personid and p2.personidentifiertypekey = 'MDM_ID' and p2.activeflag=1
)
union all
select count(1)
from person pr
where pr.activeflag = 1
and not exists
(select pid.personidentifiervalue
from personidentifier pid
where pid.personid = pr.personid
and pid.activeflag = 1
and pid.personidentifiertypekey = 'MDM_ID'
)
and exists
(select adc.*
from adoptioncaseactor adc
where adc.personid = pr.personid
and adc.activeflag = 1
and adc.actortypekey <> 'ADOPTIVEPARENT'
)
union all 
-- Adoption Parents .. some of these are going to be part of provider persons
select count(1)
from person pr
where pr.activeflag = 1
and not exists
(select pid.personidentifiervalue
from personidentifier pid
where pid.personid = pr.personid
and pid.activeflag = 1
and pid.personidentifiertypekey = 'MDM_ID'
)
and exists
(select adc.*
from adoptioncaseactor adc
where adc.personid = pr.personid
and adc.activeflag = 1
and adc.actortypekey = 'ADOPTIVEPARENT'
) 
;

select count(distinct personid) from (
select  p.personid
from person p 
where p.activeflag = 1
and  EXISTS (
            SELECT 1
            FROM cjams.actor ac
            JOIN cjams.intakeservicerequestactor iar
                ON iar.actorid = ac.actorid AND iar.activeflag = 1
            JOIN prov.tb_provider tp
                ON tp.provider_id::varchar = iar.objectid
                AND iar.objecttype = 'prov_provider'
                AND tp.delete_sw = 'N'
            WHERE
                ac.personid = p.personid
                AND ac.activeflag = 1
        )
and not  exists (
select 1 from cjams.personidentifier p2  where p2.personid = p.personid and p2.personidentifiertypekey = 'MDM_ID' and p2.activeflag=1
)
union all
select pr.personid
from person pr
where pr.activeflag = 1
and not exists
(select pid.personidentifiervalue
from personidentifier pid
where pid.personid = pr.personid
and pid.activeflag = 1
and pid.personidentifiertypekey = 'MDM_ID'
)
and exists
(select adc.*
from adoptioncaseactor adc
where adc.personid = pr.personid
and adc.activeflag = 1
and adc.actortypekey <> 'ADOPTIVEPARENT'
)
union all 
-- Adoption Parents .. some of these are going to be part of provider persons
select pr.personid
from person pr
where pr.activeflag = 1
and not exists
(select pid.personidentifiervalue
from personidentifier pid
where pid.personid = pr.personid
and pid.activeflag = 1
and pid.personidentifiertypekey = 'MDM_ID'
)
and exists
(select adc.*
from adoptioncaseactor adc
where adc.personid = pr.personid
and adc.activeflag = 1
and adc.actortypekey = 'ADOPTIVEPARENT'
) 
) a
;
*/