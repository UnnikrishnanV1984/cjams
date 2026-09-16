/*
   Issue Description: CDM-37333
   Category/ Module  : SAFE-C
   Root cause: User Error. User requested to delete duplicate SAFE-C Assessment
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- CASE ID: 221020236235

update assessment 
	set activeflag=0, 
		updatedby ='CDM-37333', 
		updatedon =now() 
	where assessmentid='cfde4e2b-a02a-4c2f-9b01-c91cf7c24ebc' 
		and activeflag=1;
		
update assessmentactor 
	set activeflag=0, 
	updatedby ='CDM-37333', 
	updatedon =now() 
	where assessmentid='cfde4e2b-a02a-4c2f-9b01-c91cf7c24ebc' 
		and activeflag=1;

update assessmentcomments 
	set activeflag=0, 
		updatedby ='CDM-37333', 
		updatedon =now() 
	where assessmentid='cfde4e2b-a02a-4c2f-9b01-c91cf7c24ebc' 
		and activeflag=1;

update assessment_history 
	set activeflag=0, 
		updatedby ='CDM-37333', 
		updatedon =now() 
	where assessmentid='cfde4e2b-a02a-4c2f-9b01-c91cf7c24ebc' 
		and activeflag=1;

update routing 
	set activeflag=0,
		updatedby ='CDM-37333', 
		updatedon =now()	
	where objectid='cfde4e2b-a02a-4c2f-9b01-c91cf7c24ebc' 
		and eventcode= 'ASST';