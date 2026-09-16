update intakeservicerequestactor set activeflag = 1 , updatedby = 'CDM-9376', updatedon = now() where intakeservicerequestactorid = '824bfa2d-00cc-434a-9a70-20265ed7cad4' and activeflag = 0;

update intakeservicerequestcourthearing i set activeflag = 1, updatedon = now(), updatedby = 'Data fix as per CDM-8888' where intakeservicerequestcourthearingid in ('53c27ed3-24ea-488c-a811-629e2a855528', '7fc61ee6-b54b-4515-89a3-dd66c49e71d6') and activeflag = 0;

update intakeservicerequestcourthearing i set activeflag = 1, updatedon = now(), updatedby = 'Data fix as per CDM-9378' where intakeservicerequestcourthearingid = 'e9bb6aaf-067e-4ad7-a78a-5ff9e09ec4f8' and activeflag = 0; 

update intakeservicerequestcourthearing i set activeflag = 1, updatedon = now(), updatedby = 'Data fix as per CDM-9380' where intakeservicerequestcourthearingid = '97c42ca8-0706-43e1-bda3-18d654b07546' and activeflag = 0; 


update intakeservicerequestcourthearing i set activeflag = 1, updatedon = now(), updatedby = 'Data fix as per CDM-9383' where intakeservicerequestcourthearingid in ('43c67d3c-4c11-494a-ba16-efdee69536fa', 'b2bc2e2f-44b1-494c-98bd-d4aaf8c3ee40') and activeflag = 0;

update intakeservicerequestcourthearing i set activeflag = 1, updatedon = now(), updatedby = 'Data fix as per CDM-9381' where intakeservicerequestcourthearingid = '1da29160-1290-44ad-8faf-22f183769e7a' and activeflag = 0; 


