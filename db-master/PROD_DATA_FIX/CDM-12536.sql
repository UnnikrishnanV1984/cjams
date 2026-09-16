update routing
set activeflag=0, updatedon =now(), updatedby = 'CDM-12537'
where routingid = '59c40a0a-7468-4736-90be-8be66c76eb9f';

update routing
set activeflag=0, updatedon =now(), updatedby = 'CDM-12536'
where servicerequestnumber = '2020022502358' and routingstatustypeid = 15 and activeflag=1
and eventcode = 'PLTR';