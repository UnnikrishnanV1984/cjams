
/*
Issue Description: Need analysis and fix to select all the 3 roles for the client and identify the client as Alleged Maltreater.
Category/Module: Support
Root cause: due to data glitch person roles not mapped propely.
Fix provided: DB queries to update  record in actor  and intakeservicerequestactor table.
Data/Code fix ticket#: CJAMS-58635
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
delete from routing where insertedby = 'CJAMS-58635';
delete from placementrevision where insertedby = 'CJAMS-58635';
delete from livingarrangement where placementid = (select placementid from placement where insertedby = 'CJAMS-58635');
delete from placement where insertedby = 'CJAMS-58635';
*/

update intakeservicerequestactor
set activeflag = 0,updatedby = 'CJAMS-58635', updatedon = now()
where intakeservicerequestactorid in ('5360ae45-1dc5-45ff-8ca4-72899f0a644e', 'e180673b-74b1-4626-8814-22d34c881446',
'e3ba22a7-f6ff-4b84-b672-3a12b423ae0e','74b89c2c-5585-421e-b473-a0cd0cb6de47','13d55329-6c41-44c9-9509-f35afc2c9283',
'7823f7d6-c314-4960-8f6b-1e78396eebfd',
'33d5735f-476f-4925-a88e-2fc7587c6cca',
'c2a71678-0335-4e5c-84aa-1930133691ec',
'8d568c67-c70b-4f21-a30a-b17f331d96c8',
'8631fa79-c644-4ad7-adec-33c9071634e5',
'380cc39c-4f84-48d8-b1cc-8efd4ce57d2e') and activeflag = 1;

update actor
set activeflag = 0,updatedby = 'CJAMS-58635', updatedon = now()
where actorid in ('8648e6d9-0326-41a1-bf42-3e121a7d1dbb','787eec21-2c9d-4ec1-85e8-d8c489abcfb6','ce1964ac-eccb-431f-ae45-49b8b8a7ad4a',
'cc5e8c85-8b5b-4cb8-9498-49ba5a655e3c') and activeflag =1;

update intakeservicerequestactor
set intakeserviceid = '60a5d585-607b-4aea-b33f-7baa3a60a337',updatedby = 'CJAMS-58635', updatedon = now()
where intakeservicerequestactorid in ('a866ff18-81e2-4fa4-bf84-58cd93122c13',
'da162847-a623-4396-a951-56621776cc42',
'b4fe3cda-720e-49bc-b6dc-4ff91f1ba227')
and activeflag =1;

--b4fe3cda-720e-49bc-b6dc-4ff91f1ba227
update intakeservicerequestactor
set intakeservicerequestpersontypekey  = 'OtherADULT',updatedby = 'CJAMS-58635', updatedon = now()
where intakeservicerequestactorid in ('b4fe3cda-720e-49bc-b6dc-4ff91f1ba227','a866ff18-81e2-4fa4-bf84-58cd93122c13','22ceaee2-0a6f-4bba-a31a-9aa660961545')
and activeflag =1;


delete from intakeservicerequestactor where insertedby = 'CJAMS-58635';

insert into intakeservicerequestactor
(intakeservicerequestactorid,actorid,intakeservicerequestpersontypekey,insertedby,insertedon,
updatedby,updatedon, intakeserviceid, activeflag,personid,rcactiveflag,
intakenumber,isheadofhousehold)
values 
(gen_random_uuid(),'44bc2ed5-6e20-4295-bd88-32ead9621b47','PARENT','CJAMS-58635',now(),
'CJAMS-58635',now(), '60a5d585-607b-4aea-b33f-7baa3a60a337', 1,'752841bb-1be4-4402-859a-2ac2fb91d80f',1,
'I251013236491',false);


insert into intakeservicerequestactor
(intakeservicerequestactorid,actorid,intakeservicerequestpersontypekey,insertedby,insertedon,
updatedby,updatedon, intakeserviceid, activeflag,personid,rcactiveflag,
intakenumber,isheadofhousehold)
values 
(gen_random_uuid(),'9bcf56bf-68ee-414e-b1ff-256f77009d52','PARENT','CJAMS-58635',now(),
'CJAMS-58635',now(), '60a5d585-607b-4aea-b33f-7baa3a60a337', 1,'cbf1ce3a-419f-45a1-9025-81173e660c5f',1,
'I251013236491',false);


insert into intakeservicerequestactor
(intakeservicerequestactorid,actorid,intakeservicerequestpersontypekey,insertedby,insertedon,
updatedby,updatedon, intakeserviceid, activeflag,personid,rcactiveflag,
intakenumber,isheadofhousehold)
values 
(gen_random_uuid(),'3da7da30-9d97-480d-a105-939234c94ad5','OtherADULT','CJAMS-58635',now(),
'CJAMS-58635',now(), '60a5d585-607b-4aea-b33f-7baa3a60a337', 1,'f1134993-a9d2-40e7-8854-55c7555fef8a',1,
'I251013236491',false);