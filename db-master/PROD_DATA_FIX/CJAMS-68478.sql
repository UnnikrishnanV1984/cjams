   /*
   Issue Description: CJAMS-68478
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
    updatedby = 'CJAMS-68478',
    updatedon = now ()
where
    objectid = 'dac3a1b4-d413-4728-8430-46697dbf4462'
    and routingid = 'b2cff82a-09e5-4ee7-b8d2-d0969e523257'
    and eventcode = 'GAAP';