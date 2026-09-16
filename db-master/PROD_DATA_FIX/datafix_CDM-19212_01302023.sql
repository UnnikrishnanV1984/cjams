/*
   Issue Description: CDM-19212
   Category/ Module  : Remove the hearing details record for Brianna Alecia Gonzalez & Prince Gonzalez on 02/12/2021
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
  
/*    
INSERT INTO cjams.hearingclients
(hearingclientid, courthearingid, updatedby, updatedon, insertedby, insertedon, activeflag, personid, courtcasenotx, otherclientflag, datavalidflag, clientmergeid, annualnoticebenefitdt, old_id, etl_userid, etl_load_date)
VALUES('e499a9fc-27e8-45e8-8a27-73c15fe586cb', '77aad0d2-e5a9-4bfc-8ffa-ea2a165b091b', 'ce22087c-0181-4136-89fa-0020f7ad36b1', '2021-12-09 21:59:14.000', 'ce22087c-0181-4136-89fa-0020f7ad36b1', '2021-12-09 21:58:12.000', 1, 'b9512ce2-3389-440c-887b-8ed76762bf6c', '', 0, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.hearingclients
(hearingclientid, courthearingid, updatedby, updatedon, insertedby, insertedon, activeflag, personid, courtcasenotx, otherclientflag, datavalidflag, clientmergeid, annualnoticebenefitdt, old_id, etl_userid, etl_load_date)
VALUES('8a486e7b-e95f-40b8-bbb4-14fa26266ea8', '77aad0d2-e5a9-4bfc-8ffa-ea2a165b091b', 'ce22087c-0181-4136-89fa-0020f7ad36b1', '2021-12-09 21:59:14.000', 'ce22087c-0181-4136-89fa-0020f7ad36b1', '2021-12-09 21:58:12.000', 1, '83379c44-7d39-4279-9bc5-6e331c29ee81', '', 0, NULL, NULL, NULL, NULL, NULL, NULL);

*/

update hearingclients
set activeflag = 0,
	updatedby = 'CDM-19212',
	updatedon = now()
where hearingclientid in ('e499a9fc-27e8-45e8-8a27-73c15fe586cb','8a486e7b-e95f-40b8-bbb4-14fa26266ea8');