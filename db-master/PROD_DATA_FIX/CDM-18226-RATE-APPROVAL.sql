/*
   Issue Description: CDM-18226
   Category/ Module  :  Rate approval
   Root cause: user asked to review the gap aggreement rate
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update gapagreementrate 
	set activeflag = 0, updatedby = 'CDM-18226', updatedon = now() 
	where gapagreementrateid = 'd2536aec-de4f-44a8-b394-193e08125abe';	