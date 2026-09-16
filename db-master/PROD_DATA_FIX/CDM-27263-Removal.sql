/*
   Issue Description: CDM-27263
   Category/ Module  : child removal 
   Root cause: user requested 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


select removalid, * from intakeservreqchildremoval where intakeservreqchildremovalid in('73f139e3-6dcc-442d-8ab7-25b7c120aeb9');

select * from tb_client_eligibility where removal_id ='256644';

--No placement and tb_client_eligibility and personprogram area for this one 

update cjams.intakeservreqchildremoval set activeflag =0, updatedby ='CDM-27263', updatedon = now()

where intakeservreqchildremovalid in('73f139e3-6dcc-442d-8ab7-25b7c120aeb9')