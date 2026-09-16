s
/*
   Issue Description: CDM-31255
   Category/ Module  : intakesdm 
   Root cause: user requested change case type
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update cjams.intakeservicerequestsdm set isnoimmed_physicalabuse = false, updatedby ='CDM-31255', updatedon = now()
where intakeservicerequestsdmid ='7ef35dce-052c-462d-939a-649cda50dfaf';


UPDATE cjams.intakesnapshot
SET jsondata = jsonb_set(jsondata, '{sdm,isnoimmed_physicalabuse}','false')
where intakenumber = 'I231010599226'  AND activeflag=1;