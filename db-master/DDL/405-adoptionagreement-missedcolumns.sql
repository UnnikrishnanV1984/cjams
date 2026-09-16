 --These coulmns have already been added to adoptioncaseagreement
 --Need to have them in adoptionagreement as well
 
 alter table cjams.adoptionagreement add column providerid integer;
 alter table cjams.adoptionagreement add column adoptiveparent1id integer;
 alter table cjams.adoptionagreement add column adoptiveparent2id integer;