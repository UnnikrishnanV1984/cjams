delete from cjams.referencevalues where referencetypeid = 903;

delete from cjams.referencetype where referencetypeid = 903;

INSERT INTO cjams.referencetype(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(903, 'Medical name Suggestion', 'Medical name Suggestion', 1,'CIDM-6692' , now(), 'CIDM-6692', now(), NULL);

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CHLOR', 903, 'Chlorpromazine', 'Chlorpromazine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'CHLOR');

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('THI', 903, 'Thioridazine', 'Thioridazine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'THI');

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('THIOT', 903, 'Thiothixene', 'Thiothixene', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'THIOT');

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PERP', 903, 'Perphenazine', 'Perphenazine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'PERP');

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('TRI', 903, 'Trifluoperazine', 'Trifluoperazine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'TRI');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FLU', 903, 'Fluphenazine', 'Fluphenazine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'FLU');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('HAL', 903, 'Haloperidol', 'Haloperidol', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'HAL');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CLO', 903, 'Clozapine', 'Clozapine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'CLO');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('RIS', 903, 'Risperidone', 'Risperidone', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'RIS');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OLA', 903, 'Olanzapine', 'Olanzapine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'OLA');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('QUE', 903, 'Quetiapine', 'Quetiapine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'QUE');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ZIP', 903, 'Ziprasidone', 'Ziprasidone', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'ZIP');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ARI', 903, 'Aripiprazole', 'Aripiprazole', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'ARI');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PAL', 903, 'Paliperidone', 'Paliperidone', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'PAL');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ASE', 903, 'Asenapine', 'Asenapine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'ASE');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ILO', 903, 'Iloperidone', 'Iloperidone', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'ILO');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('LUR', 903, 'Lurasidone', 'Lurasidone', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'LUR');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('REX', 903, 'Rexpiprazole', 'Rexpiprazole', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'REX');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CAR', 903, 'Cariprazine', 'Cariprazine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'CAR');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('LUM', 903, 'Lumateperone', 'Lumateperone', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'LUM');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('AMI', 903, 'Amitriptyline', 'Amitriptyline', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'AMI');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('AMO', 903, 'Amoxapine', 'Amoxapine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'AMO');

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('BUP', 903, 'Bupropion', 'Bupropion', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'BUP');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CIT', 903, 'Citalopram', 'Citalopram', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'CIT');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('DES', 903, 'Desipramine', 'Desipramine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'DES');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('DESV', 903, 'Desvenlafaxine', 'Desvenlafaxine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'DESV');

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('DOX', 903, 'Doxepin', 'Doxepin', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'DOX');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('DUL', 903, 'Duloxetine', 'Duloxetine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'DUL');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ESCI', 903, 'Escitalopram', 'Escitalopram', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'ESCI');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ESk', 903, 'Esketamine', 'Esketamine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'ESk');

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FLUX', 903, 'Fluoxetine', 'Fluoxetine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'FLUX');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('IMI', 903, 'Imipramine', 'Imipramine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'IMI');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ISO', 903, 'Isocarboxazid', 'Isocarboxazid', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'ISO');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('LEV', 903, 'Levomilnacipran', 'Levomilnacipran', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'LEV');

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MAP', 903, 'Maprotiline', 'Maprotiline', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'MAP');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MIRT', 903, 'Mirtazapine', 'Mirtazapine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'MIRT');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NOR', 903, 'Nortriptyline', 'Nortriptyline', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'NOR');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PAR', 903, 'Paroxetine', 'Paroxetine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'PAR');

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PHE', 903, 'Phenelzine', 'Phenelzine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'PHE');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SEL', 903, 'Selegiline', 'Selegiline', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'SEL');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SER', 903, 'Sertraline', 'Sertraline', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'SER');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('TRA', 903, 'Tranylcypromine', 'Tranylcypromine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'TRA');

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('TRAZ', 903, 'Trazodone', 'Trazodone', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'TRAZ');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('VEN', 903, 'Venlafaxine', 'Venlafaxine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'VEN');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('VIL', 903, 'Vilazodone', 'Vilazodone', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'VIL');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('VOR', 903, 'Vortioxetine', 'Vortioxetine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'VOR');

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('LAM', 903, 'Lamotrigine', 'Lamotrigine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'LAM');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('LIT', 903, 'Lithium', 'Lithium', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'LIT');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('DIV', 903, 'Divalproex/Valproate', 'Divalproex/Valproate', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'DIV');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OXC', 903, 'Oxcarbazine', 'Oxcarbazine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'OXC');

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CARB', 903, 'Carbamazepine', 'Carbamazepine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'CARB');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('AMP', 903, 'Amphetamine', 'Amphetamine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'AMP');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('DEX', 903, 'Dextroamphetamine', 'Dextroamphetamine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'DEX');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('LIS', 903, 'Lisdexamfetamine', 'Lisdexamfetamine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'LIS');

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('METH', 903, 'Methamphetamine', 'Methamphetamine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'METH');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('METHY', 903, 'Methylphenidate', 'Methylphenidate', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'METHY');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ATO', 903, 'Atomoxetine', 'Atomoxetine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'ATO');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CLON', 903, 'Clonidine', 'Clonidine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'CLON');

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('GUAN', 903, 'Guanfacine', 'Guanfacine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'GUAN');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ALP', 903, 'Alprazolam', 'Alprazolam', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'ALP');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CLONA', 903, 'Clonazepam', 'Clonazepam', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'CLONA');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('BUS', 903, 'Buspirone', 'Buspirone', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'BUS');

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('LOR', 903, 'Lorazepam', 'Lorazepam', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'LOR');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('HYD', 903, 'Hydroxyzine', 'Hydroxyzine', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'HYD');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('DIA', 903, 'Diazepam', 'Diazepam', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'DIA');

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OXA', 903, 'Oxazepam', 'Oxazepam', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'OXA');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CHLOR', 903, 'Chlordiazepoxide', 'Chlordiazepoxide', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'CHLOR');


INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CLOR', 903, 'Clorazepate', 'Clorazepate', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'CLOR');

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('TOPI', 903, 'Topiramate', 'Topiramate', NULL, 1,1,'CIDM-6692' , now(),'CIDM-6692' , now(), NULL, NULL, 'TOPI');


