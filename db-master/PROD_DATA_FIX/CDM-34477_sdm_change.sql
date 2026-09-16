-- CDM-34477 - Response Timer
/*
-- Issue Description:
-- Category/ Module: SDM
-- Fix Provided: Datafix to remove the physical abuse value selected
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
update intakedastaging 
set jsondata = replace(jsondata :: text , '"isnoimmed_physicalabuse": true', '"isnoimmed_physicalabuse": false')::json,
updatedby ='CDM-34477', updatedon =now()		
where intakenumber = 'I231011227910' and activeflag = 1 ;

update intakesnapshot
set jsondata = replace(jsondata :: text , '"isnoimmed_physicalabuse": true', '"isnoimmed_physicalabuse": false')::json,
updatedby ='CDM-34477', updatedon =now()			
where intakenumber = 'I231011227910' and activeflag = 1 ;

update intakedastaging 
set jsondata = replace(jsondata :: text , '"isnoimmed_neglectresponse": false', '"isnoimmed_neglectresponse": true')::json,
updatedby ='CDM-34477', updatedon =now()			
where intakenumber = 'I231011227910' and activeflag = 1 ;

update intakesnapshot
set jsondata = replace(jsondata :: text , '"isnoimmed_neglectresponse": false', '"isnoimmed_neglectresponse": true')::json,
updatedby ='CDM-34477', updatedon =now()			
where intakenumber = 'I231011227910' and activeflag = 1 ;

update intakeservicerequestsdm 
set isnoimmed_neglectresponse = true, isnoimmed_physicalabuse = false, updatedby ='CDM-34477', updatedon =now()	 
where intakeserviceid = 'f0e9694f-8dca-4587-9dfd-ae6f0e6dc572' and intakeservicerequestsdmid = 'cadb3138-2978-40bc-8f3a-bd7639d919e1';

