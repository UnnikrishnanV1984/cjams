delete from cjams.progressnotereasontype where progressnotereasontypekey ='PR';

INSERT INTO cjams.progressnotereasontype(
progressnotereasontypeid, progressnotereasontypekey, activeflag, typedescription, effectivedate, insertedby,insertedon, updatedby, updatedon, old_id)
VALUES (gen_random_uuid(), 'PR', 1, 'Parent Engagement', now(),'B-100927',now(),'B-100927',now(),null);