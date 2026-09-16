/*
Issue Description: Support with adding a contact Note tab in CJAMS
Category/Module: Bug
Root cause: In sailpoint we have to update the roletypekey and also deactivate few roles for the user
Fix provided:Data fix is done to update the roles in sailpoint
Data/Code fix ticket#: CJAMS-66274
Regression Impacts: N/A
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/




update rolemapping set activeflag = 0, updatedby = 'CJAMS-66274', updatedon = now() 
where id in('185998962','186004963') and activeflag = 1;

update userresource
set activeflag =0,updatedby = 'CJAMS-66274', updatedon = now()
where userresourceid in ('ef6d1666-966c-4f89-9f34-65d51218776d','89a735da-71d2-415a-9500-006b5987ec67') and activeflag =1;

insert into rolemapping 
(id,principaltype,principalid,roleid,activeflag,insertedby,insertedon,updatedby, updatedon,teamtypekey)
values
(nextval('rolemapping_id_seq'),'USER','41522',40,1,'CJAMS-66274',now(),'CJAMS-66274',now(),'AS');

insert into rolemapping 
(id,principaltype,principalid,roleid,activeflag,insertedby,insertedon,updatedby, updatedon,teamtypekey)
values
(nextval('rolemapping_id_seq'),'USER','41522',41,1,'CJAMS-66274',now(),'CJAMS-66274',now(),'CW');

update teammember
set roletypekey = 'CWIW',updatedby = 'CJAMS-66274',updatedon =  now()
where teammemberid in ('489f9ce3-572c-4a6a-8916-9896ac00d845') and activeflag=1;

update teammember 
set roletypekey='ASIW',updatedby = 'CJAMS-66274',updatedon =  now() 
where teammemberid ='91cc7ad0-8d9f-4828-8f0a-aed1828eeba3' and activeflag =1;