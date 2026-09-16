/*
   Issue Description: CDM-39285
   Category/ Module  : Payments
   Root cause:User edited the rejected subsidy rate slab and submitted for supervisor review, and this caused an issue to submit the new subsidy rate slab. The review subsidy rate need to be removed as it's a duplicate subsidy rate slab.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update adoptioncaserevision
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-39285'		
where adoptionagreementrateid = 'aa3fa979-6ada-42f0-9ce7-ae4ed6715d30'
	and activeflag = 1;
