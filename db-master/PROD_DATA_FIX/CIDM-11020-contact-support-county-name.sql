/*
Issue: CIDM-11020 Data fix to updated the contact support county name 
Category/Module: Contact Support
Root cause: This issue has occured after angular upgrade and has been fixed as the part of CIDM-11015 where county name is saved as null.
            We need a data fix to update the county name for all the records that are having null in the contact support request.
Fix provided:  Data fix has been done to update the county name for all the records that are having null values after the Angular upgrade prod deployment.
Data/Code fix ticket#: CIDM-11020
Regression Impacts: N/A
Is Code fix Required?: yes
Code fix ticket#: CIDM-11015 
Reason why no related code fix: N/A
*/

--select * from defecttracking.supportlog where insertedon ::date >= '01-20-2026' and ldssregion is null

update defecttracking.supportlog ds
set ldssregion = u.countyname,
    updatedon = now(),
    updatedby = 'CIDM-11020'
from v_userprofile u
where u.email = ds.frommailid
and ds.insertedon ::date >= '01-20-2026' 
and ds.ldssregion is null 