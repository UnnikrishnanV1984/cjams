/*
Issue Description: Please remove  duplicates in child removal
Root cause: user could not abe to delete duplicates  ,they can only create.
Fix provided: DB queries  update enddate intakeservreqchildremoval,personprogramarea tables
Data/Code fix ticket#: CJAMS-61170
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update intakeservreqchildremoval
set activeflag =0 ,updatedby='CJAMS-61170',updatedon=now()
where intakeservreqchildremovalid ='66dd95ed-ba33-4434-baa5-82723d1dfb1f' and activeflag=1;

update intakeservreqchildremoval_history
set activeflag =0 ,updatedby='CJAMS-61170',updatedon=now()
where intakeservreqchildremovalhistoryid in ('6def178c-e581-4c58-8271-fb5b1105f9a2',
'd7a5688e-92ad-4f3f-8c9a-04a737eec78c',
'f49b5b43-f49a-4eb1-9fa4-3d55da7eac1e',
'fce08221-2e29-4586-9164-5552e1bf8c6d',
'ba9325ab-43c0-4d00-b948-ab4df72805e1',
'fd5adbab-aa44-45da-b058-91b33a2763a4',
'c24f01c8-39e0-4164-84b4-15e7b1f743dc') and activeflag=1;

update tb_client_eligibility
set delete_sw = 'Y', create_user_id = 'CJAMS-61170' , update_ts = now()
where eligibility_id = '10150709' and delete_sw='N';

update routing
set activeflag =0 ,updatedby='CJAMS-61170',updatedon=now()
where routingid in ('b62c30a3-8651-4b98-9485-98f2019b7c72','2131d67f-03f7-4b3b-a474-0c0feab57102') and activeflag=1;


update personprogramarea
set activeflag =0 ,updatedby='CJAMS-61170',updatedon=now()
where personprogramid = '496aff59-cee0-43ff-a443-9dbd47b7f8a2' and activeflag=1;



update intakeservreqchildremoval
set parent2comments ='The biological father in the case is in uninvolved and his current contact information is unknown. Therefore there is no parental signature on the second page of the Voluntary Placement Agreement. PLEASE SEE THE CORRECTED COPY OF THE YOUTHS REMOVAL EPISODE' ,updatedby='CJAMS-61170',updatedon=now()
where intakeservreqchildremovalid ='2e7d9aa0-9967-4400-9409-1754ab9f139d' and activeflag=1;

update intakeservreqchildremoval_history
set parent2comments ='The biological father in the case is in uninvolved and his current contact information is unknown. Therefore there is no parental signature on the second page of the Voluntary Placement Agreement. PLEASE SEE THE CORRECTED COPY OF THE YOUTHS REMOVAL EPISODE' ,updatedby='CJAMS-61170',updatedon=now()
where intakeservreqchildremovalhistoryid in ('7563e4f7-5aee-453e-8cfc-19b8e3c12bbc','955ad0d6-d139-490c-8806-f7fce17bebcf',
'64f12176-4505-4540-8d2e-39ad70f4d617',
'e197b0f3-3087-4eb3-ad3b-747b98158577',
'16a5c28a-8509-40aa-843c-e8a534beee80',
'5fe48e23-b61f-4d94-a353-003df87541e6') and activeflag=1;