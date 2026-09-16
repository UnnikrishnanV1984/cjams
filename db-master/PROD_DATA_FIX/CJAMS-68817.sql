/*
Issue Description: CJAMS-68817- Flex Funds approvals.
Category/ Module  : Purchase Authorization
Root cause: Requested to re direct the purchase authorizations to Wanda nolt
Fix provided: Data fix is done to redirect to Wanda nolt
Is code fix required: N
Why no code fix is required: Purchase authorizations are routed to Christina Law but she is unable to approve it, so wanda wants to deny those if those are forwarded to Wanda nolt.
Pull request# for code fix:
Reason why no related code fix: 
Status of the code fix if already submitted and expected prod fix date: 
Need to do data fix
 */
update routing
set
    tosecurityusersid = 'd636ac2f-53ff-43e0-adbf-35c97e0427ec',--Wanda nolt
    updatedby = 'CJAMS-68817',
    updatedon = now ()
where
    eventcode = 'PCAUTH'
    and routingid  in ('03073a3a-af30-4212-81a6-3dc62c12e7cc','0ce44b80-451c-415d-9b9e-06a0eea56c75')
    and tosecurityusersid = '422c4d43-cfa3-42da-b4f2-aad4ac9988fa'
    and activeflag = 1;