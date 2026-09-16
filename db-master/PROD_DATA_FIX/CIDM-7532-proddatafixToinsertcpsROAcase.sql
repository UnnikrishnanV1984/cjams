/*
   Issue Description: CIDM-7532
   Category/ Module  : Prod data fix to insert CIDM
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

INSERT INTO cjams.servicerequesttypeconfigdispositioncode
(servicerequesttypeconfigiddispostionid, servicerequesttypeconfigid, dispositioncode, description, intakeserreqstatustypeid, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", isallowappeal, appealdurationdays, recommendationtype, old_id, roletypekey)
VALUES('e69bc4c7-1b1a-4cc9-9870-74dacfea89e7', 'b544bce2-2eb7-4d55-b8cc-8c9cf097b40a', 'Progress ROA', 'Progress ROA', '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', 1, '2020-10-16 17:44:50.878', NULL, 'admin', '2020-10-16 17:44:50.878', 'CIDM-7532', '2020-10-16 17:44:50.878', NULL, false, 0, 'Final', NULL, NULL) on conflict do nothing;
