--REMOVE OLD TRIGGERS - NOT NEEDED FOR INTERFACE

drop trigger IF EXISTS  tr_personrelationship_upd on  cjams.actorrelationship;

drop trigger if exists tr_caseclnt_upd on cjams.intakeservicerequestactor;
