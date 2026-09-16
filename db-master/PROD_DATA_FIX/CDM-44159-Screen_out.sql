/*
  Issue Description:  CDM-44159
   Category/ Module  :Intake
   Root cause: Supervisor unable to screenout intake due to inactive record in routing table.
   Pull request# for code fix: 
   Reason why no related code fix:Could not reproduce this issue in local. 
*/

update routing set activeflag = 1,eventcode='INTR', updatedon= now(),updatedby ='CDM-44159'  
where objectid ='I241012443641';