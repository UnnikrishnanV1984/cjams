--//*************************************************************************************************
--// Ticket: CIDM-10748
--// Date: 09/17/2025
--// Author: Anil Dharni
--// Description: Merged script to define the 'Search Type' reference values for Person Search.
--//              This script uses a "delete and replace" strategy to ensure a clean and
--//              consistent final state for all search types.
--//*************************************************************************************************


-- Delete scripts
-- First, delete all child records (the specific search options) from the referencevalues table.
DELETE FROM cjams.referencevalues
WHERE referencetypeid = 500200;

-- Second, delete the parent record ('Search Type' itself) from the referencetype table.
DELETE FROM cjams.referencetype
WHERE referencetypeid = 500200;

-- 1. Ensure the parent reference type 'Search Type' exists.
INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(500200, 'Search Type', 'Search Type', 1, 'CIDM-10748', now(), 'CIDM-10748', now(), NULL)
ON CONFLICT (referencetypeid) DO NOTHING;


-- 2. Delete all existing search type values for this reference type.
DELETE FROM cjams.referencevalues
WHERE referencetypeid = 500200
  AND ref_key IN ('EXM', 'EXP', 'FZM', 'SXM', 'SYN', 'ALL');


-- 3. Insert the complete and final set of search type records.
-- All values are inserted with their correct descriptions and final display order,
-- eliminating the need for subsequent UPDATE statements.
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES
('EXM', 500200, 'Exact Match',   'Exact',      'CW', 1, 1, 'CIDM-10748', now(), 'CIDM-10748', now(), NULL, NULL, NULL),
('EXP', 500200, 'Exact+',        'Exact Plus', 'CW', 1, 2, 'CIDM-10748', now(), 'CIDM-10748', now(), NULL, NULL, NULL),
('SXM', 500200, 'Soundex match', 'Soundex',    'CW', 1, 3, 'CIDM-10748', now(), 'CIDM-10748', now(), NULL, NULL, NULL),
('SYN', 500200, 'Synonym',       'Synonym',    'CW', 1, 4, 'CIDM-10748', now(), 'CIDM-10748', now(), NULL, NULL, NULL),
('FZM', 500200, 'Fuzzy Match',   'Fuzzy',      'CW', 1, 5, 'CIDM-10748', now(), 'CIDM-10748', now(), NULL, NULL, NULL),
('ALL', 500200, 'All',           'All',        'CW', 1, 6, 'CIDM-10748', now(), 'CIDM-10748', now(), NULL, NULL, NULL);