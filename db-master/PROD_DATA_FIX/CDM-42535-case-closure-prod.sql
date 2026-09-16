/* 
    Issue Description: CDM-42535
  Category/ Module  : Decision
  Root cause: User request to insert the completed record
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

 INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, 
tosecurityusersid, teamid, fromroleid, toroleid, 
objectid, 
routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, 
routeddescription, servicerequestnumber)
VALUES(gen_random_uuid(), 'INDR', '40d63914-2a9e-4abe-9616-c49bf0c269d3', 
'2c72004f-074a-4171-a603-cdf89ec812dd', 'ee40a757-5378-409f-a7c6-118368415a99', 'CWCW', 'CWSP', 
(select intakeservicerequestdispositioncodeid 
            from cjams.intakeservicerequestdispositioncode 
            where intakeserviceid = 'a3808c28-050d-4d48-8607-3ea1a5ef7298' 
                limit 1),
16, 1, '2c72004f-074a-4171-a603-cdf89ec812dd', '2024-10-11 14:00:00.000', 'CDM-42535', now(), true, '',
'', '241022800890');

update routing 
set fromsecurityusersid = '2c72004f-074a-4171-a603-cdf89ec812dd',
updatedby = 'CDM-42535',
updatedon = now()
where routingid = 'f679afe2-0915-4980-acaa-68b003974028';


update intakeservicerequest  
set intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8',
updatedby = 'CDM-42535', 
updatedon =now() 
where servicerequestnumber = '241022800890';