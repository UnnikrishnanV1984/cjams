update intakeservicerequestactor set activeflag = 0 where intakeservicerequestactorid in (select intakeservicerequestactorid from investigationmaltreatmentactor where maltreatmentid in (select maltreatmentid from investigationmaltreatment where investigationid = '35236197-bbec-45ee-92ef-3b9d8a70b778')); 
update investigationmaltreatmentactor set activeflag = 0 where maltreatmentid in (select maltreatmentid from investigationmaltreatment where investigationid = '35236197-bbec-45ee-92ef-3b9d8a70b778'); 
update allegation set activeflag = 0 where allegationid in (select allegationid from investigationallegation where maltreatmentid in (select maltreatmentid from investigationmaltreatment i where investigationid = '35236197-bbec-45ee-92ef-3b9d8a70b778'));
update investigationallegation set activeflag = 0 where maltreatmentid in (select maltreatmentid from investigationmaltreatment i where investigationid = '35236197-bbec-45ee-92ef-3b9d8a70b778');
update investigationmaltreatment set activeflag = 0 where investigationid = '35236197-bbec-45ee-92ef-3b9d8a70b778';
update investigation set activeflag = 0 where investigationid = '35236197-bbec-45ee-92ef-3b9d8a70b778';
