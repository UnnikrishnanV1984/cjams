--D-22015 extra investigation maltreatment causing issues with casde closure
UPDATE investigationmaltreatment
SET activeflag = 0, updatedby = 'admin-D22015'
WHERE maltreatmentid = 'dfdce448-f183-4302-a95c-89f1b0976a6b';

UPDATE investigationallegation
SET activeflag = 0, updatedby = 'admin-D22015'
WHERE investigationallegationid = 'ac29d8cd-5f2e-43e7-805a-a2887d8ed9c0';