/*
   Issue Description: CDM-22329
   Category/ Module  : Remove the Adoption Annual Review
   Root cause: user wants to remove the Annual Review
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update adoptioniverenewal set activeflag = 0, updatedby = 'CDM-22329', updatedon = now()  where adoptioniverenewalid = '4d789991-ff6d-4ac9-8938-d330e752531b';
update routing set activeflag = 0, updatedby = 'CDM-22329', updatedon = now()  where routingid = 'aae6a752-dab1-4dc4-88b8-1504f12d2893';
