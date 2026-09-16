
/*
   Issue Description: CJAMS-66854
   Category/ Module:Closed GAP Case
   Root cause: This is a known issue since ,rejected status application will not allow to proceed further in agreement tab.
   Fix Provided : Data fix is done to deactive the rejected routing record
   Pull request# for code fix:  N/A
   Is code fix required:Yes, This is known issue and will be resolved as part of CIDM-11273
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/



update routing set activeflag =0,updatedby ='CJAMS-66854',
updatedon =now() where objectid ='d060df5e-3320-4e1b-b71d-72756225b190' and routingid ='2e20d18a-52fd-4759-a18a-06dffa69a06c' and eventcode ='GAAP';