update routing 
set activeflag =0, updatedon =now(), updatedby ='CDM-9656'
where objectid ='cc7f22c7-e3c5-4245-8e92-c5a49e9f93e5'
and routingstatustypeid =15
and activeflag =1;