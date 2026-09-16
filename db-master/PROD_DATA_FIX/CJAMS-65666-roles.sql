/*
Issue Description: CJAMS-65666
Category/Module: Bug
Root cause: user is not having the the correct assigned role & team
Fix provided: Data fix is done to update roles in cjams
               deactivated 38 role from both rolemapping and userresource table
               inserted role 40 in rolemapping table
               deactivated role 40 in userresource table
               roletypekey as ASIW in teammember table for AS team assignment record
Data/Code fix ticket#: CJAMS-66011
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update rolemapping set activeflag = 0, updatedby = 'CJAMS-65666', updatedon = now() 
where id in('64308279') and activeflag = 1;

update userresource
set activeflag =0,updatedby = 'CJAMS-65666', updatedon = now()
where userid ='13348' and activeflag =1;

update teammember
set roletypekey = 'ASIW',updatedby = 'CJAMS-65666',updatedon =  now()
where teammemberid in ('d1cfcc15-f1e0-47a2-8890-17ff298e98b4') and activeflag=1;

insert into rolemapping 
(id,principaltype,principalid,roleid,activeflag,insertedby,insertedon,updatedby, updatedon,teamtypekey)
values
(nextval('rolemapping_id_seq'),'USER','13348',40,1,'CJAMS-65666',now(),'CJAMS-65666',now(),'AS');