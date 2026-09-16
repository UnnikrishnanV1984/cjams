/*
   Issue Description: CDM-34921
   Category/ Module: Prod data fix to show the missing case
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.intakeservicerequest
SET intakeserreqstatustypeid='52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', intakeservicerequestclassid='b74ded78-12dc-4e6d-94db-7662d6eaf093', actiontype='AR', updatedby='CDM-34921', updatedon=now()
WHERE intakeserviceid='229d7ddc-a4e5-48e1-8588-e66de159916e' and activeflag=1 and servicerequestnumber='231021272879';

UPDATE cjams.routing
SET routingstatustypeid=2, activeflag=1
WHERE routingid='d3fd5d34-8d8a-48a9-8e4b-964367cd692e' and eventcode='INTR' and objectid='I231011388393';

UPDATE cjams.intakeservicerequestdispositioncode
SET updatedby='CDM-34921', updatedon=now(),intakeserreqstatustypeid='52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', servicerequesttypeconfigiddispostionid='9a333c30-8043-4732-9f9a-622b8d8038da'
WHERE intakeservicerequestdispositioncodeid='eecf49b6-ef54-48c3-974b-4a97107883aa' and intakeserviceid='229d7ddc-a4e5-48e1-8588-e66de159916e';

