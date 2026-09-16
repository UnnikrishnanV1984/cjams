-- CJAMS-59141 - Deleted document
/*
-- Issue Description: 
	User request to retirve the deleted Document from Case# 3181268
    DOCUMENT NAME: Rebecca Rivers - FMDT.pdf
    DOCUMENT TITLE: Other Disability Services (Rebecca Rivers - FMDT)
    DOCUMENT DATE: 04/09/2025
    CATEGORY: Disability Services
    SUB CATEGORY: Other Disability Services
    UPLOADED BY: Darryl Rudd
    UPLOADED DATE: 04/09/2025

-- Category/ Module: Documents
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
select activeflag,s3bucketpathname,ecmsdocumentid,* from documentproperties 
where  servicecaseid = '532abae4-7dc3-47bc-96cf-7cd26db92cea' 
and  originalfilename = 'Rebecca Rivers - FMDT.pdf'
*/

update documentproperties
set activeflag = 1,
	updatedby = 'CJAMS-59141',
	updatedon =  now()
where documentpropertiesid = '2b23f42d-0b07-4987-9229-e7bf911f7c79' 
and activeflag = 0;	