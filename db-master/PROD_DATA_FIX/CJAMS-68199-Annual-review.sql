/*
   Issue Description: CJAMS-68199
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
    updatedby = 'CJAMS-68199',
    updatedon = now ()
where
    objectid = '2dada85f-fd2e-4445-ab05-aa82943676fa'
    and routingid = '7f24647e-4d9f-4f09-bf28-23bf3a38f8d5'
    and eventcode = 'GAAP';