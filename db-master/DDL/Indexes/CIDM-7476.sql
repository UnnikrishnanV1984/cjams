create index if not exists Xie1_personhospitalization on personhospitalization(personid);
create index if not exists Xie1_personexamination on personexamination(personid);
create index if not exists Xie1_youthtransitionplan on youthtransitionplan(clientid,intakeserviceid);
create index if not exists Xie1_permanencyplanhistory on permanencyplanhistory(permanencyplanid);
create index if not exists Xie2_permanencyplanhistory on permanencyplanhistory(objectid);
create index if not exists Xie3_permanencyplanhistory on permanencyplanhistory(insertedby);
create index if not exists Xie1_senhistorynotifications on senhistorynotifications(personid);
create index if not exists Xie1_personabusesubstance on personabusesubstance(personid);
create index if not exists Xie1_personguardianfuneral on personguardianfuneral(personid);
create index if not exists Xie1_personrole_history on personrole_history(personid);
create index if not exists Xie2_personrole_history on personrole_history(updatedby);
create index if not exists Xie1_personmedicalconditioninfo on personmedicalconditioninfo(personmedicalconditionid);
create index if not exists Xie1_serviceplangoal on serviceplangoal(objectid);
CREATE INDEX if not exists idx_intakeservicerequestsdm_intakeserviceid_activeflag ON cjams.intakeservicerequestsdm USING btree (intakeserviceid, activeflag);
create index if not exists Xie1_personspouseaddress on personspouseaddress(personid,activeflag);
create index if not exists Xie1_personmaritalstatus on personmaritalstatus(personid,activeflag);
--alter table personmaritalstatus ADD CONSTRAINT PK_personmaritalstatus primary key (personmaritalstatusid);
--alter table personspouseaddress ADD CONSTRAINT PK_personspouseaddress primary key (personspouseaddressid);

