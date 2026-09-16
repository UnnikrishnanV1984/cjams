delete from cjams.programareaconfig where programkey in ('IHSFP') and subprogramkey in ('FPSMI', 'CSMI', 'MI') and activeflag = 1;

delete from referencevalues where ref_key in ('FPSMI', 'CSMI') and referencetypeid = 12 and activeflag = 1;

delete from progressnotereasontype  where progressnotereasontypekey in ('MI') and activeflag =1;



INSERT INTO cjams.programareaconfig
(programkey, subprogramkey, servicerequestsubtypekey, isdefault, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id)
VALUES('IHSFP', 'FPSMI', 'IHM', 0, 1, now(), 'CIDM-11321', NULL, 'CIDM-11321', now(), NULL);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FPSMI', 12, 'Family Preservation Services - Motivational Interviewing (MI)', 'Family Preservation Services - Motivational Interviewing (MI)', 'CW', 1, 1, 'CIDM-11321' ,now(), 'CIDM-11321' , now(), NULL, NULL, NULL);

INSERT INTO cjams.programareaconfig
(programkey, subprogramkey, servicerequestsubtypekey, isdefault, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id)
VALUES( 'IHSFP', 'CSMI', 'IHM', 0, 1, now(), 'CIDM-11321', NULL, 'CIDM-11321', now(), NULL);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CSMI', 12, 'Consolidated Services - Motivational Interviewing', 'Consolidated Services - Motivational Interviewing', 'CW', 1, 1, 'CIDM-11321' ,now(), 'CIDM-11321' , now(), NULL, NULL, NULL);


INSERT INTO cjams.progressnotereasontype
(progressnotereasontypekey, activeflag, typedescription, effectivedate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('MI', 1, 'Motivational Interviewing (MI)', now(), 'CIDM-11321', 'CIDM-11321',now(), now(), NULL);



------------------------------------------------

-- 05/27/2026 - CIDM-11321 - Enable Pilot counties for Motivational interview Story (Allegany, Garrett, or Washington)
--Garrett
--Allegany
--Washington
-----------------------------------------




DELETE FROM cjams.countygoliveconfig
WHERE objecttype ='motivational-interview';

INSERT INTO cjams.countygoliveconfig
(objecttype, statewide, charles, washington, stmarys, annearundel, frederick, garrett, carroll, allegany, princegeorges, montgomery, calvert, baltimorecity, baltimorecounty, caroline, dorchester, kent, queenannes, somerset, wicomico, worcester, cecil, talbot, harford, howard, dhris, insertedon, insertedby, updatedon, updatedby, activeflag)
VALUES('motivational-interview', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, now(), 'CIDM-11321', now(), 'CIDM-11321', 1);