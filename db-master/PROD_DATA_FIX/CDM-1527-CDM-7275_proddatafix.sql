update intakeservreqchildremoval set parent1id = null, vpaparentssigneddate = null,parent2signeddate = null, parent2id = null , vpaguardiansigneddate = '2018-03-22', guardianid = 3475913, updatedby = 'Data fix as per CDM-7275' where removalid = 189761;
update intakeservreqchildremoval set parent2comments = 'The childs father is unknown', updatedby = 'Data fix as per CIDM-1511' where removalid  = 181373;
update intakeservicerequestactor set activeflag = 1, updatedby = 'Data fix as per CIDM-1527' where intakeservicerequestactorid = '1ffd0ccb-9ae6-4714-91a1-c51ba87cc60a' and activeflag = 0;
