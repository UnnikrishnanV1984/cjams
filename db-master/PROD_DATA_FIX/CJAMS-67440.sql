/*
   Issue Description: CJAMS-67440
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
    updatedby = 'CJAMS-67440',
    updatedon = now ()
where
    objectid = '4d76d308-21bc-4594-acbd-6b42a5f8e082'
    and routingid = '1522d90d-8345-4439-9109-a9e67e71cb3f'
    and eventcode = 'GAAP';