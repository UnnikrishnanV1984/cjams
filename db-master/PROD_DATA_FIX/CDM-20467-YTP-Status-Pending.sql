/*
   Issue Description: CDM-20467
   Customer Email ID: stacey.weimer@maryland.gov
   Category/ Module  : YTP status pending
   Root cause: user wants to approve YTP pending status
   Pull request# for code fix: N/A
   explanantion: user wants to approve YTP status
*/


update youthtransitionplan  set approvalstatuskey = 'Approved' , updatedby ='CDM-20467',updatedon = now() 
	where youthtransitionplanid = 'e00100df-fc58-4377-95dd-ee3a42572253';