/*
   Issue Description: CDM-27556 - Adoption subsidy
   Category/ Module  : Adoption subsidy agreement
   Root cause: User requested that Adoption agreement review is not coming to supervisor inbox. Please update the adoption agreement from Review to Approved as supervisor request
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do only data fix
*/

select 	*
from 	routing
where 	objectid = '02b7901e-2061-429f-aa74-02bf22060a03'
and 	routingid in ('54011374-ce20-4f2f-96f1-8a5c0bd38a51' , '49fe0661-bfb3-44b5-befb-2add97496876');

--INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
--VALUES('49fe0661-bfb3-44b5-befb-2add97496876', 'ASAR', 'a9ba025d-be15-4152-8e96-41f0506a1ff9', 'eca6f2d2-e3c6-474c-8c4a-d4ee53381883', '381f1793-744c-4c4f-a409-809a260dcc45', 'CWCW', 'CWSP', '02b7901e-2061-429f-aa74-02bf22060a03', 15, 0, 'a9ba025d-be15-4152-8e96-41f0506a1ff9', '2022-10-13 15:23:06.371', 'eca6f2d2-e3c6-474c-8c4a-d4ee53381883', '2022-10-18 14:20:01.985', true, 'Adoption Agreement Submitted for Review', NULL, 'Adoption Agreement Submitted for Review', '3215678', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
--
--INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
--VALUES('54011374-ce20-4f2f-96f1-8a5c0bd38a51', 'ASAR', 'eca6f2d2-e3c6-474c-8c4a-d4ee53381883', 'a9ba025d-be15-4152-8e96-41f0506a1ff9', '381f1793-744c-4c4f-a409-809a260dcc45', 'CWSP', 'CWCW', '02b7901e-2061-429f-aa74-02bf22060a03', 17, 1, 'a9ba025d-be15-4152-8e96-41f0506a1ff9', '2022-10-18 14:20:01.985', 'a9ba025d-be15-4152-8e96-41f0506a1ff9', '2022-10-18 14:20:01.985', true, 'Adoption Agreement Rejected', NULL, 'Adoption Agreement Rejected', '3215678', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

delete 	from routing
where 	objectid = '02b7901e-2061-429f-aa74-02bf22060a03'
		and routingid in ('54011374-ce20-4f2f-96f1-8a5c0bd38a51' , '49fe0661-bfb3-44b5-befb-2add97496876');

select 	approvalstatustypekey, * from adoptioncaseagreementrevision
where 	adoptioncaseagreementid = '02b7901e-2061-429f-aa74-02bf22060a03'
		and adoptioncaseagreementrevisionid = 'c02e5e27-4f53-42ee-9b2e-dd51294b1908'
		and approvalstatustypekey = '3047';

update  adoptioncaseagreementrevision
set 	approvalstatustypekey = '3047',
		updatedby = 'CDM-27556',
		updatedon = now()
where 	adoptioncaseagreementid = '02b7901e-2061-429f-aa74-02bf22060a03'
		and adoptioncaseagreementrevisionid = 'c02e5e27-4f53-42ee-9b2e-dd51294b1908';

update  adoptioncaseagreementrevision
set 	activeflag = 0,
		updatedby = 'CDM-27556',
		updatedon = now()
where 	adoptioncaseagreementid = '02b7901e-2061-429f-aa74-02bf22060a03'
		and adoptioncaseagreementrevisionid = 'be434afa-5d2f-44ef-bcff-36c9be517e4d';