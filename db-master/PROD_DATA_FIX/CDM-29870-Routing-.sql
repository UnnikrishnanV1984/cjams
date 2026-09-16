/*
   Issue Description: CDM-29870
   Category/ Module  : Case Pending Approval
   Root cause: user wants remove those three cases from the user pending approval dashboard and 
                Updated the activeflag to zero in routing table
   Pull request#
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update
	routing
set
	activeflag = 0, updatedon = now(),
	updatedby = 'CDM-29870'
where
	routingid in ('a10fd801-c31f-4c0a-ab17-515d3d2f1275',
	'5a14dd95-0c76-422b-a370-dc9dfddb54a4',
	'5da8f603-5332-4119-ba1e-b69a63caffe4')
	and activeflag = 1;