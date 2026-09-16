/*
Issue Description: CJAMS-68385 access
Category/ Module  :Assignments
Root cause: As part of the previous ticket CJAMS-63841, roles were updated to align with the SailPoint profile; however, the corresponding update to the roletypekey in the teammember table was missed.
Fix provided: A data fix has been implemented to update the user’s role to CWCW
Pull request# for code fix: N/A
Reason why no related code fix: No
Status of the code fix if already submitted and expected prod fix date: N/A
Backup before update/ delete: N/A
 */
update teammember
set
    roletypekey = 'CWCW',
    updatedby = 'CJAMS-68385',
    updatedon = now ()
where
    teammemberid = 'ecb00935-012d-4e23-9fce-5da418873f4c'
    and teamid = 'd667af13-8151-462b-aa2e-adab34dcb076'
    and activeflag = 1;

update teammember
set
    roletypekey = 'CWCW',
    updatedby = 'CJAMS-68385',
    updatedon = now ()
where
    teammemberid = '398540e4-1603-4c7f-b9b0-21b4d3cacc8b'
    and teamid = 'd667af13-8151-462b-aa2e-adab34dcb076'
    and activeflag = 1;