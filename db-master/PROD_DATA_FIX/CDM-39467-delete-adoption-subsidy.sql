/*
   Issue Description: CDM-39467 Cannot submit corrected subsidy Rate
   Category/ Module  : Payments
   Root cause: User wants to remove the duplicate 'Review' record from subsidy agreements
   Fix Provided :Data fix has been promoted to delete the duplicate subsidy rate record
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update adoptioncaserevision
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-39467'		
where adoptionagreementrateid = 'aa3fa979-6ada-42f0-9ce7-ae4ed6715d30'
	and activeflag = 1;

update routing 
set activeflag=0, 
    updatedby='CDM-39467', 
    updatedon = now() 
    where objectid = 'aa3fa979-6ada-42f0-9ce7-ae4ed6715d30' 
    and routingid='b91c49b5-317e-426e-8cf0-59ef5a492b8c';
