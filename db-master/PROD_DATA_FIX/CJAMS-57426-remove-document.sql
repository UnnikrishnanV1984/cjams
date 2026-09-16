/*
-- Issue Description: 
-- User request to delete Document from cases: 241022960461
--docIds: '67a2780c4d74c26a8cf90cf5','67a273425ea3b01cafa64db5'

-- Category/ Module: Document upload
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
update
    documentproperties
set
    activeflag = 0,
    updatedby = 'CJAMS-57426',
    updatedon = now()
where
    ecmsdocumentid in ('67a2780c4d74c26a8cf90cf5','67a273425ea3b01cafa64db5')
    and activeflag = 1;

update
    documentattachment
set
    activeflag = 0,
    updatedby = 'CJAMS-57426',
    updatedon = now()
where
    documentpropertiesid in ('7f9e7530-518e-4b85-9781-3a4f8ec46d02', '76708569-59da-4105-a841-04fc7e674833')
    and activeflag = 1;