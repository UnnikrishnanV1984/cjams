/*
   Issue Description: CDM-39896
   Category/ Module  : Decision
   Root cause:  worker is not able to send the case for closure due to there not being  completed face-to-face contact with  the alleged maltreator and alleged victim
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update
   intakeservicerequest 
set
   intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby = 'CDM-39896', updatedon = now() 
where  intakeserviceid = 'e1ca6173-f580-4b0d-9f21-b9ff76550530' and activeflag=1;
  

 delete from intakeservicerequestdispositioncode where updatedby='CDM-39896';

INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, 
updatedby, updatedon, statusdate, description, effectivedate, activeflag, intakeserreqstatustypeid, 
servicerequesttypeconfigiddispostionid, 
reviewcomments, reasonfordelay)
VALUES(gen_random_uuid(), 'e1ca6173-f580-4b0d-9f21-b9ff76550530', '856908af-c2a0-4e55-ab1a-6d93c4baceeb', '2024-06-24 10:00:00.000', 
'CDM-39896', now(), '2024-06-24 11:00:00.000', 'Completed', '2024-06-24 11:00:00.000', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8', 
'd90db0d3-f665-49db-b3ad-0edb468bc02d', 
'', '');

update intakeservicerequestdispositioncode 
set insertedon ='2024-05-02 09:01:34.973',
updatedon =now(),
updatedby ='CDM=39896' 
where intakeservicerequestdispositioncodeid ='3cc1f7e5-0c11-443a-b291-36bcc2dfd388' and intakeserviceid ='e1ca6173-f580-4b0d-9f21-b9ff76550530' and activeflag =1;



-- select * from routing where servicerequestnumber='241022041347' and activeflag = 1 and eventcode in ('INDR', 'INVT');

DELETE FROM routing where servicerequestnumber='241022041347' and updatedby='CDM-39896' and activeflag = 1 and eventcode in ('INDR', 'INVT');

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, 
tosecurityusersid, teamid, fromroleid, toroleid, 
objectid, 
routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, 
routeddescription, servicerequestnumber)
VALUES(gen_random_uuid(), 'INDR', '856908af-c2a0-4e55-ab1a-6d93c4baceeb', 
'99a068e8-c725-4835-9aee-0712f9d4021c', '79b67c84-50b6-4521-8fc8-5d1fa6e41a3c', 'CWCW', 'CWSP', 
(select intakeservicerequestdispositioncodeid 
            from cjams.intakeservicerequestdispositioncode 
            where intakeserviceid = 'e1ca6173-f580-4b0d-9f21-b9ff76550530' 
                and updatedby = 'CDM-39896'),
15, 0, '856908af-c2a0-4e55-ab1a-6d93c4baceeb', '2024-06-24 11:00:00.000', 'CDM-39896', now(), true, '',
'', '241022041347');


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, 
tosecurityusersid, teamid, fromroleid, toroleid, 
objectid, 
routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, 
routeddescription, servicerequestnumber)
VALUES(gen_random_uuid(), 'INDR', '99a068e8-c725-4835-9aee-0712f9d4021c', 
'856908af-c2a0-4e55-ab1a-6d93c4baceeb', '79b67c84-50b6-4521-8fc8-5d1fa6e41a3c', 'CWSP', 'CWCW', 
(select intakeservicerequestdispositioncodeid 
            from cjams.intakeservicerequestdispositioncode 
            where intakeserviceid = 'e1ca6173-f580-4b0d-9f21-b9ff76550530' 
                and updatedby = 'CDM-39896'),
16, 1, '856908af-c2a0-4e55-ab1a-6d93c4baceeb', '2024-06-24 11:00:00.000', 'CDM-39896', now(), true, '',
'', '241022041347');




-----Updating end date in assignments  
update
   caseassignment 
set
   enddate = '2024-06-24 10:00:00.000', updatedby = 'CDM-39896', updatedon = now() 
where
   caseassignmentid = '130fcd97-3a12-4c5f-aed9-01b740152084';
  
--Updating the end date and updtaedby in person

update personprogramarea set enddate='2024-06-25 10:00:00.000', updatedby = '99a068e8-c725-4835-9aee-0712f9d4021c', updatedon = now() 
where personprogramid in ('7855f389-c7e9-4163-a8d6-96ce3a2fd9d4', '4d3a8500-784a-4a11-9baf-8771c4c78c6c','8ffa5fe9-383e-4d4e-86a0-91384fe150d5')
and enddate is null;

INSERT INTO cjams.legislative
(legislativeid, intakeserviceid, isapprovedsafec, activeflag, updatedby, updatedon, 
insertedby, insertedon, isinitialfacetoface, isapprovedmfira, isapprovecansf,
isvictimperpetrator, isallpersons, isallegedvicitm, isemergency, islegislativereporting, 
isreasonnotprovided, isdataentrynotes, islateinitialcontact)
values(gen_random_uuid(), 'e1ca6173-f580-4b0d-9f21-b9ff76550530', true, 1, 'CDM-39896', now(), 
'856908af-c2a0-4e55-ab1a-6d93c4baceeb', now(), false, true, true, 
true, true, NULL, '', Null, 
'', '', false);