update userresource
set activeflag = 0, updatedon = now(), updatedby ='CIDM-6146'
where userresourceid in ('5caac41a-3175-4ab9-acaf-9ae31bafbc84','ecf81a9b-45b4-450e-a435-1100e8e73394') and userid = 11946;

update rolemapping 
set roleid = 71,updatedon = now(), updatedby ='CIDM-6146'
where id = 103806861 and roleid = 36 and principalid ='11946';

update rolemapping 
set activeflag = 0,updatedon = now(), updatedby ='CIDM-6146'
where id = 78206595 and roleid = 34 and principalid ='11946'; 
 
update teammember 
set roletypekey = 'CWCW',updatedon = now(), updatedby ='CIDM-6146'
where teammemberid = '5b8b9c11-d4cb-47a4-9fff-daf38f660afd';