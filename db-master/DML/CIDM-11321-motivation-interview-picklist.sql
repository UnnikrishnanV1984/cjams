---------------------------------------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 04/13/2025 Vinesh Puthan - CIDM-11321 - Added picklist for motivational interview subtypes
--------------------------------------------------------------------------------------------------------------------------------------------


DELETE FROM referencevalues WHERE referencetypeid = 5471;
DELETE FROM referencetype WHERE referencetypeid = 5471;

INSERT INTO referencetype (referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES (5471, 'Motivation Interview', 'motivationalinterview', 1, 'CIDM-11321', now(), 'CIDM-11321', now(), NULL);

INSERT INTO referencevalues (
  ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder,
  insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
) VALUES
('AFF', 5471, 'Affirmations', 'Affirmations', NULL, 1, 1,  'CIDM-11321', now(), 'CIDM-11321', now(), NULL, NULL, NULL),
('AP', 5471, 'Asking Permission', 'Asking Permission', NULL, 1, 2,  'CIDM-11321', now(), 'CIDM-11321', now(), NULL, NULL, NULL),
('CA', 5471, 'Change Assessment', 'Change Assessment', NULL, 1, 3,  'CIDM-11321', now(), 'CIDM-11321', now(), NULL, NULL, NULL),
('ECT', 5471, 'Elicit Change Talk', 'Elicit Change Talk', NULL, 1, 4,  'CIDM-11321', now(), 'CIDM-11321', now(), NULL, NULL, NULL),
('ECC', 5471, 'Explore Change Confidence', 'Explore Change Confidence', NULL, 1, 5,  'CIDM-11321', now(), 'CIDM-11321', now(), NULL, NULL, NULL),
('ECR', 5471, 'Explore Change Readiness', 'Explore Change Readiness', NULL, 1, 6,  'CIDM-11321', now(), 'CIDM-11321', now(), NULL, NULL, NULL),
('FB', 5471, 'Feedback', 'Feedback', NULL, 1, 7,  'CIDM-11321', now(), 'CIDM-11321', now(), NULL, NULL, NULL),
('MCT', 5471, 'Mobilizing Change Talk', 'Mobilizing Change Talk', NULL, 1, 8,  'CIDM-11321', now(), 'CIDM-11321', now(), NULL, NULL, NULL),
('NM', 5471, 'Normalizing', 'Normalizing', NULL, 1, 9,  'CIDM-11321', now(), 'CIDM-11321', now(), NULL, NULL, NULL),
('OEQ', 5471, 'Open-ended Questions', 'Open-ended Questions', NULL, 1, 10,  'CIDM-11321', now(), 'CIDM-11321', now(), NULL, NULL, NULL),
('OU', 5471, 'Overstating/Understating', 'Overstating/Understating', NULL, 1, 11, 'CIDM-11321', now(), 'CIDM-11321', now(), NULL, NULL, NULL),
('RL', 5471, 'Reflective Listening', 'Reflective Listening', NULL, 1, 12, 'CIDM-11321', now(), 'CIDM-11321', now(), NULL, NULL, NULL),
('RF', 5471, 'Reframing', 'Reframing', NULL, 1, 13, 'CIDM-11321', now(), 'CIDM-11321', now(), NULL, NULL, NULL),
('SM', 5471, 'Summarizing', 'Summarizing', NULL, 1, 14, 'CIDM-11321', now(), 'CIDM-11321', now(), NULL, NULL, NULL),
('SSC', 5471, 'Supporting Self-Confidence', 'Supporting Self-Confidence', NULL, 1, 15, 'CIDM-11321', now(), 'CIDM-11321', now(), NULL, NULL, NULL);