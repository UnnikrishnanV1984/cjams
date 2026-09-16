/*
   Issue Description: CDM-28468
   Category/ Module  :  Creating a service case
   Root cause: Case type incorrectly updated to AR
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservicerequest set actiontype = 'IR', updatedby = 'CDM-28468', updatedon = now() where intakenumber = 'I231010358160' and activeflag = 1