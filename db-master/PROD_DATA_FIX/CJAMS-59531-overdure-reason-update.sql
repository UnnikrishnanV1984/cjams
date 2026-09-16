--CJAMS-59531  update the legislative data

/*
--	Issue Description: 
251022981518:Drop down reasons missing from Legislative Required Reporting window. Please add the reason For alleged victim and initial contact caregiver, 
please update: Alleged victim unavailable > Insufficient information reported
-- Fix Provided: Datafix has been provided by updating with the requested values
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU',
cpsresponsetimerreason2 = 'VIIR',
cpsresponsetimerreason3 = 'V12R',
updatedby = 'CJAMS-59531',
updatedon = now()
where cpsresponsetimeractionsid  = '58480968-7b09-416c-a4f8-b3ea5ff3ace2';