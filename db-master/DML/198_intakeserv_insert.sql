delete  from intakeagencyserv   where intakeservid='e0d5145b-f072-4f8e-980e-535cdb886303';

delete  from intakeserv   where intakeservid='e0d5145b-f072-4f8e-980e-535cdb886303';

INSERT INTO cjams.intakeserv
(intakeservid, description, insertedby, insertedon, updatedby, updatedon, activeflag, old_id, intakeservtypekey)
VALUES('e0d5145b-f072-4f8e-980e-535cdb886303', 'Kinship Information', NULL, now(), NULL, now(), 1, NULL, NULL);


INSERT INTO cjams.intakeagencyserv
(intakeagencyservid, intakeservid, insertedby, insertedon, updatedby, updatedon, activeflag, teamtypekey, intakeservreqtypeid, old_id, servicerequesttypeconfigid, plantypekey)
VALUES('a1418de4-7fa6-4e1a-bdf0-d453da1ec4b8', 'e0d5145b-f072-4f8e-980e-535cdb886303', NULL, now(), NULL, now(), 1, 'CW', '619c4dcf-ef22-4fc4-9269-d7678e8a8f6a', NULL, NULL, NULL);
