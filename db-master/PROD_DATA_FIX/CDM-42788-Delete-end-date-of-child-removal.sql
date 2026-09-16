/*
   Issue Description: CDM-42788
   Category/ Module  : person program area
   Root cause: OOH enddate Needs to be removed.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update personprogramarea
 set updatedby='CDM-42788', updatedon=now(), enddate=null
 where personprogramid='01591d59-57a6-47c1-a7d6-97cb94770339' and personid='ae032759-749a-48b8-8399-4d8e923d7a7b';

update tb_client_eligibility
 set update_user_id ='CDM-42788', update_ts=now(), end_dt =null
 where eligibility_id = 10028744 and removal_id = 271259;


 update intakeservreqchildremoval 
set updatedby='CDM-42788', updatedon=now(), exitdate =null
where intakeservreqchildremovalid ='6b8cafba-b903-4ced-a71b-d7023fa23746' and activeflag =1;

update placement 
set updatedby='CDM-42788', updatedon=now(), exittypekey ='CIP'
where placementid ='62c399be-45ee-408a-a525-8497b6c670d4' and activeflag =1;

update placementrevision 
set updatedby='CDM-42788', updatedon=now(), exittypekey ='CIP'
where placementrevisionid='03c2460d-542a-4a76-9743-6ee518bb2efc' and placementid ='62c399be-45ee-408a-a525-8497b6c670d4';

