/*
   Issue Description: CDM-34440
   Category/ Module  : Prod data fix to remove the adoption case agreement rate
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update adoptioncaseagreementrate set activeflag = 0 , updatedon = now(), updatedby = 'CDM-34440', approvaldate = now()
where adoptionagreementrateid = 'af425b96-799d-44ff-a98a-f5cfbe1aa3cb';


update adoptionagreementraterevision set activeflag = 0 , updatedon = now(), updatedby = 'CDM-34440',approvaldate = now()
where adoptionagreementrateid = 'af425b96-799d-44ff-a98a-f5cfbe1aa3cb';