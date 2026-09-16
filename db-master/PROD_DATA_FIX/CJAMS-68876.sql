/*
Issue Description: CJAMS-68876- Service Log needs released to Program Manager box.
Category/ Module  : Purchase Authorization
Root cause:user Requested to re direct the purchase authorization to Wanda nolt
Fix provided: Data fix is done to redirect to Wanda nolt
Is code fix required: N
Why no code fix is required: user error
Pull request# for code fix:
Reason why no related code fix: 
Status of the code fix if already submitted and expected prod fix date: 
Need to do data fix
 */
update routing
set
    tosecurityusersid = 'd636ac2f-53ff-43e0-adbf-35c97e0427ec',--Wanda nolt
    updatedby = 'CJAMS-68876',
    updatedon = now ()
where
    eventcode = 'PCAUTH'
    and routingid ='74555b9f-576a-46cf-8ff2-9dcf560773c3'
    and tosecurityusersid = '2e0c5cab-7b62-41ea-b505-11142d2fb04b'
    and activeflag = 1;