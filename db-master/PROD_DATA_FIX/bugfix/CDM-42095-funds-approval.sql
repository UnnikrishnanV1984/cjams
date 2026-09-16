/*
   Issue Description: CDM-42095 can't approve funding approvals
   Category/ Module  :  Finance/Funding approval
   Root cause: Finance worker can't approve the funds as IV-E role is added .
   Fix Provided: Data fix to remove the IV-E specialist role as requested by user and mimic the role of sara.blanco@montgomerycountymd.gov
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
*/

update rolemapping 
set roleid = 1052,
    updatedby = 'CDM-42095',
    updatedon = now()
where principalid = '44631'
and activeflag = 1 ;  

UPDATE cjams.teammemberassignment
SET teammemberid='e5a69ee0-ff21-48c9-9cb8-d49ff11167ae'::uuid, updatedby='CDM-42095', updatedon=now()
WHERE teammemberassignmentid='37d3aa42-1607-4f91-b4dd-edf807cd2d5f' and securityusersid='bdbf9ad2-37c0-440e-8bae-a4ce292e13d8';
