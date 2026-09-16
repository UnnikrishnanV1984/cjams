update referencevalues set displayorder=1 where ref_key='TC' and referencetypeid=158;

update referencevalues set displayorder=2 where ref_key='CD' and referencetypeid=158;

update referencevalues set displayorder=3 where ref_key='PD' and referencetypeid=158;

update referencevalues set displayorder=4 where ref_key='MS' and referencetypeid=158;

update referencevalues set displayorder=5 where ref_key='BS' and referencetypeid=158;

update referencevalues set displayorder=6 where ref_key='KA' and referencetypeid=158;

update referencevalues set displayorder=7 where ref_key='TD' and referencetypeid=158;

update referencevalues set displayorder=8 where ref_key='RR' and referencetypeid=158;

update referencevalues set displayorder=9 where ref_key='BSM' and referencetypeid=158;

update referencevalues set displayorder=10 where ref_key='RS' and referencetypeid=158;

update referencevalues set displayorder=11 where ref_key='TP' and referencetypeid=158;

update referencevalues set displayorder=12 where ref_key='FS' and referencetypeid=158;

update referencevalues set displayorder=13 where ref_key='CC' and referencetypeid=158;

update referencevalues set displayorder=14 where ref_key='FC' and referencetypeid=158;

update referencevalues set displayorder=15 where ref_key='GH' and referencetypeid=158;

update referencevalues set displayorder=16 where ref_key='HC' and referencetypeid=158;

update referencevalues set displayorder=17 where ref_key='GR' and referencetypeid=158;

update referencevalues set displayorder=18 where ref_key='OD' and referencetypeid=158;

update referencevalues set displayorder=19 where ref_key='PG' and referencetypeid=158;

update referencevalues set displayorder=20 where ref_key='SC' and referencetypeid=158;

update referencevalues set displayorder=21 where ref_key='SM' and referencetypeid=158;

update referencevalues set displayorder=22 where ref_key='PSH' and referencetypeid=158;

delete from cjams.referencevalues where ref_key='LWP' and referencetypeid=19;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('LWP', 19, 'Living With Parent', 'Living With Parent', NULL, 1, NULL, NULL, now(), NULL, now(), NULL, NULL, NULL);
