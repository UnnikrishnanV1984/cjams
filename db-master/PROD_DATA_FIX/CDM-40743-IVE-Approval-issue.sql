/*
   Issue Description: CDM-40743 IV Review approval issue
   Category/ Module  :Decision
   Root cause: The IV-E Case Closure review is not required when the Child removal is done in different case
   Fix provided : Data fix and code fix has been done to not disable IV-E case closure review when the service case id is different.
   Pull request# for code fix: https://source.mdthink.maryland.gov/projects/DHSCJAMS/repos/cjams_welfare_web/pull-requests/7339/overview
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update ivecaseclosurereview
set activeflag = 0,
updatedby = 'CDM-40743',
updatedon = now()
where objectid='728b917e-46c9-4d5a-8b96-67381e889e41'
and activeflag = 1;

update routing
set activeflag = 0,
updatedby = 'CDM-40743',
updatedon = now()
where objectid='364f4755-aec7-4bdd-9767-158a0869d694'
and activeflag = 1;

