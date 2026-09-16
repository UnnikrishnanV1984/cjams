update intakeservicerequestactor set
activeflag = 1,
updatedon = now(),
updatedby = 'CDM-14416'
where intakeservicerequestactorid = '94d9f514-2d7d-4026-9afb-4ab3e54864ce';

update actor set
activeflag = 1,
updatedon = now(),
updatedby = 'CDM-14416'
where actorid = '5ecbd7f0-2b48-446d-9925-6e5b038b777f';