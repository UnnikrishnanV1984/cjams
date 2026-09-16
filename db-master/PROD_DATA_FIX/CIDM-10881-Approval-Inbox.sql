/*
Issue Description: Please remove pending assessment for HOH Brooke Nikita Ward/ Case #221030016652 from my approval inbox. The assessment is not available and no longer needed for this case.
Root cause: User requested to delete  the intake from user dashbord.
Fix provided: update into routing table
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User Error.
*/
update assessment
set activeflag = 0,updatedby='CIDM-10881',updatedon=now()
where assessmentid = 'dfdc186c-eb0e-4c97-81a6-c7aabac790ee' and activeflag=1;

update routing
set activeflag = 0,updatedby='CIDM-10881',updatedon=now()
where routingid = '8b8f32aa-bb3a-4c26-b04a-587edada2097'and activeflag=1;