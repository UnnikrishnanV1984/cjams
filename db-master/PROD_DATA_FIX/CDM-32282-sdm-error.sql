-- CDM-32282- Data fix
/*
-- Issue Description:
-- Category/ Module: Intake
-- Fix Provided: Datafix to remove the physical abuse value selected
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
update intakedastaging 
set 
		 jsondata = replace(jsondata :: text , '"isnoimmed_mentalinjury": true', '"isnoimmed_mentalinjury": false')::json,
		 updatedby ='CDM-32282',
		 updatedon =now()		
where intakenumber = 'I231010616006' and activeflag = 1 ;

update intakedastaging 
set 
		 jsondata = replace(jsondata :: text , '"isnoimmed_physicalabuse": false', '"isnoimmed_physicalabuse": true')::json,
		 updatedby ='CDM-32282',
		 updatedon =now()		
where intakenumber = 'I231010616006' and activeflag = 1 ;

update intakesnapshot
set 
		 jsondata = replace(jsondata :: text , '"isnoimmed_mentalinjury": true', '"isnoimmed_mentalinjury": false')::json,
		  updatedby ='CDM-32282',
		 updatedon =now()			
where intakenumber = 'I231010616006' and activeflag = 1 ;

update intakesnapshot
set 
		 jsondata = replace(jsondata :: text , '"isnoimmed_physicalabuse": false', '"isnoimmed_physicalabuse": true')::json,
		  updatedby ='CDM-32282',
		 updatedon =now()			
where intakenumber = 'I231010616006' and activeflag = 1 ;


update intakeservicerequestsdm set ismalpa_nonaccident = false, 
isnoimmed_mentalinjury = false,
isnoimmed_physicalabuse = true,
 updatedby ='CDM-32282',
 updatedon =now()	 
 where intakeserviceid = '77fbe5a0-0d30-49f4-916d-86434b2c93c8';

