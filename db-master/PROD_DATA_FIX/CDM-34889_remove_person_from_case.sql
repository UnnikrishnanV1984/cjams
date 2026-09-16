/*
   Issue Description: CDM-34889 - Person Removal From Case
   Category/ Module  : Person removal from service case  
   Root cause: Person was added to the case in error
   Resolution:made an update to make the person inactive for that case provided.
   Status of the code fix if already submitted and expected prod fix date: 
*/


update actor set activeflag = 0, updatedby = 'CDM-34889', updatedon = now() 
where personid = '7c993e63-4d64-4a05-a307-308a7ff75982' and servicecaseid = '6859be25-f885-49d1-8429-2bdc5d5e7e28';

update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-34889', updatedon = now() 
where personid = '7c993e63-4d64-4a05-a307-308a7ff75982' and servicecaseid = '6859be25-f885-49d1-8429-2bdc5d5e7e28';

update personrole set activeflag = 0, updatedby = 'CDM-34889', updatedon = now() 
where personid = '7c993e63-4d64-4a05-a307-308a7ff75982' and servicecaseid = '6859be25-f885-49d1-8429-2bdc5d5e7e28';


---- update contact person from paul Brown to paul Brolin---CDM-34889

update 
  progressnote 
set 
  focusperson = '{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"353fe1d5-1249-4462-81b8-5be2e4819c99",
"participantid":"353fe1d5-1249-4462-81b8-5be2e4819c99","firstname":"SAMANTHA","lastname":"HATFIELD","address1":null,
"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null},{"participanttypekey":"IP",
"intakeservicerequestactorid":"1d1ca877-7fea-45ab-a1d4-6424851db4d4","participantid":"1d1ca877-7fea-45ab-a1d4-6424851db4d4",
"firstname":"MICHAEL","lastname":"HATFIELD","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,
"email":null,"phonenumber":null},{"participanttypekey":"IP",
"intakeservicerequestactorid":"b8869ce3-e5f1-4e99-af37-8a952766cc1d","participantid":"b8869ce3-e5f1-4e99-af37-8a952766cc1d",
"firstname":"Paul","lastname":"Brolin","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,
"phonenumber":null}]}', 
  updatedon = now(), 
  updatedby = 'CDM-34889' 
where 
  progressnoteid = 'e634be18-db27-4a58-9009-ec324d47276d' 
  and progressnotetypeid = 'b83d8c25-f7db-4816-87f4-35a657790ad4' 
  and entitytypeid = 'df641bc5-d0e5-4248-a680-6da46b3c56fd';
 
update 
  contactparticipant 
set 
  intakeservicerequestactorid = 'ef91de49-484b-4f42-8c95-d549bcb24227', 
  updatedby = 'CDM-34889', 
  updatedon = now() 
where 
  contactparticipantid in (
    select 
      cp.contactparticipantid 
    from 
      progressnote p 
      inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
      inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid = cp.intakeservicerequestactorid 
    where 
      p.activeflag = 1 
      and insr2.personid = '7c993e63-4d64-4a05-a307-308a7ff75982' 
      and insr2.intakeserviceid = 'df641bc5-d0e5-4248-a680-6da46b3c56fd'
  );