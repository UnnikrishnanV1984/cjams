delete from hearingstatustype where hearingstatustypekey = 'PPD' and description = 'Postponed';
INSERT INTO cjams.hearingstatustype 
(hearingstatustypeid, hearingstatustypekey, description, activeflag, effectivedate, insertedby, insertedon)
VALUES(gen_random_uuid(), 'PPD', 'Postponed', 1, now(), 'Admin', now());