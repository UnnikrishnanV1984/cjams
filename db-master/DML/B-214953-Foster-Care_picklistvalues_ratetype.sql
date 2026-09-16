delete from referencetype where referencetypeid in (942);

delete from referencevalues where referencetypeid in (942);

INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(942, 'Rate type', 'ratetype', 1, 'CIDM-10434', now(), 'CIDM-10434', now(), NULL);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('hourlyrate', 942, 'Hourly 1 to 1 Rate', 'Hourly 1 to 1 Rate', 'CW', 1, 1, 'B-221872 ', now(), 'B-221872', now(), NULL, NULL, NULL, '109d5d6e-6927-4f6a-9538-86b3bfd47bb9');

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('dailyrate', 942, 'Daily 1 to 1 Rate', 'Daily 1 to 1 Rate', 'CW', 1, 2, 'B-221872 ', now(), 'B-221872', now(), NULL, NULL, NULL, 'ef1bd5be-fb49-40a2-89a7-cb41d0bc10fd');



update referencevalues set value_text = 'Hotel', description = 'Hotel', updatedby = 'B-214953', updatedon = now() 
where referencevaluesid = '9a3a5e1a-8901-426c-8022-e754eeb59627' and referencetypeid = 760;

update referencevalues set value_text = 'LDSS Office', description = 'LDSS Office', updatedby = 'B-214953', updatedon = now() 
where referencevaluesid = '5463fae1-2080-4d1c-9e7f-f43d586d6bff' and referencetypeid = 760;

update referencevalues set value_text = 'Other', description = 'Other', updatedby = 'B-214953', updatedon = now() 
where referencevaluesid = 'bfcc14d5-9c31-4bdd-9a25-b61bab607ee8' and referencetypeid = 760;


delete from cjams.referencevalues where referencetypeid = 760 and referencevaluesid = '93173ea9-e5bb-447c-8f47-990f0a5db84c';

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('Shelter', 760, 'Shelter', 'Shelter', 'CW', 1, 3, 'B-214953 ', now(), 'B-214953 ', now(), NULL, NULL, null, '93173ea9-e5bb-447c-8f47-990f0a5db84c');