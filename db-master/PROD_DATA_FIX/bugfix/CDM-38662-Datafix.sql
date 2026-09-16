/* 
    Issue Description: CDM-38662
   Category/ Module  : can't resubmit a case
   Root cause: data fix to remove the Override and submission records from the intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/



DELETE FROM cjams.routing
WHERE routingid='0f36aaa3-a234-429f-8e43-ef91c532ab9f'::uuid and eventcode ='INTR' and activeflag =1;

DELETE FROM administrativeoverrides WHERE administrativeoverrideid ='86315f75-c513-4e4f-9127-def90377cc00' and entityid ='I241012168621'
and activeflag =1;

/*INSERT INTO cjams.administrativeoverrides
(administrativeoverrideid, approvalid, entitytypekey, entityid, referralsnapshotid, overridereasontypekey, overridetypekey, overridedate, overridetimestamp, overridestaffid, "comments", insertedon, insertedby, updatedon, updatedby, activeflag, overridekeyid, intakeserviceid, old_id, etl_userid, etl_load_date, intakeapproveddate, contactmadewithhhmember)
VALUES('86315f75-c513-4e4f-9127-def90377cc00'::uuid, '00000000-0000-0000-0000-000000000000'::uuid, '2530', 'I241012168621', NULL, 'ATNA', '2530', '2024-04-26 16:05:09.784', '2024-04-26 16:05:09.784', 'a0b41798-e864-415d-8647-1a44cb6c5bda', '', '2024-04-26 12:05:31.331', 'a0b41798-e864-415d-8647-1a44cb6c5bda', '2024-04-26 12:05:31.331', 'a0b41798-e864-415d-8647-1a44cb6c5bda', 1, 1, NULL, NULL, NULL, NULL, NULL, false);*/



/*INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('0f36aaa3-a234-429f-8e43-ef91c532ab9f'::uuid, 'INTR', 'a0b41798-e864-415d-8647-1a44cb6c5bda', '296f7e4f-77e5-41e5-8a2f-7264cc4e08bf', 'd5abb69f-8086-4645-bb56-5ef8825d412d'::uuid, 'CWSP', 'CWIW', 'I241012168621', 861, 1, 'a0b41798-e864-415d-8647-1a44cb6c5bda', '2024-04-26 12:05:31.331', 'a0b41798-e864-415d-8647-1a44cb6c5bda', '2024-04-26 12:05:31.331', false, 'Return to worker', NULL, 'Return to Worker', ' ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Scrnin', 'Return to Worker', NULL);*/ 