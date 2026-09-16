/*
-- Issue Description: CIDM-7914
   User request to Remove duplicated Investigation findings
-- Category/ Module: Inverstigation Finding   
-- Root cause: 
-- Pull request :7485
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE Investigationmaltreatment SET activeflag = 0, updatedon=now(), updatedby = 'CIDM-7914' WHERE 
maltreatmentid IN ('6af32b79-1992-43ba-a2ea-c51048a26ebe');

UPDATE investigationallegation SET activeflag = 0, updatedon=now(), updatedby = 'CIDM-7914' WHERE 
maltreatmentid IN ('6af32b79-1992-43ba-a2ea-c51048a26ebe');

UPDATE investigationallegationmaltreators SET activeflag = 0, updatedon=now(), updatedby = 'CIDM-7914' WHERE investigationallegationid IN (
SELECT investigationallegationid  FROM investigationallegation WHERE maltreatmentid 
IN ('6af32b79-1992-43ba-a2ea-c51048a26ebe') );
