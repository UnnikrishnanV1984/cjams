delete from referencevalues where ref_key = 'ADHDS' and referencetypeid = 97;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ADHDS', 97, 'Attention Deficit Hyperactivity Disorder','Attention Deficit Hyperactivity Disorder', 'CW', 1, 9, 'CIDM-5204', now(), NULL, NULL, NULL, NULL, NULL);

delete from referencevalues where ref_key = 'DEVD' and referencetypeid = 97;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('DEVD', 97, 'Developmental Disability','Developmental Disability', 'CW', 1, 10, 'CIDM-5204', now(), NULL, NULL, NULL, NULL, NULL);

delete from referencevalues where ref_key = 'SMD' and referencetypeid = 97;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SMD', 97, 'Serious Mental Disorders','Serious Mental Disorders', 'CW', 1, 11, 'CIDM-5204', now(), NULL, NULL, NULL, NULL, NULL);

update referencevalues  set value_text = 'Developmental Delay',description ='Developmental Delay' , updatedby ='CDM-5204', 
updatedon =now() where ref_key ='MRD'  and referencetypeid =97 and teamtypekey = 'CW';

update referencevalues  set value_text = 'Mental/Emotions Disorder',description ='Mental/Emotions Disorder' , updatedby ='CDM-5204', 
updatedon =now() where ref_key ='EMDY'  and referencetypeid =97 and teamtypekey = 'CW';

update referencevalues  set value_text = 'Hearing Impairment and Deafness',description ='Hearing Impairment and Deafness' , updatedby ='CDM-5204', 
updatedon =now() where ref_key ='HDY'  and referencetypeid =97 and teamtypekey = 'CW';

update referencevalues  set value_text = 'Other Diagnosed Condition',description ='Other Diagnosed Condition' , updatedby ='CDM-5204', 
updatedon =now() where ref_key ='ODY'  and referencetypeid =97 and teamtypekey = 'CW';

update referencevalues  set value_text = 'Orthopedic Impairment or Other Physical Condition',description ='Orthopedic Impairment or Other Physical Condition' , updatedby ='CDM-5204', 
updatedon =now() where ref_key ='PYDY'  and referencetypeid =97 and teamtypekey = 'CW';

update referencevalues  set value_text = 'Visual Impairment and Blindness',description ='Visual Impairment and Blindness' , updatedby ='CDM-5204', 
updatedon =now() where ref_key ='VIDY'  and referencetypeid =97 and teamtypekey = 'CW';