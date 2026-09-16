
/*
   Issue Description: CDM-17576
   Category/ Module  : Updating Removal type key
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--JD
update intakeservreqchildremoval set removaltypekey = 'TLV', updatedon = now(), updatedby = 'CDM-17576' where intakeservreqchildremovalid = 'c1a8ee47-f6ab-48fc-9163-b6d0c4fd0d87';
