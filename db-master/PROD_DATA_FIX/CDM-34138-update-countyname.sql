/*
   Issue Description: CDM-34138
   Category/ Module  : Intake
   Root cause: user unable to approve , due to incorrect countyname
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
*/

update 
intakedastaging 
set jsondata=replace(jsondata::text,'"countyid": "58bac299-69ce-4cd2-8e9c-2773524050db"' ,' "countyid": "c81be790-a79d-40ac-a38d-abd4dd5a81f6"')::json ,
     updatedby ='CDM-34138',
     updatedon =now()
where 
    intakenumber = 'I231011111017' 
and 
    activeflag=1;