create index Xie1_senhistorynotifications on senhistorynotifications(personid);
create index Xie1_personabusesubstance on personabusesubstance(personid);
create index Xie1_personguardianfuneral on personguardianfuneral(personid);
create index Xie1_personrole_history on personrole_history(personid);
create index Xie2_personrole_history on personrole_history(updatedby);
create index Xie1_personmedicalconditioninfo on personmedicalconditioninfo(personmedicalconditionid);
create index Xie1_personhospitalization on personhospitalization(personid);
create index Xie1_personexamination on personexamination(personid);


