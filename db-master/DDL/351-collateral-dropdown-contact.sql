/*Changes to save the details from Add Note view under Contact tab,
that resulted due to addition of collateral into Involved persons*/
ALTER TABLE cjams.contactparticipant ADD participantid uuid NULL;
ALTER TABLE contactparticipant DROP CONSTRAINT fk_contactparticipant_intakeservicerequestactor;