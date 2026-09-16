/*
Issue Description: Data fix to change the answer to the question to "Yes" on the person card for PID 204097397.
Category/Module: Bug
Root cause: Data fix to change the answer to the question to "Yes" on the person card for PID 204097397.
Fix provided: Fix has been promoted to change the answer to the question to "Yes" on the person card for PID 204097397.
Data/Code fix ticket#: CJAMS-58420
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/

update personrole set initialresponse=1,
updatedby='CJAMS-58420',updatedon=now() 
where personroleid= '6b666c42-be06-4f03-a149-037ee97d1f12' and activeflag=1;

select * 
from cjams.cpsresponsetimerupdate( '1587f26e-d245-460a-90c3-fdcbe7edd4b9'::uuid, 'CJAMS-58420'::character varying );
