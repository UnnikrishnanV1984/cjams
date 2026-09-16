/*
Issue Description: CIDM-10774 Case number not populating on Psychotropic medication for review screen
Category/Module: Psychotropic review Screen
Root cause: Case number not populating in the Psychotropic medication review screen due to the recent code changes done as the part of CIDM-10687 were duplicate case number issue was fixed.
Fix provided: Data fix has been done for this record to display the case details which were inserted as null in the database
Data/Code fix ticket#: CIDM-10774
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CIDM-10773
Reason why no related code fix: Code fix has been done as the part of CIDM-10773 to fix this issue.
*/

update psychotropicmedications
set objectid = 'fdfe615b-d037-49a3-a9d5-b7698a1b6208',
    objecttypekey = 'servicecase',
    updatedby = 'CIDM-10774',
    updatedon = now()
where psychotropicid = '5e51052b-9bf5-4b84-b587-cf84976d919b'
and activeflag =1;