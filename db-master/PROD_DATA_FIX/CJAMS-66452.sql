/*
Issue Description: kaeleigh.walker is not showing up for assignment
Category/Module: Bug
Root cause: user is not having the the correct assigned role & team
Fix provided: Data fix is done to update in sail point 
               Datafix to deactivate 36 role from rolemapping table and insert 71 role in rolemapping table.
               Fix roletypekey as CWCW in teammember table
Data/Code fix ticket#: CJAMS-66452
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update rolemapping set activeflag = 0, updatedby = 'CJAMS-66452', updatedon = now() 
where id in('187871865') and activeflag = 1;

update teammember
set roletypekey = 'CWCW',updatedby = 'CJAMS-66452',updatedon =  now()
where teammemberid in ('4b833922-24ee-42cc-8f94-0fbab1e6f3b1') and activeflag=1;

update userresource
set activeflag =0,updatedby = 'CJAMS-66452', updatedon = now()
where userresourceid ='465f52ab-39bb-40de-bb1a-a0536fd1b6ff' and activeflag =1;

insert into rolemapping 
(id,principaltype,principalid,roleid,activeflag,insertedby,insertedon,updatedby, updatedon,teamtypekey)
values
(nextval('rolemapping_id_seq'),'USER','83946',71,1,'CJAMS-66452',now(),'CJAMS-66452',now(),'CW');