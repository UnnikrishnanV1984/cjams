--LDSS
UPDATE cjams.teammemberroletype
SET rolelevel=1
WHERE roletypekey='LDSSDD';
UPDATE cjams.teammemberroletype
SET rolelevel=2
WHERE roletypekey='LDSSSP';
UPDATE cjams.teammemberroletype
SET rolelevel=3
WHERE roletypekey='LDSSRW';
UPDATE cjams.teammemberroletype
SET rolelevel=4
WHERE roletypekey='LDSSHSW';
UPDATE cjams.teammemberroletype
SET rolelevel=5
WHERE roletypekey='LDSSRT';
UPDATE cjams.teammemberroletype
SET rolelevel=6
WHERE roletypekey='CCPSP';

--OLM
UPDATE teammemberroletype
SET activeflag = 0
WHERE roletypekey IN (
'OLMIW',
'OLMSP',
'OLMPR',
'OLMSW',
'OLWSP',
'IW'
) AND teamtypekey = 'OLM';


UPDATE cjams.teammemberroletype
SET rolelevel=1
WHERE roletypekey='OLMED';
UPDATE cjams.teammemberroletype
SET rolelevel=2
WHERE roletypekey='OLMDD';
UPDATE cjams.teammemberroletype
SET rolelevel=3
WHERE roletypekey='OLMPM';
UPDATE cjams.teammemberroletype
SET rolelevel=4
WHERE roletypekey='OLMQA';
UPDATE cjams.teammemberroletype
SET rolelevel=5
WHERE roletypekey='OLMLA';
UPDATE cjams.teammemberroletype
SET rolelevel=6
WHERE roletypekey='OLMDSS';

--Contract
UPDATE cjams.teammemberroletype
SET rolelevel=7
WHERE roletypekey='SSACONEXE';
UPDATE cjams.teammemberroletype
SET rolelevel=8
WHERE roletypekey='SSACONPM';
UPDATE cjams.teammemberroletype
SET rolelevel=9
WHERE roletypekey='SSACONADMSUP';
UPDATE cjams.teammemberroletype
SET rolelevel=10
WHERE roletypekey='SSACONADM';
UPDATE cjams.teammemberroletype
SET rolelevel=11
WHERE roletypekey='CCPSO';


--OLMDJS
UPDATE teammemberroletype
SET roletypekey = 'PVRDJSPD'
WHERE roletypekey = 'PVRDJSPD ';

UPDATE teammemberroletype
SET teamtypekey = 'OLMDJS'
WHERE teamtypekey = 'OLM' AND roletypekey IN (
'PVRDJSSD',
'PVRDJSPD',
'PVRDJSQA',
'PVRDJSRS',
'PVRDJSR'
);