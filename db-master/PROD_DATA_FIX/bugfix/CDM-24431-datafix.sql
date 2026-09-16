/*
   Issue Description: CDM-24431
   Category/ Module  : Referral Intake/Sercicecase
   Root cause: User requests to unconnect the Intake I221010304108 with service case 221030017847 then connecting the intake to prior service case 211030011711

   Reason why no related code fix: User requests to unconnect the Intake I221010304108 with service case 221030017847 then connecting the intake to prior service case 211030011711.
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservicerequest  
set servicecaseid =null, updatedby = 'CDM-24431', updatedon = now() 
where intakeserviceid ='96055239-3b22-41be-ac2b-86918c271a5f';

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-24431', updatedon = now()
where intakenumber = 'I221010304108' and activeflag = 1;

update servicecase
set activeflag = 0, updatedby = 'CDM-24431', updatedon = now()
where servicecaseid = '6bb58c91-07f3-4b6c-beb8-36fe46d348c3';

update intakeservicerequest
set servicecaseid = 'a6089c87-297e-4047-a88e-b0b0d283da80', updatedby = 'CDM-24431', updatedon = now()
where intakeserviceid ='96055239-3b22-41be-ac2b-86918c271a5f';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), '6bb58c91-07f3-4b6c-beb8-36fe46d348c3', now(), 'Closed', 'Closed', 'Closing Case as per CDM-24431 request', now(), 1, 'e43f1b33-ac78-468a-8aa8-64b49a801749', now(), 'e43f1b33-ac78-468a-8aa8-64b49a801749', now(), null, null, '', null);

update caseassignment
set activeflag=0, updatedby = 'CDM-24431', updatedon = now()
WHERE objectid = '6bb58c91-07f3-4b6c-beb8-36fe46d348c3' AND activeflag=1;

update personprogramarea
set activeflag=0, updatedby = 'CDM-24431', updatedon = now()
WHERE objectid = '6bb58c91-07f3-4b6c-beb8-36fe46d348c3' AND activeflag=1;
