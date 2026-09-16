 /*
    Issue Description: CDM-35508- Supervisor not in Drop down list C Nzeadighibe
    Root Cause :
    Data fix :Updated role type
    Category/ Module: Role Management
    Pull request# N/A
    Reason why no related code fix: N/A
    Status of the code fix if already submitted and expected prod fix date: N/A
    updating comments
*/

update cjams.teammember 
set roletypekey = 'CWSP',updatedon=now(),updatedby='CDM-35508' 
where teammemberid = 'c00bd1f4-96c4-4abf-b5ee-abae063bdf76';