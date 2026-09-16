 /*
  Issue Description: CDM-17531
   Category/ Module  : Removing the Approved GAP Rate
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update gapagreementrate set activeflag = 0, updatedon =now(), updatedby = 'CDM-17531' where gapagreementrateid = '64bb5fa5-1e23-4fd7-be42-08e42f297947';
