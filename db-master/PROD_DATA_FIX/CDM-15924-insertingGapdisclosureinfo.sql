/*
   Issue Description: CDM-15924
   Category/ Module  :  
   Root cause: Inserting Gap disclosure
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


INSERT INTO cjams.gapdisclosure
(gapdisclosureid, gapid, disclosuredate, ischildplacedsixmonths, isproviderapprovedgap, iscourthearingcustody, isreunificationremoved, isadoptionremoved, iscgprovidesafe, isothergapfinsupport, iscgattendedorientation, orientationmeetingdate, isrequirementdiscussed, iscgparticipategap, iscgenteredagreement, iscgcompleteauthorization, iscgaftercareservice, isneedadditionalservices, iscgcompleteannualreview, issuspendedfromguardian, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, issuccessorguardianexists, isconsultationchildage, isguardianattach, isguardiantwoattach, etl_userid, etl_load_date)
VALUES(gen_random_uuid(),'755faa37-7d8f-4c09-a085-4434632bc22e'::uuid, now(), true, true, true, true, NULL, NULL, NULL, NULL, now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, now(), 'CDM-15924', now(), 'CDM-15924', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('GADR', 'edc6e303-cb43-49ce-b246-87d46656f8a0', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', NULL, 'CWSP', 'CWCW', (select gapdisclosureid from gapdisclosure where gapid = '755faa37-7d8f-4c09-a085-4434632bc22e' order by updatedon desc limit 1), 16, 1, 'CDM-15924', now(), 'CDM-15924', now(), false, 'Guardianship Disclosure Review', NULL, 'Guardianship Disclosure Review', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.gapdisclosure
(gapdisclosureid, gapid, disclosuredate, ischildplacedsixmonths, isproviderapprovedgap, iscourthearingcustody, isreunificationremoved, isadoptionremoved, iscgprovidesafe, isothergapfinsupport, iscgattendedorientation, orientationmeetingdate, isrequirementdiscussed, iscgparticipategap, iscgenteredagreement, iscgcompleteauthorization, iscgaftercareservice, isneedadditionalservices, iscgcompleteannualreview, issuspendedfromguardian, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, issuccessorguardianexists, isconsultationchildage, isguardianattach, isguardiantwoattach, etl_userid, etl_load_date)
VALUES(gen_random_uuid(),'54b6a1c2-4f4f-403e-a09e-9b13dbc980bf'::uuid, now(), true, true, true, true, NULL, NULL, NULL, NULL, now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, now(), 'CDM-15924', now(), 'CDM-15924', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('GADR', 'edc6e303-cb43-49ce-b246-87d46656f8a0', '65a64788-bb87-4d05-a880-b165b989772b', NULL, 'CWSP', 'CWCW', (select gapdisclosureid from gapdisclosure where gapid = '54b6a1c2-4f4f-403e-a09e-9b13dbc980bf' order by updatedon desc limit 1), 16, 1, 'CDM-15924', now(), 'CDM-15924', now(), false, 'Guardianship Disclosure Review', NULL, 'Guardianship Disclosure Review', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
