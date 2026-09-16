/*
   Issue Description: CJAMS-60494
           Change Removal type
   Category/ Module  : Removal type 
   Root cause: user wants to change removal type from "Time-Limited Voluntary Placement" to Judicial Determination
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update intakeservreqchildremoval 
  set removaltypekey = 'JD', 
      updatedon = now(), 
      updatedby = 'CJAMS-60494'
where intakeservreqchildremovalid = '95850a7b-fce4-4403-8c40-0ff1f2228106'
   and activeflag = 1;