/*
   Issue Description: CDM-17928
   Category/ Module  :  case stuck in assign box
   Root cause: user asked to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservicerequest
	set isrouted = true, updatedon = now(), updatedby = 'CDM-17928'
	where intakeserviceid in ('c95bf00f-c563-476a-a16e-0e6179793ffc', '35b879db-678a-49d7-b8a3-9e0e338bc9e4');