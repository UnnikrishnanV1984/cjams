
/*
   Issue Description: CDM-35889
   Category/ Module  : Relationship
   Root cause: User requested to update the relationship to show that Ms Hurel is ID as the Foster Parent and the caregiver to Delilah Mellerson.
   Resolution: There is no actorrelation for Hurel to Deliah, so Inserted the actorrelationship to show as foster parent and caregiver.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




INSERT INTO
   actorrelationship (actorrelationshipid, relationshiptypekey, insertedby, insertedon, updatedby, updatedon, "timestamp", effectivedate, expirationdate, activeflag, intakeservicerequestactorid, old_id, client1id, client2id, caregiverflag, paternityestdflag, paternityestddate, paternitycourtorderflag, maternityestdflag, maternityestddate, maternitycourtorderflag, "comments", startdate, enddate, sysgenflag, origclientid, caseid, referralid, expungementflag, datavalidflag, clientmergeid, fk1_id, fk2_id, fk3_id, person1id, person2id, servicecaseid, intakeserviceid, intakenumber, etl_userid, etl_load_date) 
VALUES
   (
      gen_random_uuid(), 'FOSPARNT', '61a869f9-2624-457b-b0b0-47e1669e1f52', '2022-10-14 16:02:01', 'CDM-35889', now(), null, '2022-10-14 16:02:01', null, 1, '1b5eca98-37b5-4e79-8bf7-301ddd736527', null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'ac1e4167-9b00-4e91-9b96-80bda0b32c93', 'ae81dd04-4ee1-4176-89d4-1da3901f78b0', null, null, null, null, null
   )
;
	