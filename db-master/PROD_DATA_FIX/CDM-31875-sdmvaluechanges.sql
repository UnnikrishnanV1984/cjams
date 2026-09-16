-- CDM-31875 - Data fix
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
		 jsondata = replace(jsondata :: text , '"ismalpa_nonaccident": true', '"ismalpa_nonaccident": false')::json,
		 updatedby ='CDM-31875',
		 updatedon =now()		
where intakenumber = 'I231010635442' and activeflag = 1 ;

update intakesnapshot
set 
		 jsondata = replace(jsondata :: text , '"ismalpa_nonaccident": true', '"ismalpa_nonaccident": false')::json,
		  updatedby ='CDM-31875',
		 updatedon =now()			
where intakenumber = 'I231010635442' and activeflag = 1 ;

update intakedastaging 
set 
		 jsondata = replace(jsondata :: text , '"isnoimmed_physicalabuse": true', '"isnoimmed_physicalabuse": false')::json,
		  updatedby ='CDM-31875',
		 updatedon =now()			
where intakenumber = 'I231010635442' and activeflag = 1 ;

update intakesnapshot
set 
		 jsondata = replace(jsondata :: text , '"isnoimmed_physicalabuse": true', '"isnoimmed_physicalabuse": false')::json,
		  updatedby ='CDM-31875',
		 updatedon =now()			
where intakenumber = 'I231010635442' and activeflag = 1 ;

update intakeservicerequestsdm set ismalpa_nonaccident = false, 
isnoimmed_physicalabuse = false,
 updatedby ='CDM-31875',
 updatedon =now()	 
 where intakeserviceid = 'ebaf1ab6-883a-453b-9803-f060dbb1f4a4';

