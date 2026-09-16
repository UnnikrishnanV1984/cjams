/*
Issue: CJAMS-64010 Placement Exit
Category/Module: Placement Exit
Root cause: The placement is rejected on 10/06/2021 and there is an open CPA Home placement for this private provider.
            Data fix has been done for showing the placement record as approved and Exit with the date of 07/01/2021 at 5:00 PM  
            and the corresponding CPA Home should to be exited on 07/01/2021 at 5:00 PM, Provider vacany also needs to be released.
            Client ID: 1717709
            Provider ID: 5001424 (King Edwards' Inc. ILP and Teen Parent ILP)
            Placement ID: 335350
            CPA Home Provider ID: 5078468 (King Edwards' ILP - 5805 B Hillen)
Fix provided: Data fix has been done for showing the placement record as approved and Exit with the date of 07/01/2021 at 5:00 PM  
             and the corresponding CPA Home should to be exited on 07/01/2021 at 5:00 PM, Provider vacany also needs to be released.
Data/Code fix ticket#: CJAMS-64010
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a user error and data fix should resolve it. 
*/

--Inserting approval record in routing
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'PLTR', 'f3ba0abc-1278-4f79-ae3c-dfb167940c87', 'f3ba0abc-1278-4f79-ae3c-dfb167940c87', '1d7a4627-4136-4ba3-94b8-727185c4dfdd', 'CWSP', 'CWSP', '48828ae2-07f9-4685-81da-10e6ce929ca7', 16, 1, 'f3ba0abc-1278-4f79-ae3c-dfb167940c87', now(), 'f3ba0abc-1278-4f79-ae3c-dfb167940c87', now(), true, 'Child Placement Approved as part of CJAMS-64010', NULL, 'Child PlacementApproved', '3155697', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--Exiting the placement 
update placement  
set enddatetime = '2021-07-01 17:00:00',
	endtime = '17:00',
	exitreasontypekey = 'CIPO', -- Other
	exittypekey = 'CIP', --	Change in Placement
    remarks = 'Placement Exited as the part of data fix ticket CJAMS-64010',
	updatedon = now(), 
	updatedby = 'CJAMS-64010'
where placementid = '48828ae2-07f9-4685-81da-10e6ce929ca7'
	and activeflag = 1 ;

update placementrevision
set exitdate = '2021-07-01 17:00:00',
	exittime = '17:00',
	exitreasontypkey = 'CIPO', -- Other
	exittypekey = 'CIP', --	Change in Placement
	status =  'Approved',
	approvedby = 'f3ba0abc-1278-4f79-ae3c-dfb167940c87',
	approveddate = '2021-07-01 17:00:00',
	approvaldate = '2021-07-01 17:00:00',
	updatedon = now(), 
	updatedby = 'CJAMS-64010'	
where placementid  = '48828ae2-07f9-4685-81da-10e6ce929ca7';

--Exiting the open CPA home
update placementcpahomes
set exitdt = '2021-07-01 17:00:00',
    exittm = '2021-07-01 17:00:00',
    exittypecd = 'CIP',
    updatets = now(),
    updateuserid = 'CJAMS-64010'
where placementid  = '48828ae2-07f9-4685-81da-10e6ce929ca7'
    and placementcpahomeid = '00d45532-851e-4ddf-915a-68899234e527';

--Releasing the provider vacancy
update prov.tb_contract_program
set vacancy_no = vacancy_no + 1,
    update_user_id = 'CJAMS-64010',
    update_ts = now()
where program_id = 1274
    and delete_sw = 'N' ;    
