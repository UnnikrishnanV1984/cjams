/*
    Part 2
   Issue Description: CDM-25127
   Category/ Module  : case change
   Root cause: user wants to change case and then move all files
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update intakeservicerequest 
set activeflag = 1, servicerequestnumber = (select sc.servicecasenumber from servicecase sc where sc.servicecaseid = (select servicecaseid from intakeservicerequest i  where intakeserviceid = 'b11b0d4e-36ab-4695-a456-f625aa9f28ed')), updatedon = now(), updatedby = 'CDM-25127' 
where intakeserviceid = 'b11b0d4e-36ab-4695-a456-f625aa9f28ed';

update progressnote
set servicecaseid = (select servicecaseid from intakeservicerequest i  where intakeserviceid = 'b11b0d4e-36ab-4695-a456-f625aa9f28ed'), entitytype ='servicecase',entitytypeid = (select servicecaseid from intakeservicerequest i  where intakeserviceid = 'b11b0d4e-36ab-4695-a456-f625aa9f28ed'), updatedby = 'CDM-25127', updatedon = now()
where progressnoteid in ('0dabe040-7101-4533-9d84-700e84be5a63',
'67e2bed0-b2c1-4f2d-90a9-5a05add982f7',
'a62ac960-d0d0-417f-9eb9-fcdcba52c9b2',
'efa6ddb4-bde0-470d-b0ed-debdd08fd477',
'b89ed3fe-80a9-413f-b2b6-e7b22a258b8c',
'a77e3267-5d36-492f-aaa3-a5e43fb034a1',
'9ed2dd2a-5a65-4627-9557-fb65df4e1981',
'e6a03fcb-8bdb-44a4-a1de-c91bcec4fa70',
'09391552-4966-4120-837a-6ec9a5b63ded',
'586f5e87-c23a-42cb-9952-663a92bb4003');