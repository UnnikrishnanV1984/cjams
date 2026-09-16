/*
   Issue Description: CDM-27800
   Category/ Module  :  Removing Gap Agreement from the List
   Root cause: Removing Gap Agreement List
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

/*No Records in Routing Table*/

update gapagreementrate set activeflag = 0, updatedby = 'CDM-27800',
 updatedon = now() where gapagreementrateid = '323b8495-baff-4282-af42-1abc05e2b32e';

update gapratesrevision set activeflag = 0 , updatedon = now(), updatedby = 'CDM-27800' 
where gaprateid = '323b8495-baff-4282-af42-1abc05e2b32e';

