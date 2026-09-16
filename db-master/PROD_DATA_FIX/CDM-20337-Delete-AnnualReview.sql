/*
   Issue Description: CDM-20337
   Category/ Module  : Aggreed Documents Tab
   Root cause: user wants to remove approved annual review 
   Pull request# for code fix: 7499
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update adoptioniverenewal set activeflag = 0, updatedby = 'CDM-20337', 
updatedon = now()  where adoptioniverenewalid = '79696227-507f-4ff4-a876-b109c462f145';
