/*
   Issue Description: CDM-15958
   Category/ Module  :  Gurdianship checklist
   Root cause: user wants to close
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:
   user wants to enable the gurdianship 6 months radio button option for two cases 
  */


-- 3287913 
	with gap_disclosure as (
			INSERT INTO cjams.gapdisclosure
			(gapid, ischildplacedsixmonths, isproviderapprovedgap, iscourthearingcustody, isreunificationremoved, isadoptionremoved, iscgprovidesafe, isothergapfinsupport, iscgattendedorientation, isrequirementdiscussed, iscgparticipategap, iscgenteredagreement, iscgcompleteauthorization, iscgaftercareservice, isneedadditionalservices, iscgcompleteannualreview, issuspendedfromguardian, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, issuccessorguardianexists, isconsultationchildage, isguardianattach, isguardiantwoattach, etl_userid, etl_load_date)
			VALUES('ed1e954a-d4cc-488d-ab7e-8349765ef97f'::uuid, true, true, true, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, now(), 'CDM-15958', now(), 'CDM-15958', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL) returning gapdisclosureid
	)

	INSERT INTO cjams.routing
	(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
	VALUES('GADR', '3cd897ec-0c87-4ce5-8f5a-90fe9d97ad0f', '056865a7-2a58-494e-9993-ccc6fd9aae58', NULL, 'CWSP', 'CWCW', (select * from gap_disclosure), 16, 1, 'CDM-15958', now(), 'CDM-15958', now(), false, 'Guardianship Disclosure Review', NULL, 'Guardianship Disclosure Review', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


	-- 3301982
	with gap_disclosure as (
			INSERT INTO cjams.gapdisclosure
			(gapid, ischildplacedsixmonths, isproviderapprovedgap, iscourthearingcustody, isreunificationremoved, isadoptionremoved, iscgprovidesafe, isothergapfinsupport, iscgattendedorientation, isrequirementdiscussed, iscgparticipategap, iscgenteredagreement, iscgcompleteauthorization, iscgaftercareservice, isneedadditionalservices, iscgcompleteannualreview, issuspendedfromguardian, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, issuccessorguardianexists, isconsultationchildage, isguardianattach, isguardiantwoattach, etl_userid, etl_load_date)
			VALUES('6255586c-7ba6-4abe-b921-254db29539af'::uuid, true, true, true, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, now(), 'CDM-15958', now(), 'CDM-15958', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL) returning gapdisclosureid
	)

	INSERT INTO cjams.routing
	(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
	VALUES('GADR', '3cd897ec-0c87-4ce5-8f5a-90fe9d97ad0f', '056865a7-2a58-494e-9993-ccc6fd9aae58', NULL, 'CWSP', 'CWCW', (select * from gap_disclosure), 16, 1, 'CDM-15958', now(), 'CDM-15958', now(), false, 'Guardianship Disclosure Review', NULL, 'Guardianship Disclosure Review', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);