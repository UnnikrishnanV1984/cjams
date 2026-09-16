/*
  Issue Description:  CDM-44080
   Category/ Module  :  Contacts
   Root cause: User request to update the remove the contact purpose as APGRB Meeting from the respective contact.
   Pull request# for code fix: NA
   Reason why no related code fix: NA
*/

update progressnote set progressnotereasontypekey='CPS,CM', updatedby ='CDM-44080',updatedon =now()
where progressnoteid= 'b52dc9d3-9fc8-4554-bb2d-f4b3c8cf23a4' and activeflag=1;
