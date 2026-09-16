/*
   Issue Description: CDM-18428
   Category/ Module  : Data fix for updating program assignment dates
   Root cause: user requeseted to correct the dates
   Pull request# for code fix: NA
   Reason why no related code fix: No change in code
   Status of the code fix if already submitted and expected prod fix date: NA
*/
update cjams.personprogramarea set startdate = '2021-06-17 00:00:00', updatedby = 'CIDM-18428', updatedon = now() where personprogramid = 'de23be6c-04fe-4e53-8fde-6d0ec4c1592b';
update cjams.personprogramarea set activeflag = 0, updatedby = 'CIDM-18428', updatedon = now() where personprogramid = '64fc7991-fc31-485c-802d-0becc083f3ac';
update cjams.personprogramarea set startdate = '2021-05-17 00:00:00', enddate = '2021-06-17 00:00:00', updatedby = 'CIDM-18428', updatedon = now() where personprogramid = 'df752782-5ba6-4f92-a3fa-7e58153c3dff';

update cjams.personprogramarea set activeflag = 0, updatedby = 'CIDM-18428', updatedon = now() where personprogramid = '69660859-2e05-41f6-8ed1-5e9e7f564208';
update cjams.personprogramarea set enddate = null, updatedby = 'CIDM-18428', updatedon = now() where personprogramid = '0321fcd1-5d16-402f-a959-6cdd01c58b5b';