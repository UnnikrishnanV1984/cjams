update intakeservreqchildremoval set exitdate = '2020-06-23 08:47:39', returndate = '2020-06-23 08:47:39', returntime = '2020-06-23 08:47:39', removalexitreason = 'CHREUNIFWF', updatedon = now(), updatedby = 'CDM-9601' where intakeservreqchildremovalid = '1d5f39e8-01e3-49be-9e61-618a7b921fc4';

update intakeservreqchildremoval set exitdate = '2020-09-18 08:47:39', returndate = '2020-09-18 08:47:39', returntime = '2020-09-18 08:47:39', removalexitreason = 'CHREUNIFWF', updatedon = now(), updatedby = 'CDM-9602' where intakeservreqchildremovalid = '8df667c9-3d94-4a54-b21b-1e3c0451be6f';


update tb_service_purchase_authorization set sprvsr_approval_dt = null, sprvsr_approval_status_cd = null, update_user_id = 'CDM-8621', update_ts = now() where authorization_id = '1757389';
delete from routing where routingid in ('2e7077c9-5fba-444d-abc2-94b0997211a2','2f4b49f3-3bbf-49ac-b2b3-8ce507e62cd5');

