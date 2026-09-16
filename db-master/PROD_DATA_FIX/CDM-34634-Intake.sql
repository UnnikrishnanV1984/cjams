
/*
   Issue Description: CDM-34634
   Category/ Module  : Intake 
   Root cause: user unable to screenout due to wrong county on the intake 
   Fix provided: Did data fix to update correct county so supervisor can approve  
*/


--change county from Anne Arundel to Baltimore city

update intakedastaging 
set jsondata = replace (jsondata::text,  '"countyid": "f5214cb2-953e-41a9-a4ad-71341501e2ad"', '"countyid": "7665ca54-5374-4174-be07-a687b811a82c"' )::jsonb,
   updatedby = 'CDM-34634',   updatedon = now()
where intakenumber = 'I231010874576' and activeflag = 1;