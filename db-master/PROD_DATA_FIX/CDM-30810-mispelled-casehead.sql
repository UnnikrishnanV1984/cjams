/*
  Issue Description:  CDM-30810
   Category/ Module  : Person tab
   Root cause: User requested to correct the mispelled last name
   Pull request# for code fix: 
   Reason why no related code fix: user requested 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   
*/

update person set lastname ='Stanton',updatedby = 'CDM-30810' ,updatedon  =now() where cjamspid = '200928735' and personid = '5fe6df95-d104-49ae-a717-3f5d531bae56';