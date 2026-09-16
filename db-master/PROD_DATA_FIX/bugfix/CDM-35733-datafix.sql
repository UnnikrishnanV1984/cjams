/*
   Issue Description: CDM-35733
   Category/ Module  :Assignments
   Root cause: This case was transferred from Baltimore County. This case is is not displaying an "assign" tab. 
   Fix Provided: So made necessary data changes  and changed from baltimorecounty to baltimorecity
*/
--

update 
intakedastaging 
set jsondata=replace(jsondata::text,'"countyid": "1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b"' ,' "countyid": "7665ca54-5374-4174-be07-a687b811a82c"')::json,
     updatedby='CDM-35733',
     updatedon =now()
where 
    intakenumber = 'I231011578144' 
and 
    activeflag=1;