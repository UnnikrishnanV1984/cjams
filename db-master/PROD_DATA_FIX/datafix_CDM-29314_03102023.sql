/*
   Issue Description: CDM-29314
   Category/ Module  : Approval Inbox
   Root cause: user wants to delete the record form pending approval tab
   Pull request# for data fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/

-- inspect the page u will get object id from that you will get routing id
-- "objectid": "334352c9-f615-4169-888c-54df85290108"
select distinct routingid from routing where objectid = '334352c9-f615-4169-888c-54df85290108' and activeflag=1;
update routing 
	set  updatedby = 'CDM-29314',updatedon = now(), activeflag = 0
	where  routingid = 'a0be2dc6-ff99-4080-b28c-00ba07ad7108';

select distinct routingid from routing where objectid = '0ed3a153-fdda-40f0-8473-2617578f2b94' and activeflag=1;
update routing 
	set  updatedby = 'CDM-29314',updatedon = now(), activeflag = 0
	where  routingid = 'ce9d8d27-a5fc-4cc8-85b9-66a1d8af4d22';

select distinct routingid from routing where objectid = 'ebfba844-6b00-4bb0-9b91-9285a7d82423' and activeflag=1;
update routing 
	set  updatedby = 'CDM-29314',updatedon = now(), activeflag = 0
	where  routingid = 'eeafb2e1-7099-4f7b-b76e-2aaf01c62aac';

select distinct routingid from routing where objectid = '80adcd0d-83fe-49b6-9f30-0288f31e2f80' and activeflag=1;
update routing 
	set  updatedby = 'CDM-29314',updatedon = now(), activeflag = 0
	where  routingid = '08159511-c50c-4cfe-8c7c-1e3a22e5f10b';