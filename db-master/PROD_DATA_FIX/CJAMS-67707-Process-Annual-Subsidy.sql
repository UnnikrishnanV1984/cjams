/*
   Issue Description: CJAMS-67707
   Category/ Module:Closed GAP Case
   Root cause: This is a known issue since ,rejected status application will not allow to proceed further in agreement tab.
   Fix Provided : Data fix is done to deactive the rejected routing record
   Pull request# for code fix:  N/A
   Is code fix required:Yes, This is known issue and will be resolved as part of CIDM-11273
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update routing
set
    activeflag = 0,
    updatedby = 'CJAMS-67707',
    updatedon = now ()
where
    objectid = '5af1fc1e-557f-43fe-96be-0d2bedea8691'
    and routingid = '5c14760c-3d26-4f49-8df5-42a71a381b25'
    and eventcode = 'GAAP';