-- CIDM-7015 -- ECMS Document
/*
-- Issue Description: 
   To fix Document category name 
	ECMS
	CW-CPS CW-CPS Clearance-Provider ..... (ECMS is having hyphen)
	CW-CPS CW-CPS Clearance-School

	CJAMS
	CW-CPS CW-CPS Clearance Provider ..... (CJAMS is NOT having hyphen)
	CW-CPS CW-CPS Clearance -School ..... (CJAMS is having extra space before hyphen)
 	
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Master Data Discrepancies between ECMS & CJAMS
-- Fix Provided: Datafix has been promoted to fix the Document category names
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 8	CW-CPS CW-CPS Clearance Provider ..... (CJAMS is NOT having hyphen)
select sequencenumber, attachmentclassificationtypekey, subcategory, repositoryid, activeflag, updatedby, updatedon 
	from attachmentclassificationtype 
where sequencenumber = 8
	and activeflag = 1 ;
	
update attachmentclassificationtype
set subcategory = 'CW-CPS Clearance-Provider',
	updatedby = 'CIDM-7015',
	updatedon = now()
where sequencenumber = 8
	and activeflag = 1 ;

-- 9	CW-CPS CW-CPS Clearance -School ..... (CJAMS is having extra space before hyphen) 
select sequencenumber, attachmentclassificationtypekey, subcategory, repositoryid, activeflag, updatedby, updatedon 
	from attachmentclassificationtype 
where sequencenumber = 9
	and activeflag = 1 ;
	
update attachmentclassificationtype
set subcategory = 'CW-CPS Clearance-School',
	updatedby = 'CIDM-7015',
	updatedon = now()
where sequencenumber = 9
	and activeflag = 1 ;
