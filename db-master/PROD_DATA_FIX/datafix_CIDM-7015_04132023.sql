-- CIDM-7015 -- ECMS Document
/*
-- Issue Description: 
   To fix Document category name 

 	
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Master Data Issue
-- Fix Provided: Datafix has been promoted to fix the Document category name (remove extra CW)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 18	CW-CW-Finance	CW-Finance-Receipt
select sequencenumber, attachmentclassificationtypekey, subcategory, repositoryid, activeflag, updatedby, updatedon 
	from attachmentclassificationtype 
where sequencenumber = 18
	and activeflag = 1 ;
	
update attachmentclassificationtype
set attachmentclassificationtypekey = 'CW-Finance',
	updatedby = 'CIDM-7015',
	updatedon = now()
where sequencenumber = 18
	and activeflag = 1 ;


-- To remove the spaces from attachmentclassificationtypekey and subcategory columns
select att.attachmentclassificationtypekey, att.attachmentclassificationsubtypekey, att.updatedby , att.updatedon 
	from documentattachment att
where att.activeflag = 1
	and ( att.attachmentclassificationtypekey, att.attachmentclassificationsubtypekey )
	in (
		select attachmentclassificationtypekey, subcategory 
			from attachmentclassificationtype 
		where activeflag = 1 
			and ( 
				attachmentclassificationtypekey <> btrim(attachmentclassificationtypekey)
				or
				subcategory <> btrim(subcategory)
				)
		) ;

update documentattachment att
set attachmentclassificationtypekey = btrim(attachmentclassificationtypekey),
	attachmentclassificationsubtypekey = btrim(attachmentclassificationsubtypekey)
where att.activeflag = 1
	and ( att.attachmentclassificationtypekey, att.attachmentclassificationsubtypekey )
	in (
		select attachmentclassificationtypekey, subcategory 
			from attachmentclassificationtype 
		where activeflag = 1 
			and ( 
				attachmentclassificationtypekey <> btrim(attachmentclassificationtypekey)
				or
				subcategory <> btrim(subcategory)
				)
		) ;
	

select sequencenumber, attachmentclassificationtypekey, subcategory, repositoryid, activeflag, updatedby, updatedon 
	from attachmentclassificationtype 
where activeflag = 1 
	and ( 
			attachmentclassificationtypekey <> btrim(attachmentclassificationtypekey)
			or
			subcategory <> btrim(subcategory)
		); 
		
update attachmentclassificationtype
	set attachmentclassificationtypekey = btrim(attachmentclassificationtypekey),
	subcategory = btrim(subcategory)
where activeflag = 1 
	and ( 
			attachmentclassificationtypekey <> btrim(attachmentclassificationtypekey)
			or
			subcategory <> btrim(subcategory)
		); 
				