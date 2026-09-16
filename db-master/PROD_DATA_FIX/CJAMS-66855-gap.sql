/*
   Issue Description: CJAMS-66855
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
    updatedby = 'CJAMS-66855',
    updatedon = now ()
where
    objectid = 'cd23080e-0406-4422-9355-1ec81ab4ae44'
    and routingid = '9446d449-d949-4e01-91e0-9a04fb84a21a'
    and eventcode = 'GAAP';