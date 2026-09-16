/*
   Issue Description: CDM-32732
   Category/ Module  : Sdm 
   Root cause: 
   Fix Provided: 
*/

UPDATE cjams.intakeservicerequestsdm
SET isnoimmed_physicalabuse=false, isnoimmed_neglectresponse = true, updatedby='CDM-32732', updatedon=now()
WHERE intakeservicerequestsdmid='1e783ab1-f8b1-418e-8acf-96269fcbaaf1' 
and intakeserviceid='708769a4-3da8-4ba4-a4f1-a0c324677284';

update intakedastaging 
set 
		 jsondata = replace(jsondata :: text , '"isnoimmed_physicalabuse": true', '"isnoimmed_physicalabuse": false')::json,
		 updatedby ='CDM-32732',
		 updatedon =now()		
where intakenumber = 'I231010716619' and activeflag = 1 ;

update intakedastaging 
set 
		 jsondata = replace(jsondata :: text , '"isnoimmed_neglectresponse": false', '"isnoimmed_neglectresponse": true')::json,
		 updatedby ='CDM-32732',
		 updatedon =now()		
where intakenumber = 'I231010716619' and activeflag = 1 ;

update intakesnapshot
set 
		 jsondata = replace(jsondata :: text , '"isnoimmed_physicalabuse": true', '"isnoimmed_physicalabuse": false')::json,
		  updatedby ='CDM-32732',
		 updatedon =now()			
where intakenumber = 'I231010716619' and activeflag = 1 ;

update intakesnapshot
set 
		 jsondata = replace(jsondata :: text , '"isnoimmed_neglectresponse": false', '"isnoimmed_neglectresponse": true')::json,
		  updatedby ='CDM-32732',
		 updatedon =now()			
where intakenumber = 'I231010716619' and activeflag = 1 ;

