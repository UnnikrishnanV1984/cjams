
/*
-- Issue Description: Need data fix to delete the hospitalization and inpatient medical living arrangement records from the child Ny'aye Flagg (PID: 204202090).
-- Root cause: Worker mistakenly created a hospitalization and inpatient medical living arrangement record for the child Ny'aye Flagg (PID: 204202090) in error.
-- Fix Provided: Datafix has been promoted to soft delete the records in the personhospitalization, personhospitalization_history and livingarrangement tables.
-- Regression Impacts: N/A
-- Is Code fix Required?: No
-- Code fix ticket#: N/A
-- Reason why no related code fix: User error, no code fix needed.
-- Status of the code fix: Data fix completed, PR raised for documentation.
-- Backup before update/ delete: Query:
   select * from personhospitalization where hospitalizationid='7e7829ad-29d5-4705-9e01-2c0d62d9d1cf';
   select * from personhospitalization_history where personhospitalizationhistoryid='15d94b13-f540-4a0a-a879-12c3692f4e00';
   select * from livingarrangement where livingid ='5479348b-c035-45e7-af49-142f65d1e29d';

*/
update personhospitalization set activeflag=0, updatedby='CJAMS-65937', updatedon=now()
where hospitalizationid='7e7829ad-29d5-4705-9e01-2c0d62d9d1cf';

update personhospitalization_history set activeflag=0, updatedby='CJAMS-65937', updatedon=now()
where personhospitalizationhistoryid='15d94b13-f540-4a0a-a879-12c3692f4e00';

update livingarrangement set activeflag=0, updatedby='CJAMS-65937', updatedon=now()
where livingid ='5479348b-c035-45e7-af49-142f65d1e29d';

update placement set activeflag=0, updatedby='CJAMS-65937', updatedon=now()
where placementid='954466ff-2d7e-4a1f-8de0-25a73e3be872';

update placementrevision set activeflag=0, updatedby='CJAMS-65937', updatedon=now()
where placementrevisionidid ='3a576d29-2c95-4500-b7f1-d809c8635e7b';