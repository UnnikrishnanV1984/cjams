/* 
    Issue Description: CDM-42535
  Category/ Module  : Decision
  Root cause: User request to insert the completed record
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

update routing 
set routingstatustypeid = 16,
updatedby = 'CDM-42535', 
updatedon =now()
                where objectid = '05d6c0a3-5045-4e2a-8e96-c75bb84f5725' 
     and fromsecurityusersid = '40d63914-2a9e-4abe-9616-c49bf0c269d3';

update routing 
set activeflag = 1, 
updatedby = 'CDM-42535', 
updatedon =now()
                where objectid = '56113e72-be17-404b-a518-d0c3033c2951' 
     and fromsecurityusersid = '40d63914-2a9e-4abe-9616-c49bf0c269d3' and routingstatustypeid  = 15;

update intakeservicerequest  
set intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8',
updatedby = 'CDM-42535', 
updatedon =now() 
where servicerequestnumber = '241022800890';

update routing 
set activeflag = 0,
routingstatustypeid = 15,
updatedby = 'CDM-42535', 
updatedon =now() 
where objectid  = '56113e72-be17-404b-a518-d0c3033c2951' 
and fromsecurityusersid = '40d63914-2a9e-4abe-9616-c49bf0c269d3';

update routing 
set insertedon = '2024-10-11 14:00:04.968',
updatedby = 'CDM-42535', 
updatedon =now()
where objectid = '05d6c0a3-5045-4e2a-8e96-c75bb84f5725'
and fromsecurityusersid = '40d63914-2a9e-4abe-9616-c49bf0c269d3';