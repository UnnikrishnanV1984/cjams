/*
Issue Description: 2020034604719:The wrong void end date was entered which is causing an issue with re-entering the child in a placement.
Category/Module: user error
Root cause: user can not change placement end date in placement, livingarrangement,routing, placementrevision tables.
Fix provided: DB queries to update enddate
Data/Code fix ticket#: CJAMS-57847
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: user Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--update placement
update placement
set enddatetime = '2024-12-05 14:24:09', updatedby = 'CJAMS-57847', updatedon = now()
where placementid = '7682b6be-1435-46d8-a542-43aa8a9fea20' and activeflag = 1;
--update livingarrangement
update livingarrangement
set livingenddate = '2024-12-05 14:24:09', updatedby = 'CJAMS-57847', updatedon = now()
where livingid = 'f6d4d4bb-4a86-4a15-beda-6d6ca69d13a6' and activeflag = 1;

-- update placementrevision
update placementrevision
set  exitdate = '2024-12-05', exittime = '14:24:09', updatedby = 'CJAMS-57847',updatedon = now()
where placementrevisionid = '69a09b28-5551-4008-be4e-6f29c14a1d04' and activeflag = 1;
