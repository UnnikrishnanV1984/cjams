/*
  Issue Description: CDM-27197
   Category/ Module  : user requested update program key 
   Root cause: user requested 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/
update cjams.personprogramarea set programkey ='OOH', updatedon = now(), updatedby ='CDM-27197'
where personprogramid ='67e93b56-8da9-41dc-8fc3-1827f14c71b1';