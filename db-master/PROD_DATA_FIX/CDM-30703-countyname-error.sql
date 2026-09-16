/*
   Issue Description: CDM-30703
   Category/ Module  : Intake
   Root cause: user unable to approve , due to incorrect countyname
   Pull request# for code fix: 8853
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
*/


update 
     intakedastaging 
set 
    jsondata=replace(jsondata::text,'"countydesc": "Montgomery"' ,' "countydesc": "PG"')::json,
    updatedby ='CDM-30703',
    updatedon =now()
 where
     intakenumber = 'I231010582316' 
and 
     activeflag = 1;

update 
intakedastaging 
set jsondata=replace(jsondata::text,'"countyid": "f6ab02d5-c386-4659-8810-687fc191a967"' ,' "countyid": "c81be790-a79d-40ac-a38d-abd4dd5a81f6"')::json ,
     updatedby ='CDM-30703',
     updatedon =now()
where 
    intakenumber = 'I231010582316' 
and 
    activeflag=1;