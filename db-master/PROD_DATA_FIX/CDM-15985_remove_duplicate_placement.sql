/*
    Issue no: CDM-15985
    Root cause: User asked to remove the living arrangement placement
*/
update placement
set updatedby = 'CDM-15985', updatedon = now(), activeflag = 0
where placementid in ('c96b2189-272d-4f0a-97ce-c109bd037a54', '5e3d9bf7-9b26-4550-bdf1-fe7e3b3955dc');

update routing 
set updatedby = 'CDM-15985', updatedon = now(), activeflag = 0
where objectid in ('c96b2189-272d-4f0a-97ce-c109bd037a54', '5e3d9bf7-9b26-4550-bdf1-fe7e3b3955dc');

update livingarrangement 
set updatedby = 'CDM-15985', updatedon = now(), activeflag = 0
where placementid in ('c96b2189-272d-4f0a-97ce-c109bd037a54', '5e3d9bf7-9b26-4550-bdf1-fe7e3b3955dc');
