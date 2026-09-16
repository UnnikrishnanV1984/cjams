
/*
Issue Description: Prevention Services Edibility Data Fix Needed
Category/Module: POSC
Root cause: User requested for below fixes, Check the box for "Family First prevention services are the appropriate course of action for this child/family and they are within the target population for a specific evidence-based Service."
Change the date from 05/18/2026 to 02/16/2026.
Fix provided: Data fix done to Check the box for "Family First prevention services are the appropriate course of action for this child/family and they are within the target population for a specific evidence-based Service."
Change the date from 05/18/2026 to 02/16/2026.
Data/Code fix ticket#: CJAMS-67816
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/
UPDATE serviceplan
SET involvedpersons = regexp_replace(
    involvedpersons::text,
    '"familyFirstPrevention":\s*false',
    '"familyFirstPrevention": true',
    'g'
)::jsonb,
    updatedby = 'CJAMS-67816',
    updatedon = now()
WHERE serviceplanid = '21c81b49-9004-4edf-b087-a6ed5d610930'
  AND activeflag = 1;
 
 update snapshothist
set snapshotdata = replace(
    replace(
        replace(snapshotdata::text,
            '"candidacydate", "2026-05-15T13:35:42.631Z"', '"candidacydate", "2026-02-16T13:00:00.000Z"'),
        '"candidacydate": "2026-05-15T13:35:42.631Z"', '"candidacydate": "2026-02-16T13:00:00.000Z"'),
    '"candidacydate":"2026-05-15T13:35:42.631Z"', '"candidacydate":"2026-02-16T13:00:00.000Z"'
)::jsonb,
updatedby = 'CJAMS-67816',
updatedon = now()
where id = 'f3b26861-cf6f-413e-a3e1-bc584b36e598'
  and activeflag = 1;                        