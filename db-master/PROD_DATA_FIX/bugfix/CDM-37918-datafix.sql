/*
   Issue Description: CDM-37918
   Category/ Module  : 3174416
   Root cause: please delete suspension dates immediately because they are incorrect and 
                this will cause payment delay. Due to the suspension date sthe subsidy dates are incorrect. The correct dates is 12/01/2023. 
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- Delete Rate - 2024-03-06 To 2024-02-22
delete  from adoptioncaseagreementrate
where adoptionagreementrateid = 'f75babea-cbb6-407d-9f2a-62677da4876b'
and adoptionagreementid='6bc8a246-7a6e-41cd-ba37-a6bf12a1a0df'
and activeflag =1;

delete from adoptioncaserevision a
where adoptionagreementrateid = 'f75babea-cbb6-407d-9f2a-62677da4876b';
--and adoptionrevisionid='cdabe9da-4306-46d8-923f-372346ccf3a4'
--and activeflag =1;

delete from routing r
where objectid = 'f75babea-cbb6-407d-9f2a-62677da4876b';
--and routingid='b5d96dfe-f5ed-41c7-b63e-0484258afce3'
--and eventcode = 'AARR'
--and activeflag =1;

-- Delete from adoptioncasesuspension

delete from adoptioncasesuspension
where adoptionsuspensionid = '02638be9-8e81-4e6b-879a-ed8bed11821f'
and adoptioncaseid='201430d2-4ccf-4ac3-ba53-e8bc1d188848'
and activeflag = 1;

delete from adoptioncasesuspension
where adoptionsuspensionid= '0c83abbe-6e93-4e6b-8512-ae4cf4305424'
and adoptioncaseid='201430d2-4ccf-4ac3-ba53-e8bc1d188848'
and activeflag = 1;

-- Delete from adoptioncasesuspensionrevision table 

delete from adoptioncasesuspensionrevision a
where adoptionsuspensionid = '02638be9-8e81-4e6b-879a-ed8bed11821f'
and adoptionsuspensionrevisionid='e3ed883a-a21a-4e11-8e76-0f2ae6227526'
and activeflag = 1;

delete from adoptioncasesuspensionrevision a
where adoptionsuspensionid= '0c83abbe-6e93-4e6b-8512-ae4cf4305424' 
and adoptionsuspensionrevisionid='4b007cc0-888c-4c05-8ed7-03601bdb8cad'
and activeflag = 1;

-- 2024-03-06 2025-02-05  for finance Batch
update adoptioncaseagreementrate set updatedby='CDM-37918', updatedon=now()
where adoptionagreementrateid='bdeeee29-354e-4142-b2f9-331511942aae' and activeflag=1;

-- 2023-12-01 2024-03-05 for finance Batch
update adoptioncaseagreementrate set updatedby='CDM-37918', updatedon=now()
where adoptionagreementrateid='6a59c4a9-1d7c-44c1-87f5-c654c4076bb3' and activeflag=1;



/*
INSERT INTO cjams.adoptioncaserevision
(adoptionrevisionid, adoptionagreementid, transactiondate, agreementtypetypekey, adoptivemotherid, adoptivefatherid, startdate, enddate, paymentamout, notes, isssaapproved, ssaapproveddate, isspeacialneeds, specialneedtypekey, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, provider_id, alternateid, adoptionagreementrateid, old_id, etl_userid, etl_load_date, isapproval, parent1providername, parent2providername, childrelationship, effectivedate, specialneedremarks, rateoverwrittensw, status)
VALUES('36f5e797-c841-4b2a-9a3d-71ebf636e891'::uuid, '6bc8a246-7a6e-41cd-ba37-a6bf12a1a0df'::uuid, '2024-03-12 18:20:43.529', NULL, NULL, NULL, '2024-03-06 05:00:00.000', '2024-02-22 00:00:00.000', 835, NULL, NULL, NULL, true, 'ADCD', '3045', NULL, NULL, '2024-03-12 14:22:05.000', 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', '2024-03-12 15:43:16.671', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 0, 5014977, 1298343, 'f75babea-cbb6-407d-9f2a-62677da4876b'::uuid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-03-12 14:22:05.000', NULL, NULL, 'Review');
INSERT INTO cjams.adoptioncaserevision
(adoptionrevisionid, adoptionagreementid, transactiondate, agreementtypetypekey, adoptivemotherid, adoptivefatherid, startdate, enddate, paymentamout, notes, isssaapproved, ssaapproveddate, isspeacialneeds, specialneedtypekey, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, provider_id, alternateid, adoptionagreementrateid, old_id, etl_userid, etl_load_date, isapproval, parent1providername, parent2providername, childrelationship, effectivedate, specialneedremarks, rateoverwrittensw, status)
VALUES('2ed5317b-b4f0-43f1-b414-acef3a3cdcc2'::uuid, '6bc8a246-7a6e-41cd-ba37-a6bf12a1a0df'::uuid, '2024-03-12 18:20:43.529', NULL, NULL, NULL, '2024-03-06 05:00:00.000', '2024-02-22 00:00:00.000', 835, NULL, NULL, NULL, true, 'ADCD', '3047', '2024-03-12 15:43:16.671', NULL, '2024-03-12 15:43:16.671', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', '2024-03-12 15:43:16.671', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 1, 5014977, 1298409, 'f75babea-cbb6-407d-9f2a-62677da4876b'::uuid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-03-12 14:22:05.000', NULL, NULL, 'Approved');
INSERT INTO cjams.adoptioncaserevision
(adoptionrevisionid, adoptionagreementid, transactiondate, agreementtypetypekey, adoptivemotherid, adoptivefatherid, startdate, enddate, paymentamout, notes, isssaapproved, ssaapproveddate, isspeacialneeds, specialneedtypekey, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, provider_id, alternateid, adoptionagreementrateid, old_id, etl_userid, etl_load_date, isapproval, parent1providername, parent2providername, childrelationship, effectivedate, specialneedremarks, rateoverwrittensw, status)
VALUES('f7584df5-508e-4ae6-8f3c-0bf8306ba764'::uuid, '6bc8a246-7a6e-41cd-ba37-a6bf12a1a0df'::uuid, '2024-03-12 18:20:43.529', NULL, NULL, NULL, '2024-03-06 05:00:00.000', '2024-02-22 00:00:00.000', 835, NULL, NULL, NULL, true, 'ADCD', '3045', '2024-03-12 15:43:16.671', NULL, '2024-03-12 16:05:57.000', 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', '2024-03-12 16:11:45.057', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 0, 5014977, 1298476, 'f75babea-cbb6-407d-9f2a-62677da4876b'::uuid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-03-12 16:05:57.000', NULL, NULL, 'Review');
INSERT INTO cjams.adoptioncaserevision
(adoptionrevisionid, adoptionagreementid, transactiondate, agreementtypetypekey, adoptivemotherid, adoptivefatherid, startdate, enddate, paymentamout, notes, isssaapproved, ssaapproveddate, isspeacialneeds, specialneedtypekey, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, provider_id, alternateid, adoptionagreementrateid, old_id, etl_userid, etl_load_date, isapproval, parent1providername, parent2providername, childrelationship, effectivedate, specialneedremarks, rateoverwrittensw, status)
VALUES('b81bf67b-2451-4528-8d30-3f9168f08e27'::uuid, '6bc8a246-7a6e-41cd-ba37-a6bf12a1a0df'::uuid, '2024-03-12 18:20:43.529', NULL, NULL, NULL, '2024-03-06 05:00:00.000', '2024-02-22 00:00:00.000', 835, NULL, NULL, NULL, true, 'ADCD', '3045', '2024-03-12 16:11:45.057', NULL, '2024-03-12 16:11:45.057', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', '2024-03-13 10:23:04.484', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 0, 5014977, 1298477, 'f75babea-cbb6-407d-9f2a-62677da4876b'::uuid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-03-12 16:05:57.000', NULL, NULL, 'Rejected');
INSERT INTO cjams.adoptioncaserevision
(adoptionrevisionid, adoptionagreementid, transactiondate, agreementtypetypekey, adoptivemotherid, adoptivefatherid, startdate, enddate, paymentamout, notes, isssaapproved, ssaapproveddate, isspeacialneeds, specialneedtypekey, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, provider_id, alternateid, adoptionagreementrateid, old_id, etl_userid, etl_load_date, isapproval, parent1providername, parent2providername, childrelationship, effectivedate, specialneedremarks, rateoverwrittensw, status)
VALUES('4c9239c8-c8b9-4535-9274-15dd571a09af'::uuid, '6bc8a246-7a6e-41cd-ba37-a6bf12a1a0df'::uuid, '2024-03-12 18:20:43.529', NULL, NULL, NULL, '2024-03-06 05:00:00.000', '2024-02-22 00:00:00.000', 835, NULL, NULL, NULL, true, 'ADCD', '3045', '2024-03-13 10:23:04.484', NULL, '2024-03-13 10:23:04.484', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', '2024-03-20 16:27:09.296', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 0, 5014977, 1298756, 'f75babea-cbb6-407d-9f2a-62677da4876b'::uuid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-03-12 16:05:57.000', NULL, NULL, 'Rejected');
INSERT INTO cjams.adoptioncaserevision
(adoptionrevisionid, adoptionagreementid, transactiondate, agreementtypetypekey, adoptivemotherid, adoptivefatherid, startdate, enddate, paymentamout, notes, isssaapproved, ssaapproveddate, isspeacialneeds, specialneedtypekey, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, provider_id, alternateid, adoptionagreementrateid, old_id, etl_userid, etl_load_date, isapproval, parent1providername, parent2providername, childrelationship, effectivedate, specialneedremarks, rateoverwrittensw, status)
VALUES('cdabe9da-4306-46d8-923f-372346ccf3a4'::uuid, '6bc8a246-7a6e-41cd-ba37-a6bf12a1a0df'::uuid, '2024-03-12 18:20:43.529', NULL, NULL, NULL, '2024-03-06 05:00:00.000', '2024-02-22 00:00:00.000', 835, NULL, NULL, NULL, true, 'ADCD', '3047', '2024-03-20 16:27:09.296', NULL, '2024-03-20 16:27:09.296', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', '2024-03-20 16:27:09.296', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 1, 5014977, 1300854, 'f75babea-cbb6-407d-9f2a-62677da4876b'::uuid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-03-12 16:05:57.000', NULL, NULL, 'Approved');
*/
/*
INSERT INTO cjams.adoptioncaseagreementrate
(adoptionagreementrateid, adoptionagreementid, startdate, enddate, provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, parent1actorid, parent2actorid, childrelationship, notes, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, fk_id, isssaapproved, ssaapproveddate, etl_userid, etl_load_date)
VALUES('f75babea-cbb6-407d-9f2a-62677da4876b'::uuid, '6bc8a246-7a6e-41cd-ba37-a6bf12a1a0df'::uuid, '2024-03-06 05:00:00.000', '2024-02-22 00:00:00.000', 5014977, 835, NULL, '2024-03-20 16:27:09.296', 1, NULL, NULL, NULL, NULL, 1, '2024-03-12 16:05:57.000', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', '2024-03-20 16:27:09.296', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', '2024-03-20 16:27:09.296', NULL, 'ADCD', NULL, '2024-03-12 18:20:43.529', NULL, 'Approved', NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('eb426a27-94e3-4646-99da-6913a326c176'::uuid, 'AARR', 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 'c9ac2fa2-b9ab-4ca9-a85d-9e429506a95a'::uuid, 'LDSSRW', 'CWSP', 'f75babea-cbb6-407d-9f2a-62677da4876b', 15, 0, 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', '2024-03-12 16:51:41.203', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', '2024-03-13 10:23:04.484', true, 'Adoption Agreement Rate Submitted for Review', NULL, 'Adoption Agreement Rate Submitted for Review', '3174416', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('01c25b31-d3c8-4c64-95af-93d787f08412'::uuid, 'AARR', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', 'c9ac2fa2-b9ab-4ca9-a85d-9e429506a95a'::uuid, 'CWSP', 'LDSSRW', 'f75babea-cbb6-407d-9f2a-62677da4876b', 17, 1, 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', '2024-03-13 10:23:04.484', 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', '2024-03-13 10:23:04.484', true, 'Adoption Agreement Rate Rejected', NULL, 'Adoption Agreement Rate Rejected', '3174416', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('bf79bace-a83b-4263-a907-b91d82cb9d16'::uuid, 'AARR', 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 'c9ac2fa2-b9ab-4ca9-a85d-9e429506a95a'::uuid, 'LDSSRW', 'CWSP', 'f75babea-cbb6-407d-9f2a-62677da4876b', 15, 0, 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', '2024-03-12 14:21:35.363', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', '2024-03-12 15:43:16.671', true, 'Adoption Agreement Rate Submitted for Review', NULL, 'Adoption Agreement Rate Submitted for Review', '3174416', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('eb5f674f-1012-46bb-93c6-d0276661435c'::uuid, 'AARR', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', 'c9ac2fa2-b9ab-4ca9-a85d-9e429506a95a'::uuid, 'CWSP', 'LDSSRW', 'f75babea-cbb6-407d-9f2a-62677da4876b', 16, 1, 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', '2024-03-12 15:43:16.671', 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', '2024-03-12 15:43:16.671', true, 'Adoption Agreement Rate Approved', NULL, 'Adoption Agreement Rate Approved', '3174416', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('58062a34-7694-4147-bc9c-6b891ab13bb1'::uuid, 'AARR', 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 'c9ac2fa2-b9ab-4ca9-a85d-9e429506a95a'::uuid, 'LDSSRW', 'CWSP', 'f75babea-cbb6-407d-9f2a-62677da4876b', 15, 0, 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', '2024-03-12 16:05:28.561', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', '2024-03-12 16:11:45.057', true, 'Adoption Agreement Rate Submitted for Review', NULL, 'Adoption Agreement Rate Submitted for Review', '3174416', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ce2f0caf-dcc2-4a84-af02-e13d9319e34b'::uuid, 'AARR', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', 'c9ac2fa2-b9ab-4ca9-a85d-9e429506a95a'::uuid, 'CWSP', 'LDSSRW', 'f75babea-cbb6-407d-9f2a-62677da4876b', 17, 1, 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', '2024-03-12 16:11:45.057', 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', '2024-03-12 16:11:45.057', true, 'Adoption Agreement Rate Rejected', NULL, 'Adoption Agreement Rate Rejected', '3174416', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('4b2a01fc-4775-4d0a-9ae6-639da931bdd6'::uuid, 'AARR', 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 'c9ac2fa2-b9ab-4ca9-a85d-9e429506a95a'::uuid, 'LDSSRW', 'CWSP', 'f75babea-cbb6-407d-9f2a-62677da4876b', 15, 0, 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', '2024-03-20 16:24:01.572', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', '2024-03-20 16:27:09.296', true, 'Adoption Agreement Rate Submitted for Review', NULL, 'Adoption Agreement Rate Submitted for Review', '3174416', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('b5d96dfe-f5ed-41c7-b63e-0484258afce3'::uuid, 'AARR', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', 'c9ac2fa2-b9ab-4ca9-a85d-9e429506a95a'::uuid, 'CWSP', 'LDSSRW', 'f75babea-cbb6-407d-9f2a-62677da4876b', 16, 1, 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', '2024-03-20 16:27:09.296', 'ba6dffd3-edb8-4a9b-bb35-0d7fa7d24516', '2024-03-20 16:27:09.296', true, 'Adoption Agreement Rate Approved', NULL, 'Adoption Agreement Rate Approved', '3174416', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.adoptioncasesuspension
(adoptionsuspensionid, adoptioncaseid, transactiondate, suspensionreasontypekey, suspensionbegindate, suspensionenddate, suspensionremarks, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, effectivedate, old_id, suspensionreasonremarks, alternateid, adoptionagreementid, etl_userid, etl_load_date)
VALUES('02638be9-8e81-4e6b-879a-ed8bed11821f'::uuid, '201430d2-4ccf-4ac3-ba53-e8bc1d188848'::uuid, '2024-03-12 11:22:06.000', 'ARSG', '2024-01-01 05:00:00.000', '2024-03-05 05:00:00.000', NULL, '3047', '2024-03-20 16:32:51.572', NULL, '2024-03-20 16:32:51.572', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', '2024-03-20 16:32:51.572', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 1, '2024-03-12 11:22:06.000', NULL, NULL, NULL, '6bc8a246-7a6e-41cd-ba37-a6bf12a1a0df'::uuid, NULL, NULL);


INSERT INTO cjams.adoptioncasesuspension
(adoptionsuspensionid, adoptioncaseid, transactiondate, suspensionreasontypekey, suspensionbegindate, suspensionenddate, suspensionremarks, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, effectivedate, old_id, suspensionreasonremarks, alternateid, adoptionagreementid, etl_userid, etl_load_date)
VALUES('0c83abbe-6e93-4e6b-8512-ae4cf4305424'::uuid, '201430d2-4ccf-4ac3-ba53-e8bc1d188848'::uuid, '2024-03-12 13:51:11.000', NULL, '2024-01-01 05:00:00.000', '2024-02-22 05:00:00.000', NULL, '3047', '2024-03-12 15:42:13.085', NULL, '2024-03-12 15:42:13.085', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', '2024-03-12 15:42:13.085', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 1, '2024-03-12 13:51:11.000', NULL, NULL, NULL, '6bc8a246-7a6e-41cd-ba37-a6bf12a1a0df'::uuid, NULL, NULL);


INSERT INTO cjams.adoptioncasesuspensionrevision
(adoptionsuspensionrevisionid, adoptionsuspensionid, transactiondate, suspensionreasontypekey, suspensionbegindate, suspensionenddate, suspensionremarks, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, effectivedate, old_id, suspensionreasonremarks, alternateid, adoptionagreementid, adoptioncaseid, etl_userid, etl_load_date)
VALUES('e3ed883a-a21a-4e11-8e76-0f2ae6227526'::uuid, '02638be9-8e81-4e6b-879a-ed8bed11821f'::uuid, '2024-03-20 16:32:51.572', NULL, '2024-01-01 10:00:00.000', '2024-03-05 05:00:00.000', NULL, '3047', '2024-03-20 16:32:51.572', NULL, '2024-03-20 16:32:51.572', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', '2024-03-20 16:32:51.572', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 1, '2024-03-20 16:32:39.000', NULL, NULL, NULL, '6bc8a246-7a6e-41cd-ba37-a6bf12a1a0df'::uuid, '201430d2-4ccf-4ac3-ba53-e8bc1d188848'::uuid, NULL, NULL);

INSERT INTO cjams.adoptioncasesuspensionrevision
(adoptionsuspensionrevisionid, adoptionsuspensionid, transactiondate, suspensionreasontypekey, suspensionbegindate, suspensionenddate, suspensionremarks, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, effectivedate, old_id, suspensionreasonremarks, alternateid, adoptionagreementid, adoptioncaseid, etl_userid, etl_load_date)
VALUES('4b007cc0-888c-4c05-8ed7-03601bdb8cad'::uuid, '0c83abbe-6e93-4e6b-8512-ae4cf4305424'::uuid, '2024-03-12 15:42:13.085', NULL, '2024-01-01 05:00:00.000', '2024-02-22 05:00:00.000', NULL, '3047', '2024-03-12 15:42:13.085', NULL, '2024-03-12 15:42:13.085', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', '2024-03-12 15:42:13.085', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 1, '2024-03-12 13:51:11.000', NULL, NULL, NULL, '6bc8a246-7a6e-41cd-ba37-a6bf12a1a0df'::uuid, '201430d2-4ccf-4ac3-ba53-e8bc1d188848'::uuid, NULL, NULL);

*/
