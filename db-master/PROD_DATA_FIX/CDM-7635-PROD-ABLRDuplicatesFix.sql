update routing 
set activeflag =0, updatedon =now(), updatedby ='CDM-7635'
where routingid in ('bc47c539-2e23-47c6-badd-1610dadbad04',
'ccc115e9-0d23-471b-9fe9-2b89f644db4e',
'71a22b98-9eb0-4c61-bdcb-a9c6154418c6');

update adoptionbreakthelink 
set activeflag =0, updatedon =now(), updatedby ='CDM-7635'
where adoptionbreakthelinkid in ('5f2f030c-c862-47fa-8766-838b89b3d327',
'bbf29b5d-a854-4ba9-a191-8c8bf38a3f3b',
'e9a2852c-f700-4de9-929e-5069cafa1309');