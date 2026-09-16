/*
  Issue Description: CIDM-4077 CIS change request
   Category/ Module  :  CIS# update
   Root cause: Need to update cis# as per user request
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: cisclientid=446060269, personidentifiervalue='MDT-136348895'
*/

update person set cisclientid = 463060558,updatedby= 'CIDM-4077' ,updatedon = now() where cjamspid=200244720
and personid='87390b5b-65b6-4e24-8474-4dd1e0ac5828';

update personidentifier set personidentifiervalue='MDT-136054017',updatedby= 'CIDM-4077' ,updatedon = now() where 
personid='87390b5b-65b6-4e24-8474-4dd1e0ac5828'
and personidentifiertypekey='MDM_ID';