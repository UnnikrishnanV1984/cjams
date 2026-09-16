update tb_service_purchase_authorization set payment_approval_status_cd=null, payment_approval_dt=null where authorization_id=1731055;

update routing set tosecurityusersid=null,routingstatustypeid=41,activeflag=1,
remarks='Forwarded to Payment Approval', routeddescription='Purchase Authorization Forwarded to Payment Approval'
where routingid='ef36e800-4ac0-4807-ac96-87e58069617d'
and objectid=1731055;