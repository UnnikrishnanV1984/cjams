/*
   Issue Description: CJAMS-68589
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
    updatedby = 'CJAMS-68589',
    updatedon = now ()
where
    objectid = '047962de-3ff6-4669-b730-ce4e11e29cdc'
    and routingid = 'f24a3b13-ac3d-4b7b-a48d-73ae441263e0'
    and eventcode = 'GAAP';