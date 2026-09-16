/*
  Issue Description: CDM-41238
   Category/ Module  :  Assignment
   Root cause: User requested remove Draft MRFA" and "Closed SAFE-C" Assessments
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/


update assessment 
	set activeflag=0, 
		updatedby ='CDM-41333', 
		updatedon =now() 
	where assessmentid in ('e8c53c81-2c36-4143-bf2e-ff7404de401f','d94c77b4-6076-4e17-ad66-adade1ef867d')
		and activeflag=1;
		
update assessmentactor 
	set activeflag=0, 
	updatedby ='CDM-41333', 
	updatedon =now() 
	where assessmentid in ('e8c53c81-2c36-4143-bf2e-ff7404de401f','d94c77b4-6076-4e17-ad66-adade1ef867d')
		and activeflag=1;

update assessmentcomments 
	set activeflag=0, 
		updatedby ='CDM-41333', 
		updatedon =now() 
	where assessmentid='e8c53c81-2c36-4143-bf2e-ff7404de401f' 
		and activeflag=1;

---No record in assessment_history 
	
update routing 	set activeflag=0,
		updatedby ='CDM-41333', 
		updatedon =now()	
	where objectid='d94c77b4-6076-4e17-ad66-adade1ef867d' 
		and eventcode= 'ASST';