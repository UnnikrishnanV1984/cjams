update programcategorylink set activeflag =1 where programcategorylinkid in ('3424ba69-1490-49b2-90a8-e855ac3e6ce0','53b46a4d-c270-4649-84db-3e21c0aa3be7');

update roletype set roletypename ='LDSS Director' where roletypecode = 'DF';

update teammemberroletype set description ='LDSS Director' where roletypekey = 'FNSDF';