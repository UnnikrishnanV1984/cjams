select * from cjams.createnewuser('brian.lara@cjams.com',	'Brian',	'Lara',		'', 'Brian Lara',		'LDSS', 'CJAMS_LDSS_SUPERVISOR',			'1448', '999101_3', 'LDSS UNIT', 'Baltimore City','3063 E. Biddle Street','Baltimore','21213','','12341','','','BrianLara','','','add','');	
select * from cjams.createnewuser('jhonty@cjams.com',		'Jhonty',	'Rhodes',	'', 'Jhonty Rhodes',	'LDSS',	'CJAMS_LDSS_RESOURCE_WORKER',       '1448', '999101_3', 'LDSS UNIT', 'Baltimore City','3063 E. Biddle Street','Baltimore','21213','','12342','','','JhontyRhodes','','','add','');
select * from cjams.createnewuser('chloet@cjams.com',		'Chloe',	'Tryon',	'', 'Chloe Tryon',		'LDSS',	'CJAMS_LDSS_HOMESTUDY_WORKER',      '1448', '999101_3', 'LDSS UNIT', 'Baltimore City','3063 E. Biddle Street','Baltimore','21213','','12343','','','ChloeTryon',	'','','add','');
select * from cjams.createnewuser('cjohn@cjams.com',		'Chris',	'John',		'', 'Chris John',		'OLM',	'CJAMS_OLM_PGM_MGR',                '1448', '999101_4', 'OLM UNIT',  'Baltimore City','3063 E. Biddle Street','Baltimore','21213','','12344','','','ChrisJohn',	'','','add','');
select * from cjams.createnewuser('frankb@cjams.com',		'Frank',	'Burton',	'', 'Frank Burton',		'OLM',	'CJAMS_OLM_DEP_DIRECTOR',           '1448', '999101_4', 'OLM UNIT',  'Baltimore City','3063 E. Biddle Street','Baltimore','21213','','12345','','','FrankBurton','','','add',''	);
select * from cjams.createnewuser('ian@cjams.com',		'Ian',		'Wiggs',	'', 'Ian Wiggs',		'OLM',	'CJAMS_OLM_PGM_MGR',                '1448', '999101_4', 'OLM UNIT',  'Baltimore City','3063 E. Biddle Street','Baltimore','21213','','12346','','','IanWiggs',	'','','add','');
select * from cjams.createnewuser('jason@cjams.com',		'Jason',	'West',		'', 'Jason West',		'OLM',	'CJAMS_OLM_QLTY_ASSNC',             '1448', '999101_4', 'OLM UNIT',  'Baltimore City','3063 E. Biddle Street','Baltimore','21213','','12347','','','JasonWest','','','add','');	
select * from cjams.createnewuser('jim@cjams.com',		'Jim',		'Butler',	'', 'Jim Butler',		'OLM',	'CJAMS_OLM_EXEC_DIRECTOR',          '1448', '999101_4', 'OLM UNIT',  'Baltimore City','3063 E. Biddle Street','Baltimore','21213','','12348','','','JimButler',	'','','add','');
select * from cjams.createnewuser('mark@cjams.com',		'Mark',		'Newton',	'', 'Mark Newton',		'OLM',	'CJAMS_OLM_PGM_MGR',                '1448', '999101_4', 'OLM UNIT',  'Baltimore City','3063 E. Biddle Street','Baltimore','21213','','12349','','','MarkNewton','','','add','');	
select * from cjams.createnewuser('tlittle@cjams.com',	'Tom',		'Little',	'', 'Tom Little',		'OLM',	'CJAMS_OLM_LICEN_ADMN',             '1448', '999101_4', 'OLM UNIT',  'Baltimore City','3063 E. Biddle Street','Baltimore','21213','','12340','','','TomLittle',	'','','add','');
	
	
	
update teammember 
set teamid = 'a1054a9f-870b-45c4-9df2-9c87cd1cc95e'
where teammemberid in 
(select tm.teammemberid from cjams.userprofile up
join cjams.teammemberassignment tma on tma.securityusersid = up.securityusersid and up.activeflag = 1
join cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1 
where up.email in ( 'brian.lara@cjams.com', 'jhonty@cjams.com', 'chloet@cjams.com'));

update cjams.team 
set countyid = '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b'
where teamid in 
(select t.teamid from cjams.userprofile up
join cjams.teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
join cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
join cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
where up.email in ('tlittle@cjams.com', 'cjohn@cjams.com', 'frankb@cjams.com', 
					'ian@cjams.com', 'jason@cjams.com', 'jim@cjams.com', 'mark@cjams.com'));