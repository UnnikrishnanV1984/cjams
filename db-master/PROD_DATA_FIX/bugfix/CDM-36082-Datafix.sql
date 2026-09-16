/*
   Issue Description: CDM-36082
   Category/ Module  : Permanency Plan
   Root cause: Unable to break the link, The subsidy agreement was sent twice, user request to delete duplicate agreement request
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
   Case is closed without closing removal and placement. Need to do data fix
*/

update adoptionagreement 
set activeflag=0, updatedby ='CDM-36082',updatedon =now()
where adoptionagreementid='e028de46-e39a-4f33-a051-ad5c2f7d5795';

update routing
set activeflag = 0, updatedby ='CDM-36082',updatedon =now()
where objectid = 'e028de46-e39a-4f33-a051-ad5c2f7d5795'
and eventcode = 'ASAR'
and activeflag = 1 ;