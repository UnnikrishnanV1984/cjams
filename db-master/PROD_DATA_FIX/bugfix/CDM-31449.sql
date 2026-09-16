/*
   Issue Description: CDM-31449
   Category/ Module  : service plan
   Root cause: user wants Change the service plan approved by to Monique Swain from Gina Whaley  
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update snapshothist set updatedby='fa6c7906-97af-4f35-8987-dbc6add7090d' , updatedon=now() where objectid='5decc41e-8aa5-496a-ae94-e85a3e54bc36' and activeflag=1;