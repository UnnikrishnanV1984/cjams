/*
   Issue Description: CDM-38181
   Category/ Module  : Break the link error message
   Root cause: Unable to break the link, The subsidy agreement was sent twice
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
   Case is closed without closing removal and placement. Need to do data fix
*/




update adoptionagreement 
set activeflag=0, updatedby ='CDM-38181',updatedon =now() 
where adoptionagreementid='4ade918c-3baa-46e4-b523-e33630cb8159';

update routing
set activeflag = 0, updatedby ='CDM-38181',updatedon =now()
where objectid = '4ade918c-3baa-46e4-b523-e33630cb8159'
and eventcode = 'ASAR'
and activeflag = 1 ;