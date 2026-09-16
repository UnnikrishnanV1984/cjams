
update intakeservreqcourtorder set intakeservicerequestactorid = 'ae62a86a-32ed-4155-a397-e7b28e8a512b', updatedon = now(), updatedby = 'CDM-11731' where intakeservreqcourtorderid = '49fc99f5-025a-4280-bbec-adbe721bd62b' and activeflag = 1;

------- CDM-11573 ----

update intakeservicerequestactor i set activeflag = 1 , updatedon = now(), updatedby = 'CDM-11573' where intakeservicerequestactorid = '95663358-a0f6-4901-9d56-ad13c2965260' and activeflag = 0;
