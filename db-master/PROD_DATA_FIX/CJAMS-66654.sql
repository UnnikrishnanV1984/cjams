
/*
Issue: CJAMS-66654 Flex Fund Approval
Category/Module: Purchase Authorization
Root cause:  Approval from Melissa Watson-Clark need to be re-routed to the Wanda Nolt as requested by the user. 
Fix provided: Data fix provided to update the routing table with correct approver.
Data/Code fix ticket#: CJAMS-66654
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: MAde changes in the database as per the user request.
Status of the code fix: Data fix completed, PR raised for documentation.
*/ 
update routing
set tosecurityusersid = 'd636ac2f-53ff-43e0-adbf-35c97e0427ec',
    updatedon = now(),
    updatedby = 'CJAMS-66654'
where objectid = '583552'
and routingid = 'da432ee8-d37a-4722-a94a-3f1fc5cb1212'
and tosecurityusersid = 'e52e9de6-c884-40f4-964e-b5bdb61787d1'
and activeflag =1;

update routing
set tosecurityusersid = 'd636ac2f-53ff-43e0-adbf-35c97e0427ec',
    updatedon = now(),
    updatedby = 'CJAMS-66654'
where objectid = '583533'
and routingid = 'ddee99d7-74f8-4c89-9fbe-89a698267417'
and tosecurityusersid = 'e52e9de6-c884-40f4-964e-b5bdb61787d1'
and activeflag =1;
