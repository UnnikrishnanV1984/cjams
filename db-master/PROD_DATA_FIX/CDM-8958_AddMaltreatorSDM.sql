-- CDM-8958 - Add Alleged Maltreator in SDM tab

Insert into intakeservicerequestactor 
(intakeservicerequestactorid, actorid, intakeservicerequestpersontypekey, insertedon, insertedby, updatedon, updatedby, intakeserviceid, reported, isprimary, personid, intakenumber,servicecaseid)
values
('5d6b1753-3bdb-4241-916a-65d43afd35e5', '8c0024a9-b0e2-44ee-aede-fec56f92a122','AM', now(), 'CDM-8958', now(), 'CDM-8958', '5a30cd0f-0c76-4c83-a8ce-391f9e13b936', true, false, 'a3337569-c36a-40dc-be2b-2d2ac3f02ac2','CW10241715' , null);