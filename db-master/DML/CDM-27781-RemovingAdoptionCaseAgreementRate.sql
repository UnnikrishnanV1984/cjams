/*
   Issue Description: CDM-27781
   Category/ Module  :  Removing AdoptionCaseAgreement in List
   Root cause:  Removing AdoptionCaseAgreement in List
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update adoptioncaseagreementrate  set activeflag = 0, updatedby = 'CDM-27781',
updatedon = now() where adoptionagreementrateid = '34c231ff-da35-4343-9eab-b7ec808ddb7e';

update adoptioncaserevision set activeflag = 0, updatedby = 'CDM-27781',
updatedon = now() where adoptionagreementrateid = '34c231ff-da35-4343-9eab-b7ec808ddb7e'
and activeflag = 1;

update routing set activeflag = 0, updatedby = 'CDM-27781',
updatedon = now() where objectid = '34c231ff-da35-4343-9eab-b7ec808ddb7e'
and eventcode = 'AARR'
and activeflag = 1;