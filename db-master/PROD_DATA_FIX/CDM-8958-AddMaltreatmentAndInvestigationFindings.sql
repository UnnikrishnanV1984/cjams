-- CDM-8958 - Add Maltreatment allegation and Investigation findings

-- Linking Eric to Logan
insert into investigationmaltreatment (maltreatmentid ,investigationid ,householdkey ,isjurisdiction ,activeflag ,insertedby ,insertedon ,updatedby ,updatedon ,incidentlocationtypekey )
values('606abd68-4aa8-4561-9c6d-f562d0d186cd','fc5e924e-090c-41b0-8b86-e231c1e53844','OS',0,1,'CDM-8958', now(),'CDM-8958', now(),'OTHER');

insert into investigationmaltreatmentactor (investigationmaltreatmentactorid ,maltreatmentid ,intakeservicerequestactorid ,activeflag ,insertedby ,insertedon ,updatedby ,updatedon )
values('75300401-06b6-4354-a096-cbbe5847fc18','606abd68-4aa8-4561-9c6d-f562d0d186cd','6a8015df-6042-4a20-8b73-ac30e57b3437',1,'CDM-8958',now(),'CDM-8958',now());

insert into investigationallegation (investigationallegationid ,investigationid ,allegationid ,"name" ,activeflag ,updatedby ,updatedon ,insertedby ,insertedon ,"comments" ,maltreatmentid ,investigationmaltreatmentactorid ,timeofincidence ,incidentlocationtypekey ,isproviderinvolved)
values('8fb1aff3-3658-4fd8-b9d7-1c6b71140a71','fc5e924e-090c-41b0-8b86-e231c1e53844','e11fc4b5-1edf-4f17-af54-b536bbf6df31', 'Neglect',1,'CDM-8958', now(),'CDM-8958',now(),'Gavin''''s school reported his mother was not properly taking care of his asthma and him and his brother were not coming to school on a daily basis.','606abd68-4aa8-4561-9c6d-f562d0d186cd','75300401-06b6-4354-a096-cbbe5847fc18','1970-01-01 14:30:00','OTHER',0);

insert into investigationallegationmaltreators (investigationallegationmaltreatorsid ,investigationallegationid ,intakeservicerequestactorid ,activeflag ,updatedby ,updatedon ,insertedby ,insertedon )
values('0b679801-8fe8-40a9-91b6-feaf731e34c4','8fb1aff3-3658-4fd8-b9d7-1c6b71140a71','5d6b1753-3bdb-4241-916a-65d43afd35e5',1,'CDM-8958',now(),'CDM-8958',now());


-- Linking Eric to Galvin
insert into investigationmaltreatment (maltreatmentid ,investigationid ,householdkey ,isjurisdiction ,activeflag ,insertedby ,insertedon ,updatedby ,updatedon ,incidentlocationtypekey )
values('c9863912-970e-4aee-883b-1023bab054e8','fc5e924e-090c-41b0-8b86-e231c1e53844','OS',0,1,'CDM-8958', now(),'CDM-8958', now(),'OTHER');

insert into investigationmaltreatmentactor (investigationmaltreatmentactorid ,maltreatmentid ,intakeservicerequestactorid ,activeflag ,insertedby ,insertedon ,updatedby ,updatedon )
values('3edc2be3-a39f-49c8-96b6-16f5837fe824','c9863912-970e-4aee-883b-1023bab054e8','327f94e7-0391-452d-a932-2f9aad845d0a',1,'CDM-8958',now(),'CDM-8958',now());

insert into investigationallegation (investigationallegationid ,investigationid ,allegationid ,"name" ,activeflag ,updatedby ,updatedon ,insertedby ,insertedon ,"comments" ,maltreatmentid ,investigationmaltreatmentactorid ,timeofincidence ,incidentlocationtypekey ,isproviderinvolved)
values('e9e45a91-0025-4caf-b939-1520d35e39f0','fc5e924e-090c-41b0-8b86-e231c1e53844','e11fc4b5-1edf-4f17-af54-b536bbf6df31', 'Neglect',1,'CDM-8958', now(),'CDM-8958',now(),'Gavin''''s school reported his mother was not properly taking care of his asthma and him and his brother were not coming to school on a daily basis.','c9863912-970e-4aee-883b-1023bab054e8','3edc2be3-a39f-49c8-96b6-16f5837fe824','1970-01-01 14:30:00','OTHER',0);

insert into investigationallegationmaltreators (investigationallegationmaltreatorsid ,investigationallegationid ,intakeservicerequestactorid ,activeflag ,updatedby ,updatedon ,insertedby ,insertedon )
values('aa720433-b095-4ff5-a764-36f76c0673a4','e9e45a91-0025-4caf-b939-1520d35e39f0','5d6b1753-3bdb-4241-916a-65d43afd35e5',1,'CDM-8958',now(),'CDM-8958',now());
