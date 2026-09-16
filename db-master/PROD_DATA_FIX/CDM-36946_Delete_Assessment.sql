/*
   Issue Description: CDM-36946
   Category/ Module  : SAFE-C
   Root cause: User Error. User requested to delete duplicate SAFE-C Assessment
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- CASE ID: 241030255837

update assessment 
	set activeflag=0, 
		updatedby ='CDM-36946', 
		updatedon =now() 
	where assessmentid='8ff191eb-317d-4c81-8bbf-95960f4a79e2' 
		and activeflag=1;
		
update assessmentactor 
	set activeflag=0, 
	updatedby ='CDM-36946', 
	updatedon =now() 
	where assessmentid='8ff191eb-317d-4c81-8bbf-95960f4a79e2' 
		and activeflag=1;

update assessmentcomments 
	set activeflag=0, 
		updatedby ='CDM-36946', 
		updatedon =now() 
	where assessmentid='8ff191eb-317d-4c81-8bbf-95960f4a79e2' 
		and activeflag=1;

update assessment_history 
	set activeflag=0, 
		updatedby ='CDM-36946', 
		updatedon =now() 
	where assessmentid='8ff191eb-317d-4c81-8bbf-95960f4a79e2' 
		and activeflag=1;

update routing 
	set activeflag=0,
		updatedby ='CDM-36946', 
		updatedon =now()	
	where objectid='8ff191eb-317d-4c81-8bbf-95960f4a79e2' 
		and eventcode= 'ASST';