/*
   Issue Description: CDM-20478
   Items will not disappear from approval log
*/


update routing 
set activeflag = 0, updatedby = 'CDM-20478', updatedon = now()
where routingid in ('041d8928-946d-43ab-b2f6-e4caf3d6544b','cc752cd9-5413-4da3-b618-c6d7e1c7a3b0','5ca708e3-930c-4533-969a-55ecd10183ca',
'94256bf4-1d6b-4e97-9696-b04f5f099b1f','1551fd2a-1385-4785-b5d4-c246f1a0d404');