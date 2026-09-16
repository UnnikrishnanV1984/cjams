/*
   Issue Description: CDM-31616
   Category/ Module  : Prod data fix for adoption break the link
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- select * from adoptionagreementrate where adoptionagreementid in ( '7d1a7cb9-1362-44e7-83e9-40fe3f45dcbe','82b555c3-a64e-4712-ac84-54a9c935eba3')

-- select * from adoptionagreement where adoptionagreementid in ( '7d1a7cb9-1362-44e7-83e9-40fe3f45dcbe','82b555c3-a64e-4712-ac84-54a9c935eba3')



update adoptionagreement set activeflag = 0, updatedby = 'CDM-31616', updatedon = now()
where adoptionagreementid = '7d1a7cb9-1362-44e7-83e9-40fe3f45dcbe' and activeflag = 1;

update adoptionagreementraterevision set activeflag = 0, updatedby = 'CDM-31616', updatedon = now()
where adoptionagreementid = '7d1a7cb9-1362-44e7-83e9-40fe3f45dcbe' and activeflag = 1;
