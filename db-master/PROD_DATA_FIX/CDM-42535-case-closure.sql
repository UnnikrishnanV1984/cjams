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
set fromsecurityusersid = '40d63914-2a9e-4abe-9616-c49bf0c269d3', 
activeflag = 1, 
updatedby = 'CDM-42535', 
updatedon =now(),
insertedon = '2024-10-11 17:38:04.968' 
                where objectid = (
                select intakeservicerequestdispositioncodeid from intakeservicerequestdispositioncode i 
                where intakeserviceid = 'a3808c28-050d-4d48-8607-3ea1a5ef7298' limit 1)::text;
                
update intakeserreqstatustype 
set description = 'Completed', 
updatedby = 'CDM-42535', 
updatedon = now()
          where intakeserreqstatustypeid = (
          select intakeserreqstatustypeid from intakeservicerequest i where servicerequestnumber = '241022800890' limit 1
          );
                 
                 
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, 
tosecurityusersid, teamid, fromroleid, toroleid, 
objectid, 
routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, 
routeddescription, servicerequestnumber)
VALUES(gen_random_uuid(), 'INDR', '2c72004f-074a-4171-a603-cdf89ec812dd', 
'40d63914-2a9e-4abe-9616-c49bf0c269d3', 'ee40a757-5378-409f-a7c6-118368415a99', 'CWCW', 'CWSP', 
(select intakeservicerequestdispositioncodeid 
            from cjams.intakeservicerequestdispositioncode 
            where intakeserviceid = 'a3808c28-050d-4d48-8607-3ea1a5ef7298' 
                limit 1),
15, 1, '2c72004f-074a-4171-a603-cdf89ec812dd', '2024-10-11 14:00:00.000', 'CDM-42535', now(), true, '',
'', '241022800890');