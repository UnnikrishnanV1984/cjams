update teammember
set teamid = 'b50f2419-42ba-4ab6-84ab-5172917d2d77', updatedon =now(), updatedby ='CDM-13403'
where teammemberid = '2faa328c-adf6-48af-8d8e-79264f5b2a6b';

update routing
set activeflag=0, updatedon =now(), updatedby = 'CDM-13274'
where routingid ='9d25aa30-606a-4203-8059-61edf8b7f02b';