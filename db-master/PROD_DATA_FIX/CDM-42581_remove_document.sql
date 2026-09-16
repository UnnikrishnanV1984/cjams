-- CDM-42581 - Urgent--> Delete a document
/*
-- Issue Description: 
-- User request to delete Document from cases: (241022925469,241022908344)
--docIds: 672293f5b5b4fe209031e625, 672293e953ec5e3c56be5889
--filenames: SAO notification_Lewis.pdf, SAO notification_Godfrey.pdf

-- Category/ Module: Document upload
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
/*
select activeflag,* from documentproperties d where ecmsdocumentid in ('672293f5b5b4fe209031e625','672293e953ec5e3c56be5889');
*/
update
    documentproperties
set
    activeflag = 0,
    updatedby = 'CDM-42581',
    updatedon = now()
where
    ecmsdocumentid in ('672293f5b5b4fe209031e625','672293e953ec5e3c56be5889')
    and activeflag = 1;

/*
select activeflag,* from documentattachment  where documentpropertiesid in ('9b0a6526-019e-4a3d-9621-d4c17a86d70b', '2105b39b-ca7c-4258-9c05-f0d06fdd7f33');
*/
update
    documentattachment
set
    activeflag = 0,
    updatedby = 'CDM-42581',
    updatedon = now()
where
    documentpropertiesid in ('9b0a6526-019e-4a3d-9621-d4c17a86d70b','2105b39b-ca7c-4258-9c05-f0d06fdd7f33')
    and activeflag = 1;