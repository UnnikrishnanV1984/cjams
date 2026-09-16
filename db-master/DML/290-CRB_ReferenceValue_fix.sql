-- D-22187
-- Fix Child Factor Code output for CRB
-- 12/05/2019
--
UPDATE crbreferencevalues  SET chessiecode = '4333' WHERE referenceid = 75 and cjamscode = 'AAP' and referencetype = 'removalreasontype';
UPDATE crbreferencevalues  SET chessiecode = '4334' WHERE referenceid = 78 and cjamscode = 'DAP' and referencetype = 'removalreasontype';

