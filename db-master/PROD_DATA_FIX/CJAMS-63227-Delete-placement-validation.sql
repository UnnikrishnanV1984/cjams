/*
  Issue Description: CJAMS-61264 Trying to close provider ID 5022149 and receiving message that provider has outstanding placement validations for Case ID: 3180784, Client ID: 1317704 ), ( Case ID: 3180785, Client ID: 1277032 ), 
  ( Case ID: 3180787, Client ID: 1293449. These all need to be deleted so that this provider can be closed out
  Category/ Module : Placement
  Root cause: This is a migrated case and placement record is created on 11/17/2009 . We are unable to close the provider ID 5022149 and receiving the message that provider has outstanding placement validations 
              as there is placement record on 11/17/2009 which is causing this issue.
              Data fix is needed to remove the outstanding placement validations records for the clients.
              Case ID: 3180784 - Client ID: 1317704
              Case ID: 3180785 - Client ID: 1277032
              Case ID: 3180787 - Client ID: 1293449
  Fix Provided: Data fix has been done to remove the outstanding placement validations records for the client
                Case ID: 3180784 - Client ID: 1317704
                Case ID: 3180785 - Client ID: 1277032
                Case ID: 3180787 - Client ID: 1293449
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: Case is already closed and data fix needed to proceed with closing the provider id.
*/


update tb_placement_validation
set delete_sw ='Y',
    comment_tx = 'Record is deleted with CJAMS-63227',
    update_user_id = 'CJAMS-63227',
    update_ts = now()
where placement_validation_id in (320525, 320526, 320528 );