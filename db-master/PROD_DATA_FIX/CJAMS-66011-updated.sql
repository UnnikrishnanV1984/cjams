/*
Issue Description: Staff Shauneida Lowe is not showing up for assignment
Category/Module: Bug
Root cause: user is not having the the correct assigned role & team
Fix provided: Data fix is done to update in sail point 
               Datafix to deactivate 36 role from rolemapping table and insert 71 role in rolemapping table.
               Fix roletypekey as CWCW in teammember table
Data/Code fix ticket#: CJAMS-66011
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update rolemapping set activeflag = 0, updatedby = 'CJAMS-66011', updatedon = now() 
where id in('170034806') and activeflag = 1;

update teammember
set roletypekey = 'CWCW',updatedby = 'CJAMS-66011',updatedon =  now()
where teammemberid in ('eb745c63-bd48-48cc-bf61-70e873bba1b0') and activeflag=1;

update userresource
set activeflag =0,updatedby = 'CJAMS-66011', updatedon = now()
where userid ='14536' and activeflag =1;

insert into rolemapping 
(id,principaltype,principalid,roleid,activeflag,insertedby,insertedon,updatedby, updatedon,teamtypekey)
values
(nextval('rolemapping_id_seq'),'USER','14536',71,1,'CJAMS-66011',now(),'CJAMS-66011',now(),'CW');
