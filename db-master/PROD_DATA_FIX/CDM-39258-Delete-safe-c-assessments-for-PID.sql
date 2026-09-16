/*
   Issue Description: CDM-39258
   Category/ Module  : SAFE-C
   Root cause: User Error. User requested to delete duplicate SAFE-C Assessments related to multiple PIDs 202808664,202460285,4483728,202075185 and 202075178.
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/


/* PID202808664 */
update assessment 
set activeflag = 0, updatedby ='CDM-39258', updatedon =now()
where assessmentid ='9a10acff-7f45-4461-b2aa-fc8654da9c8b' and activeflag =1;

update assessmentactor 
	set activeflag=0, 
	updatedby ='CDM-39258', 
	updatedon =now() 
	where assessmentid='9a10acff-7f45-4461-b2aa-fc8654da9c8b' 
		and activeflag=1;
		
update assessmentcomments 
	set activeflag=0, 
		updatedby ='CDM-39258', 
		updatedon =now() 
	where assessmentid='9a10acff-7f45-4461-b2aa-fc8654da9c8b' 
		and activeflag=1;

update assessment_history 
	set activeflag=0, 
		updatedby ='CDM-39258', 
		updatedon =now() 
	where assessmentid='9a10acff-7f45-4461-b2aa-fc8654da9c8b' 
		and activeflag=1;
		
		
update routing 
	set activeflag=0,
		updatedby ='CDM-39258', 
		updatedon =now()	
	where objectid='9a10acff-7f45-4461-b2aa-fc8654da9c8b' 
		and eventcode= 'ASST'
	    and activeflag =1;




/* PID202460285 */ 
update assessment 
set activeflag = 0, updatedby ='CDM-39258', updatedon =now()
where assessmentid ='d7b1f70b-4732-4938-b769-c2c9bb3c211f' and activeflag =1;

update assessmentactor 
	set activeflag=0, 
	updatedby ='CDM-39258', 
	updatedon =now() 
	where assessmentid='d7b1f70b-4732-4938-b769-c2c9bb3c211f' 
		and activeflag=1;

update assessmentcomments 
	set activeflag=0, 
		updatedby ='CDM-39258', 
		updatedon =now() 
	where assessmentid='d7b1f70b-4732-4938-b769-c2c9bb3c211f' 
		and activeflag=1;

		
	update assessment_history 
	set activeflag=0, 
		updatedby ='CDM-39258', 
		updatedon =now() 
	where assessmentid='d7b1f70b-4732-4938-b769-c2c9bb3c211f' 
		and activeflag=1;

update routing 
	set activeflag=0,
		updatedby ='CDM-39258', 
		updatedon =now()	
	where objectid='d7b1f70b-4732-4938-b769-c2c9bb3c211f' 
		and eventcode= 'ASST'
	    and activeflag =1;

		
/* PID 202075185 and 202075178 */ 

update assessment 
set activeflag = 0, updatedby ='CDM-39258', updatedon =now()
where assessmentid ='420116e1-ef36-4a35-9eb1-1618d0cec19f' and activeflag =1;

update assessmentactor 
	set activeflag=0, 
	updatedby ='CDM-39258', 
	updatedon =now() 
	where assessmentid='420116e1-ef36-4a35-9eb1-1618d0cec19f' 
		and activeflag=1;
		
		
update assessmentcomments 
	set activeflag=0, 
		updatedby ='CDM-39258', 
		updatedon =now() 
	where assessmentid='420116e1-ef36-4a35-9eb1-1618d0cec19f' 
		and activeflag=1;


update assessment_history 
	set activeflag=0, 
		updatedby ='CDM-39258', 
		updatedon =now() 
	where assessmentid='420116e1-ef36-4a35-9eb1-1618d0cec19f' 
		and activeflag=1;
		
update routing 
	set activeflag=0,
		updatedby ='CDM-39258', 
		updatedon =now()	
	where objectid='420116e1-ef36-4a35-9eb1-1618d0cec19f' 
		and eventcode= 'ASST'
	    and activeflag =1;