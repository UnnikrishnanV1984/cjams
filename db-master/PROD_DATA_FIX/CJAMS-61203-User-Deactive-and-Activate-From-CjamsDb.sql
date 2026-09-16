/*
Issue Description: please do a datafix to deactivate CJAMS_CWCASEWORKER role from rolemapping and deactivate CJAMS_CWINTAKEWORKER from userresource table insert CJAMS_CWINTAKEWORKER role into rolemapping table making it a primary role for the user also update roletypekey in teammember table as CWIW
Category/Module: User/ Roles
Root cause: This is a know sailpoint issue and data fix is needed to resolve the roles
Fix provided: Data fix has been done to update the roles in teammember table.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix:It was a known sailpoint integration issue and data fix is needed to resolve it.
*/

-- Email: kayla.newton1@maryland.gov
--securityuserid: 7a55e5b6-4aa7-45a7-bad9-1d3bd0dc0fb1
-- id : 128927530

update rolemapping set activeflag = 0, updatedby = 'CJAMS-61203', updatedon = now() 
where id in('172111679') and activeflag = 1;


update userresource set activeflag = 0, updatedby = 'CJAMS-61203', updatedon = now() 
where userresourceid  in ('e3b459c7-c546-4c1c-b361-80318728bedd') and activeflag = 1;


update teammember
set roletypekey = 'CWIW',updatedby = 'CJAMS-61203',updatedon =  now()
where teammemberid in ('90e28c8c-3263-465f-a268-10675bbfbbb7') and activeflag=1;

--UPDATE rolemapping
--SET roleid = 41,
--    updatedby = 'CJAMS-61203',
--    updatedon = now()
--WHERE roleid = 40
--  AND principalid = 13424
--  AND activeflag = 1;

insert into rolemapping 
(id,principaltype,principalid,roleid,activeflag,insertedby,insertedon,updatedby, updatedon,teamtypekey)
values
(nextval('rolemapping_id_seq'),'USER','13424',41,1,'CJAMS-61203',now(),'CJAMS-61203',now(),'CW');