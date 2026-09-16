/*
   Issue Description: CDM-16084
   Category/ Module  :  removal end date
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval 
	set exitdate = '2021-07-02 15:40:00', 
		removalexitreason = 'RUF', 
		updatedby = 'CDM-16084', 
		updatedon = now() 
	where intakeservreqchildremovalid = '3bd15744-9211-49cd-a654-31a0d83d8422';