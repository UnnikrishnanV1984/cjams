/*
   Issue Description: CJAMS-67949
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
    updatedby = 'CJAMS-67949',
    updatedon = now ()
where
    objectid = '7df66bd5-10b2-436b-a7f3-d1ca59623a55'
    and routingid = '5ccab8af-c7ac-4baa-b59d-786909d90490'
    and eventcode = 'GAAP';