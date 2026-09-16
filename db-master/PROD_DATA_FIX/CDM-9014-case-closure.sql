UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2021-01-15T16:52:55', updatedby = 'CDM-9014',updatedon = now() WHERE servicecaseid = '5e6d16ee-321e-4f1a-aa4f-bf8c1c341003';

INSERT INTO servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('f6b8766a-e448-4bf4-b039-4194b76f7a79', '5e6d16ee-321e-4f1a-aa4f-bf8c1c341003', '2021-01-15T16:52:55', 'Closed', 'Closed', '2021-01-15T16:52:55', 1, 'CDM-9014',now(),'CDM-9014',now());

insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('SCDR', 'ce7f5b14-ceeb-462b-bcf8-c48625454355', 'ce7f5b14-ceeb-462b-bcf8-c48625454355', 'CWSP', 'CWSP', 'f6b8766a-e448-4bf4-b039-4194b76f7a79', 16, 1, 'CDM-9014',now(),'CDM-9014', now());