-- CDM-8155 - Add investigation allegations to the case

insert into investigationmaltreatment (maltreatmentid ,investigationid ,householdkey ,isjurisdiction ,activeflag ,insertedby ,insertedon ,updatedby ,updatedon ,timeofincidence ,incidentlocationtypekey ,isnotapplicable )
values('72ed270f-0778-4de0-bf1c-158f001c4267','43582285-2a8d-479f-9824-14caff2b2b75','UP',0,1,'CDM-8155',now(),'CDM-8155',now(),'2019-12-01 00:00:00','OTHER',0);

insert into investigationmaltreatmentactor (investigationmaltreatmentactorid ,maltreatmentid ,intakeservicerequestactorid ,activeflag ,insertedby ,insertedon ,updatedby ,updatedon )
values('45f4aafc-413b-4b54-8ec8-e1fb5c94ac27','72ed270f-0778-4de0-bf1c-158f001c4267','9ada9ba3-6381-4a95-a7f8-c37fb7c69cfb',1,'CDM-8155',now(),'CDM-8155',now());

insert into investigationallegation (investigationallegationid ,investigationid ,allegationid ,"name" ,activeflag ,updatedby ,updatedon ,insertedby ,insertedon ,"comments" ,maltreatmentid ,investigationmaltreatmentactorid ,timeofincidence ,incidentlocationtypekey ,isproviderinvolved)
values('5f7064a1-eccd-4664-ab43-65412202472b','43582285-2a8d-479f-9824-14caff2b2b75','e11fc4b5-1edf-4f17-af54-b536bbf6df31', 'Neglect',1,'CDM-8155', now(),'CDM-8155',now(),'Neglect allegations','72ed270f-0778-4de0-bf1c-158f001c4267','45f4aafc-413b-4b54-8ec8-e1fb5c94ac27','1970-01-01 16:55:00','OTHER',0);

insert into investigationallegationmaltreators (investigationallegationmaltreatorsid ,investigationallegationid ,intakeservicerequestactorid ,activeflag ,updatedby ,updatedon ,insertedby ,insertedon )
values('80cf9112-91e8-48bb-9ba5-465abb32250a','5f7064a1-eccd-4664-ab43-65412202472b','99672d5e-9d54-4dba-94c2-d96c0579c766',1,'CDM-8155',now(),'CDM-8155',now());
