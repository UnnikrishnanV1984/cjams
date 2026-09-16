/*
Issue Description: CJAMS-67537
Category/Module: Bug
Root cause: user is not having the the correct assigned role & team
Fix provided: Data fix is done to update roles in cjams
             deactivate roleid 71 in both rolemapping and userresource table 
            Deactivate roleid 1052 in userresource table
            Please insert roleid 1052 in rolemapping table 
            Please update roletypekey as FNSFW
Data/Code fix ticket#: CJAMS-67537
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/




update rolemapping set activeflag = 0, updatedby = 'CJAMS-67537', updatedon = now() 
where id in('86037900') and activeflag = 1;

update userresource
set activeflag =0,updatedby = 'CJAMS-67537', updatedon = now()
where userresourceid ='1aa11ba0-625b-4043-99ae-0255b4b9430f' and activeflag =1;

update userresource
set activeflag =0,updatedby = 'CJAMS-67537', updatedon = now()
where userresourceid ='db0f5209-2e96-4ce2-863e-d2eb1dbfe04c' and activeflag =1;

insert into rolemapping 
(id,principaltype,principalid,roleid,activeflag,insertedby,insertedon,updatedby, updatedon,teamtypekey)
values
(nextval('rolemapping_id_seq'),'USER','14522',1052,1,'CJAMS-67537',now(),'CJAMS-67537',now(),'CW');

update teammember
set roletypekey = 'FNSFW',updatedby = 'CJAMS-67537',updatedon =  now()
where teammemberid in ('026565ac-f9b5-4c92-b9c9-838560179a3d') and activeflag=1;