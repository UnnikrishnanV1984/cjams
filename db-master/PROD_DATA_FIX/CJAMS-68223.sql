/*
Issue Description: CJAMS-68223- Old Flex Fund.
Category/ Module  : Purchase Authorization
Root cause: Requested to re direct the purchase authorization to Wanda nolt
Fix provided: Data fix is done to redirect to Wanda nolt
Is code fix required: N
Why no code fix is required: Purchase authorizations are routed to the user who is inactive so we are re redirecting to other user
Pull request# for code fix:
Reason why no related code fix: 
Status of the code fix if already submitted and expected prod fix date: 
Need to do data fix
 */
update routing
set
    tosecurityusersid = 'd636ac2f-53ff-43e0-adbf-35c97e0427ec',--Wanda nolt
    updatedby = 'CJAMS-68223',
    updatedon = now ()
where
    eventcode = 'PCAUTH'
    and tosecurityusersid = '47e22080-a115-4838-bcc9-dfdaa67985f5' -- Gladys Bourne-Carter
    and routingstatustypeid <> '62'
    and activeflag = 1;