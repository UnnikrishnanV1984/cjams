delete from cjams.progressnotereasontype where progressnotereasontypekey ='HO';

INSERT INTO cjams.progressnotereasontype(
progressnotereasontypeid, progressnotereasontypekey, activeflag, typedescription, effectivedate, insertedby,insertedon, updatedby, updatedon, old_id)
VALUES (gen_random_uuid(), 'HO', 1, 'Housing', now(),'B-100927',now(),'B-100927',now(),null);

delete from cjams.progressnotereasontype where progressnotereasontypekey ='EMP';

INSERT INTO cjams.progressnotereasontype(
progressnotereasontypeid, progressnotereasontypekey, activeflag, typedescription, effectivedate, insertedby,insertedon, updatedby, updatedon, old_id)
VALUES (gen_random_uuid(), 'EMP', 1, 'Employment', now(),'B-100927',now(),'B-100927',now(),null);