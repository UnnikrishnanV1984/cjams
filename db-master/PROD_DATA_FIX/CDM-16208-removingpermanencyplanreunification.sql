/*
   Issue Description: CDM-16208
   Category/ Module  :  Permananency plan removal
   Root cause: user requeseted to remove the information
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update permanencyplan set activeflag = 0, updatedby = 'CDM-16208',updatedon = now() where permanencyplanid = '0923ecf0-0d81-40d9-ade2-b4ebdf69a14d';
update guardianship set activeflag = 0, updatedby = 'CDM-16208',updatedon = now() where gapid = '1a79cf2d-7c07-4449-a35c-265053affa93';
update gapagreement set activeflag = 0, updatedby = 'CDM-16208',updatedon = now() where gapid ='1a79cf2d-7c07-4449-a35c-265053affa93';
update gapagreementrate set activeflag = 0, updatedby = 'CDM-16208',updatedon = now() where  gapagreementid='0705059f-c60d-4ae4-a48c-e4e8c93f5619';

