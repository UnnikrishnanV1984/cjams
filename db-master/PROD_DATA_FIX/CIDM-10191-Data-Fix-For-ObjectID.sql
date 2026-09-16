/*
Issue Description: Need data fix to map livingid with the objectid missing in person hospitalisation table.
Category/Module: Support
Root cause: Some objectid in the person hospitalisation were because of existing code error.
Fix provided: DB query to update the livingid in the records
Data/Code fix ticket#: CIDM-10191
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#:   NA
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update
    personhospitalization ph
set
    objectid = la.livingid,
    activeflag = 1,
    updatedon = now(),
    updatedby = 'CIDM-10191'
FROM
    livingarrangement la
    INNER JOIN placementrevision pr ON pr.placementid = la.placementid
    AND pr.approvalstatustypkey = '3047'
    AND pr.activeflag = 1
    AND pr.objectid IS NULL
WHERE
    ph.personid = la.personid
    AND la.activeflag = 1
    AND la.livingarrangementtypekey IN ('ERM', 'ERP', 'IMC', 'PSYH')
    AND ph.activeflag = 2
    AND ph.objectid IS NULL
    AND la.livingstartdate :: date IN (
        ph.hospital_examstartdate :: date,
        ph.hospital_evaluatstartdate :: date,
        ph.hospital_inpatientadmissiondate :: date
    );

-- personid e5b5e594-4e1c-4616-92b4-9e598ba6418b
update
    personhospitalization
set
    objectid = 'f4e5a2c9-9e67-4041-a344-8a9d087f304b',
    activeflag = 1,
    updatedon = now(),
    updatedby = 'CIDM-10191'
where
    hospitalizationid = '92c74790-2ec9-4567-b709-1dae73f1bbca'
    and activeflag = 2
    and objectid is null;

-- personid bea25152-cfd2-457b-9d72-b05d1e401c09
update
    personhospitalization
set
    objectid = 'ae3dff10-1daa-409f-8208-035785e31b88',
    activeflag = 1,
    updatedon = now(),
    updatedby = 'CIDM-10191'
where
    hospitalizationid = 'c2f5b0cd-c069-47b9-ae7d-1876363a2698';

-- personid 8a9bef93-95a8-4c6c-a490-87e86fef2474
update
    personhospitalization
set
    objectid = '4c86c8e5-1000-478e-8161-2d83de0e6f30',
    activeflag = 1,
    updatedon = now(),
    updatedby = 'CIDM-10191'
where
    hospitalizationid = 'c3f52169-85cf-4390-9eae-52a8c0a14fbf'
    and activeflag = 2
    and objectid is null;

-- personid c956ef72-1e6c-4362-86f7-3ea3b8ccf887  
update
    personhospitalization
set
    objectid = '072ae276-29aa-4e8a-95db-f3b31d2be5ec',
    activeflag = 1,
    updatedon = now(),
    updatedby = 'CIDM-10191'
where
    hospitalizationid = 'bf27c1d9-fac0-456d-8010-f91f46db5dcd'
    and activeflag = 2
    and objectid is null;

-- No associatied living arrangements are found with these dates
update
    personhospitalization
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CIDM-10191'
where
    hospitalizationid in (
        '92a51e43-a4e5-4a07-ad66-75cd3c76f7c8',
        '7d905f54-1004-46e8-a3d1-d29c6300c703',
        '4d54329a-3027-47ab-8a7b-c3eb4437f909'
    )
    and activeflag = 2
    and objectid is null;


-- updated discharge date when living date is enddated
update
    personhospitalization ph
set
    hospital_dischargeddate = la.livingenddate,
    hospital_discharged = true,
    updatedon = now(),
    updatedby = 'CIDM-10191'
from
    livingarrangement la
    INNER JOIN placementrevision pr ON pr.placementid = la.placementid
    AND pr.approvalstatustypkey = '3047'
    AND pr.activeflag = 1
    AND pr.objectid IS NULL
where
    la.livingid :: character varying = ph.objectid
    AND la.activeflag = 1
    AND la.livingarrangementtypekey IN ('ERM', 'ERP', 'IMC', 'PSYH')
    AND ph.activeflag = 1
    AND ph.objectid IS not NULL
    AND la.livingstartdate :: date IN (
        ph.hospital_examstartdate :: date,
        ph.hospital_evaluatstartdate :: date,
        ph.hospital_inpatientadmissiondate :: date
    )
    and la.livingenddate is not null
    and ph.hospital_dischargeddate is null;