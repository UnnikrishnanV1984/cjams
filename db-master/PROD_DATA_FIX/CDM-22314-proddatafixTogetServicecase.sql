/*
   Issue Description: CDM-22314
   Category/ Module  : Prod data fix to service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservicerequest set activeflag = 0,
updatedby = 'CDM-22314', updatedon = now() where intakeserviceid = '357743c1-3964-4c17-8d48-f3514fa2d8d0';
