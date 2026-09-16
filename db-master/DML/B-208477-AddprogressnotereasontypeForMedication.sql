----------------------------------------------------------------
-- 04/08/2025 - B-208462 - Naveenkumar Chemutu
---------------------------------------------------------------


delete from progressnotereasontype where progressnotereasontypekey= 'MDICT';
	
INSERT INTO progressnotereasontype
(progressnotereasontypeid, progressnotereasontypekey, activeflag, typedescription, effectivedate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(gen_random_uuid(), 'MDICT', 1, 'Medication', now(), 'CIDM-10354', 'CIDM-10354', now(), now(), '');	