/*
  Issue Description:  CDM-38380
   Category/ Module  :  Gap Agreemnet
   Root cause: Requested to change the start date for the Gap Agreement
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

select * from gapagreement WHERE gapagreementid = '3bc73a3c-b11e-448d-8ff6-3299205afec5'; 

UPDATE gapagreement
	SET startdate = '2024-04-11 10:30:00',
		updatedon = now(),
		updatedby = 'CDM-38380'
	WHERE gapagreementid = '3bc73a3c-b11e-448d-8ff6-3299205afec5'; 
	
	
select * from gapagreementrevision where gapagreementid = '3bc73a3c-b11e-448d-8ff6-3299205afec5' and activeflag = 1; 	

UPDATE gapagreementrevision
	SET startdate = '2024-04-11 10:30:00',
		updatedon = now(),
		updatedby = 'CDM-38380'
	WHERE gapagreementid = '3bc73a3c-b11e-448d-8ff6-3299205afec5' and activeflag = 1; 