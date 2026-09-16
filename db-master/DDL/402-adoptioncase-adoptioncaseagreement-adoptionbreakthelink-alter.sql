 alter table cjams.adoptioncase add column placementagreementdate timestamp without time zone;
 alter table cjams.adoptioncase  add column adoptionplacementstatustypekey varchar(100);
 alter table cjams.adoptioncase  add column agencyinvolmenttypekey varchar(100);
 alter table cjams.adoptionbreakthelink add column courtorderid uuid;
 alter table cjams.adoptioncaseagreement add column providerid integer;
 alter table cjams.adoptioncaseagreement add column adoptiveparent1id integer;
 alter table cjams.adoptioncaseagreement add column adoptiveparent2id integer;