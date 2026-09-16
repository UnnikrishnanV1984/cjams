update routing set routingstatustypeid=39, activeflag=0,remarks='Forwarded to Case Supervisor',
tosecurityusersid='dd3ac302-59b9-4e32-ac55-94a0d551ee4f', updatedon=current_timestamp where routingid='f93a3855-d5ff-43f1-b8d7-f1311672f365'
and eventcode='PCAUTH' and servicerequestnumber=3051358;

update routing set routingstatustypeid=40, activeflag=0,remarks='Forwarded to Funding Approval',
tosecurityusersid='753c40c4-34fd-4e88-9e2a-f974a416d51a', updatedon=current_timestamp where routingid='15591b2a-c68c-4a27-a7e9-8f0a84e8edc0'
and eventcode='PCAUTHR' and servicerequestnumber=3051358;

update tb_slpa_snapshot set supervisor_staff_id=100004328, supervisor_name='Kathleen Chaney',  update_ts=current_timestamp where authorization_id=1730561
and slpa_snapshot_id=1299164;