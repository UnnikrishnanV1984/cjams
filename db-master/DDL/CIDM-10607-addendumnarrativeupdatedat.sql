  alter table intakeservicerequest 
add column if not  exists addendumNarrativeUpdateddate timestamp ;
COMMENT ON COLUMN cjams.intakeservicerequest.addendumNarrativeUpdateddate IS 'to store addedndumNarrative updated date value';