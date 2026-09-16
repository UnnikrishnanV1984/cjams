/*
   Issue Description: CDM-38292 OOH program is closed
   Category/ Module  :  Child Removal
   Root cause: 3247213:Another local closed this youth's OOH program. Need to re-open her immediately for OOH
   Fix Provided: Data fix has been promoted to remove the end date for the OOH placement and change the caseid to 3247213 as per the removal info.
*/

select *from personprogramarea 
where personid='91e61c50-0f08-407f-9da5-65b53521ff73' 
and activeflag=1 
and personprogramid='40c73b3e-bcf8-4a95-9ab6-abdc4d9319da';

update personprogramarea 
set enddate = null, 
    entityid= '3247213',
    updatedby = 'CDM-38292',
    updatedon = now() 
where personid='91e61c50-0f08-407f-9da5-65b53521ff73' 
and activeflag=1 
and personprogramid='40c73b3e-bcf8-4a95-9ab6-abdc4d9319da';