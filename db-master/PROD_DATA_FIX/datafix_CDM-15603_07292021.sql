-- CDM-15603 - Two different exit reasons
/*
-- Issue Description: 
    Duplicate ref_key for referencetypeid - 343 - Child Removal End Reason
    OTR	Other
	OTR	Other Relative
   
-- Category/ Module: Master Data (Referencevalues)
-- Root cause: Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select ref_key, value_text, mdmcode, updatedby, updatedon
	from referencevalues 
where ref_key = 'OTR' 
	and referencetypeid = 343 ;

select ref_key, value_text, mdmcode, updatedby, updatedon 
	from referencevalues 
where ref_key = 'OTR' 
	and lower(value_text) = 'other relative'
	and referencetypeid = 343 ;

update referencevalues 
set ref_key = 'OTRL',
	mdmcode = 'OTRL',
	updatedby = 'CDM-15603',
	updatedon = now()
where ref_key = 'OTR' 
	and lower(value_text) = 'other relative'
	and referencetypeid = 343 ;