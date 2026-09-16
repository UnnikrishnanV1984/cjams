-- CIDM-7252 - AS Contact Support Ticket Clean Up
/*
AS Contact Support Ticket Clean Up

1) Reject APS old pending tickets identified by the QA/BA team
2) Rejected Tickets where jirarequestno (CJAMS number) is vailable in Jira - Update CJAMS number and Status as Approved
3) Approved Tickets where jirarequestno (CJAMS number) is vailable in Jira - Update CJAMS number 
4) Approved Tickets with NO jirarequestno (CJAMS number) AND NOT in Jira - Update Status as Pending
	
-- Category/ Module: Contact Support Ticket
-- Root cause: To fix Jira tickets data issue
-- Fix Provided: Datafix for Contact Support Ticket Clean Up
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 1) Reject APS old pending tickets identified by the QA/BA team
update defecttracking.supportlog
set jirarequestsent = 'Rejected', 
	updatedby = 'CIDM-7252-1',
	updatedon = now()	
where supportno 
	in (
		'S2023072048732', 'S2023072048731', 'S2023052048182', 'S2023040047894', 'S2023033047723', 'S2023027047532', 'S2023024047448',
		'S2023024047446', 'S2023024047445', 'S2023024047422', 'S2023013047194', 'S2023006047031', 'S2023005046983', 'S2023005046979',
		'S2023005046978', 'S2023005046977', 'S2023005046976', 'S2023004046931', 'S2023003046912', 'S20220364046879', 'S20220362046828',
		'S20220357046798', 'S20220348046542', 'S20220347046501', 'S20220347046484', 'S20220342046377', 'S20220341046334', 'S20220341046333',
		'S20220341046332', 'S20220339046263', 'S20220335046170', 'S20220334046148', 'S20220333046048', 'S20220333046047', 'S20220327045971',
		'S20220325045790', 'S20220325045789', 'S20220325045786', 'S20220322045761', 'S20220322045733', 'S20220319045599', 'S20220294045026',
		'S20220294045020', 'S20220286044797', 'S20220276044465', 'S20220273044427', 'S20220272044396', 'S20220272044394', 'S20220272044392',
		'S20220272044391', 'S20220272044359', 'S20220271044318', 'S20220271044317', 'S20220265044204', 'S20220264044156', 'S20220255043917',
		'S20220250043789', 'S20220243043631', 'S20220242043618', 'S20220242043577', 'S20220235043391', 'S20220230043293', 'S20220223043090',
		'S20220221043038', 'S20220220043003', 'S20220217042960', 'S20220215042904', 'S20220215042894', 'S20220215042891', 'S20220215042888',
		'S20220214042844', 'S20220214042842', 'S20220214042836', 'S20220214042808', 'S20220210042741', 'S20220210042709', 'S20220208042642',
		'S20220203042530', 'S20220201042451', 'S20220201042452', 'S20220200042418', 'S20220199042407', 'S20220199042382', 'S20220195042329',
		'S20220187042104', 'S20220175041840', 'S20220175041826', 'S20220167041679', 'S20220164041541', 'S20220158041422', 'S20220152041297',
		'S20220145041106', 'S20220139040956', 'S20220131040734', 'S20220131040704', 'S20220129040634', 'S20220123040468', 'S20220119040376',
		'S20220117040294', 'S20220104039929', 'S20220103039858', 'S20220102039831', 'S20220101039782', 'S2022095039593', 'S2022095039592',
		'S2022095039591', 'S2022089039434', 'S2022087039357', 'S2022083039267', 'S2022083039265', 'S2022083039256', 'S2022083039238',
		'S2022081039152', 'S2022081039135', 'S2022080039114', 'S2022070038830', 'S2022068038733', 'S2022068038727', 'S2022067038672',
		'S2022067038667', 'S2022061038394', 'S2022061038374', 'S2022061038372', 'S2022059038264', 'S2022054038123', 'S2022054038118',
		'S2022054038098', 'S2022047037906', 'S2022039037681', 'S2022035037554', 'S2022034037542', 'S2022032037430', 'S2022031037349',
		'S2022027037286', 'S2022026037249', 'S2022024037136', 'S2022013036908', 'S2022010036776', 'S2022006036714', 'S2022005036657',
		'S2022003036595', 'S20210357036445', 'S20210357036444', 'S20210356036431', 'S20210355036404', 'S20210355036369', 'S20210347036148',
		'S20210347036134', 'S20210343036030', 'S20210341035932', 'S20210336035761', 'S20210335035730', 'S20210331035613', 'S20210331035612',
		'S20210327035534', 'S20210323035457', 'S20210323035442', 'S20210322035414', 'S20210320035316', 'S20210320035277', 'S20210320035270',
		'S20210319035236', 'S20210314035158', 'S20210313035033', 'S20210312035026', 'S20210308034919', 'S20210306034674', 'S20210306034673',
		'S20210306034672', 'S20210302034569', 'S20210300034464', 'S20210300034428', 'S20210299034399', 'S20210299034380', 'S20210299034367',
		'S20210299034364', 'S20210298034357', 'S20210298034354', 'S20210294034276', 'S20210294034256', 'S20210292034153', 'S20210291034094',
		'S20210288034006', 'S20210287033965', 'S20210285033854', 'S20210285033853', 'S20210285033851', 'S20210285033843', 'S20210285033842',
		'S20210285033841', 'S20210285033840', 'S20210285033839', 'S20210279033729', 'S20210279033695', 'S20210277033578', 'S20210277033577',
		'S20210277033575', 'S20210274033516', 'S20210260033040', 'S20210245032634', 'S20210243032567', 'S20210242032439', 'S20210237032344',
		'S20210237032338', 'S20210236032285', 'S20210230032136', 'S20210230032135', 'S20210230032090', 'S20210225031974', 'S20210224031942',
		'S20210224031941', 'S20210221031823', 'S20210221031821', 'S20210217031708', 'S20210204031290', 'S20210204031288', 'S20210204031283',
		'S20210203031217', 'S20210203031216', 'S20210202031187', 'S20210202031180', 'S20210202031145', 'S20210201031121', 'S20210200031055',
		'S20210200031051', 'S20210200031045', 'S20210196030949', 'S20210195030903', 'S20210194030835', 'S20210194030831', 'S20210194030830',
		'S20210194030829', 'S20210193030751', 'S20210192030713', 'S20210192030712', 'S20210192030711', 'S20210192030710', 'S20210189030626',
		'S20210182030398', 'S20210179030267', 'S20210175030162', 'S20210175030150', 'S20210174030101', 'S20210173030061', 'S20210172030017',
		'S20210167029862', 'S20210165029782', 'S20210165029767', 'S20210162029754', 'S20210161029719', 'S20210158029527', 'S20210158029499',
		'S20210154029413', 'S20210148029198', 'S20210148029181', 'S20210147029162', 'S20210147029161', 'S20210147029158', 'S20210147029156',
		'S20210144029002', 'S20210144028973', 'S20210139028796', 'S20210130028487', 'S20210125028293', 'S20210118027982', 'S20210116027899',
		'S20210113027809', 'S20210112027793', 'S20210112027754', 'S20210111027713', 'S20210111027712', 'S20210110027663', 'S20210110027660',
		'S20210110027641', 'S20210109027593', 'S20210109027585', 'S20210109027575', 'S20210106027533', 'S20210106027519', 'S20210106027515',
		'S20210105027499', 'S20210105027472', 'S20210105027468', 'S20210105027454', 'S20210104027421', 'S20210104027401', 'S20210103027391',
		'S20210103027343', 'S20210103027342', 'S2021099027222', 'S2021096027086', 'S2021095027043', 'S2021093026988', 'S2021092026945',
		'S2021091026854', 'S2021091026838', 'S2021090026829', 'S2021090026814', 'S2021088026666', 'S2021088026657', 'S2021085026607',
		'S2021085026606', 'S2021084026543', 'S2021084026539', 'S2021084026536', 'S2021084026531', 'S2021083026512', 'S2021083026508',
		'S2021081026400', 'S2021078026288', 'S2021077026258', 'S2021077026253', 'S2021076026211', 'S2021075026144', 'S2021075026131',
		'S2021075026117', 'S2021075026107', 'S2021075026097', 'S2021075026094', 'S2021071025983', 'S2021070025899', 'S2021070025861',
		'S2021070025856', 'S2021069025841', 'S2021068025705', 'S2021067025673', 'S2021067025666', 'S2021064025613', 'S2021063025538',
		'S2021062025495', 'S2021062025493', 'S2021062025492', 'S2021062025491', 'S2021062025461', 'S2021062025442', 'S2021061025408',
		'S2021061025382', 'S2021060025326', 'S2021060025320', 'S2021060025308', 'S2021060025306', 'S2021060025275', 'S2021060025273',
		'S2021059025249', 'S2021057025204', 'S2021057025188', 'S2021056025130', 'S2021056025096', 'S2021055025067', 'S2021055025032',
		'S2021054025022', 'S2021054025011', 'S2021054025005', 'S2021054025000', 'S2021053024932', 'S2021053024915', 'S2021050024865',
		'S2021049024791', 'S2021049024754', 'S2021043024451', 'S2021042024421', 'S2021042024414', 'S2021042024388', 'S2021042024383',
		'S2021042024376', 'S2021042024374', 'S2021042024360', 'S2021041024334', 'S2021039024194', 'S2021035024038', 'S2021035024034',
		'S2021035024013', 'S2021035024010', 'S2021035023981', 'S2021034023874', 'S2021033023854', 'S2021033023818', 'S2021033023817',
		'S2021033023782', 'S2021032023744', 'S2021032023717', 'S2021032023710', 'S2021029023683', 'S2021029023675', 'S2021029023621',
		'S2021028023590', 'S2021027023544', 'S2021027023541', 'S2021027023533', 'S2021027023515', 'S2021027023495', 'S2021027023488',
		'S2021025023351', 'S2021025023325', 'S2021025023283', 'S2021025023276', 'S2021025023275', 'S2021019023004', 'S2021015022947',
		'S2021014022910', 'S2021014022903', 'S2021014022901', 'S2021014022892', 'S2021013022778', 'S2021013022777', 'S2021011022695',
		'S2021011022631', 'S2021011022630', 'S2021007022506', 'S2021007022502', 'S2021007022495', 'S2021006022450', 'S2021006022419',
		'S2021005022399', 'S2021005022394', 'S2021005022389', 'S2021005022375', 'S2021004022342', 'S2021004022328', 'S2021004022308',
		'S20200364022181', 'S20200364022169', 'S20200363022114', 'S20200363022110', 'S20200363022103', 'S20200363022102', 'S20200358022070',
		'S20200358022068', 'S20200358022066', 'S20200358022065', 'S20200358022031', 'S20200358022032', 'S20200358022030', 'S20200357022006',
		'S20200356021930', 'S20200356021932', 'S20200356021881', 'S20200352021768', 'S20200352021765', 'S20200352021749', 'S20200352021747',
		'S20200352021720', 'S20200352021719', 'S20200351021678', 'S20200350021561', 'S20200349021488', 'S20200346021433', 'S20200345021356',
		'S20200345021355', 'S20200345021354', 'S20200345021353', 'S20200344021317', 'S20200342021164', 'S20200342021149', 'S20200342021150',
		'S20200342021121', 'S20200335020881', 'S20200335020864', 'S20200329020761', 'S20200328020669', 'S20200324020495', 'S20200323020405',
		'S20200322020359', 'S20200321020267', 'S20200321020265', 'S20200321020264', 'S20200318020177', 'S20200317020022', 'S20200315020007',
		'S20200315019991', 'S20200311019840', 'S20200311019816', 'S20200310019806', 'S20200310019794', 'S20200310019789', 'S20200310019740',
		'S20200310019738', 'S20200310019739', 'S20200310019736', 'S20200307019628', 'S20200304019565', 'S20200304019495', 'S20200302019359',
		'S20200302019326', 'S20200302019301', 'S20200302019281', 'S20200302019270', 'S20200302019244', 'S20200301019212', 'S20200301019192',
		'S20200297018974', 'S20200296018907', 'S20200295018823', 'S20200295018822', 'S20200295018821', 'S20200295018819', 'S20200295018820',
		'S20200295018818', 'S20200295018817', 'S20200295018816', 'S20200295018815', 'S20200295018813', 'S20200295018814', 'S20200295018791',
		'S20200294018745', 'S20200294018669', 'S20200293018660', 'S20200293018659', 'S20200293018636', 'S20200290018549', 'S20200290018524',
		'S20200290018523', 'S20200290018471', 'S20200289018432', 'S20200289018391', 'S20200289018380', 'S20200289018366', 'S20200289018362',
		'S20200289018359', 'S20200289018355', 'S20200288018241', 'S20200287018220', 'S20200283018053', 'S20200283018043', 'S20200282017981',
		'S20200282017926', 'S20200282017875', 'S20200281017837', 'S20200281017793', 'S20200279017600', 'S20200279017570', 'S20220285044745',
		'S20220223043099', 'S20220174041795', 'S20220172041752', 'S20220167041686', 'S20220166041609', 'S20220129040608', 'S20220102039832',
		'S2022063038514', 'S2022056038223', 'S2022046037848', 'S20210350036266', 'S20210335035745', 'S20210313035036', 'S20210312035028',
		'S20210294034238', 'S20210293034202', 'S20210288034025', 'S20210277033559', 'S20210277033558', 'S20210257032913', 'S20210211031520',
		'S20210182030407', 'S20210158029496', 'S20210127028363', 'S20210117027963', 'S20210117027960', 'S20210112027741', 'S20210112027739',
		'S20210112027737', 'S20210106027563', 'S2021097027150', 'S2021083026506', 'S2021063025566', 'S2021060025313', 'S2021057025217',
		'S2021056025119', 'S2021053024897', 'S2021048024600', 'S2021048024575', 'S2021033023872', 'S2021022023196', 'S2021007022488',
		'S2021006022447', 'S20200363022113', 'S20200352021739', 'S20200351021696', 'S20200350021563', 'S20200343021215', 'S20200342021171',
		'S20200339021101', 'S20200336020930', 'S20200335020867', 'S20200330020824', 'S20200323020414', 'S20200318020201', 'S20200310019766',
		'S20200304019557', 'S20200301019176', 'S20200297019024', 'S020029018964', 'S20200296018904', 'S20200293018625', 'S20200293018586',
		'S20200290018488', 'S20200289018405', 'S20200287018188' 
	)
	and activeflag  = 1
	and ( jirarequestsent is null or btrim(jirarequestsent) = '' ) 
	and jirarequestno is null ;	
	
	
-- 2) Rejected Tickets where jirarequestno (CJAMS number) is vailable in Jira - Update CJAMS number and Status as Approved
update defecttracking.supportlog set jirarequestno = 'CJAMS-27912', jirarequestsent = 'Approved', updatedby = 'CIDM-7252-2', updatedon = now() where supportno= 'S2022068038678' and activeflag = 1 and jirarequestsent in ('Rejected', 'Reject') ;
update defecttracking.supportlog set jirarequestno = 'CJAMS-22476', jirarequestsent = 'Approved', updatedby = 'CIDM-7252-2', updatedon = now() where supportno= 'S20210257032918' and activeflag = 1 and jirarequestsent in ('Rejected', 'Reject') ;
update defecttracking.supportlog set jirarequestno = 'CJAMS-15148', jirarequestsent = 'Approved', updatedby = 'CIDM-7252-2', updatedon = now() where supportno= 'S2021054025006' and activeflag = 1 and jirarequestsent in ('Rejected', 'Reject') ;
update defecttracking.supportlog set jirarequestno = 'CJAMS-13482', jirarequestsent = 'Approved', updatedby = 'CIDM-7252-2', updatedon = now() where supportno= 'S2021019023052' and activeflag = 1 and jirarequestsent in ('Rejected', 'Reject') ;
update defecttracking.supportlog set jirarequestno = 'CJAMS-13481', jirarequestsent = 'Approved', updatedby = 'CIDM-7252-2', updatedon = now() where supportno= 'S2021019023048' and activeflag = 1 and jirarequestsent in ('Rejected', 'Reject') ;
update defecttracking.supportlog set jirarequestno = 'CJAMS-12722', jirarequestsent = 'Approved', updatedby = 'CIDM-7252-2', updatedon = now() where supportno= 'S20200365022222' and activeflag = 1 and jirarequestsent in ('Rejected', 'Reject') ;
update defecttracking.supportlog set jirarequestno = 'CJAMS-13130', jirarequestsent = 'Approved', updatedby = 'CIDM-7252-2', updatedon = now() where supportno= 'S20200365022221' and activeflag = 1 and jirarequestsent in ('Rejected', 'Reject') ;
update defecttracking.supportlog set jirarequestno = 'CJAMS-13122', jirarequestsent = 'Approved', updatedby = 'CIDM-7252-2', updatedon = now() where supportno= 'S20200364022134' and activeflag = 1 and jirarequestsent in ('Rejected', 'Reject') ;
update defecttracking.supportlog set jirarequestno = 'CJAMS-12214', jirarequestsent = 'Approved', updatedby = 'CIDM-7252-2', updatedon = now() where supportno= 'S20200350021607' and activeflag = 1 and jirarequestsent in ('Rejected', 'Reject') ;
update defecttracking.supportlog set jirarequestno = 'CJAMS-10083', jirarequestsent = 'Approved', updatedby = 'CIDM-7252-2', updatedon = now() where supportno= 'S20200296018913' and activeflag = 1 and jirarequestsent in ('Rejected', 'Reject') ;
update defecttracking.supportlog set jirarequestno = 'CJAMS-9730', jirarequestsent = 'Approved', updatedby = 'CIDM-7252-2', updatedon = now() where supportno= 'S20200283018004' and activeflag = 1 and jirarequestsent in ('Rejected', 'Reject') ;
update defecttracking.supportlog set jirarequestno = 'CJAMS-22743', jirarequestsent = 'Approved', updatedby = 'CIDM-7252-2', updatedon = now() where supportno= 'S20210266033196' and activeflag = 1 and jirarequestsent in ('Rejected', 'Reject') ;
update defecttracking.supportlog set jirarequestno = 'CJAMS-21107', jirarequestsent = 'Approved', updatedby = 'CIDM-7252-2', updatedon = now() where supportno= 'S20210214031558' and activeflag = 1 and jirarequestsent in ('Rejected', 'Reject') ;
update defecttracking.supportlog set jirarequestno = 'CJAMS-19172', jirarequestsent = 'Approved', updatedby = 'CIDM-7252-2', updatedon = now() where supportno= 'S20210154029421' and activeflag = 1 and jirarequestsent in ('Rejected', 'Reject') ;
update defecttracking.supportlog set jirarequestno = 'CJAMS-20269', jirarequestsent = 'Approved', updatedby = 'CIDM-7252-2', updatedon = now() where supportno= 'S20210189030620' and activeflag = 1 and jirarequestsent in ('Rejected', 'Reject') ;


-- 3) Approved Tickets where jirarequestno (CJAMS number) is vailable in Jira - Update CJAMS number 
update defecttracking.supportlog set jirarequestno = 'CJAMS-43531', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20230143050561' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-28454', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2022083039244' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-17119', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2021099027263' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-17254', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2021089026778' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-16371', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2021083026473' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-16268', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2021081026356' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-16248', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2021078026335' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-15589', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2021063025537' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-15667', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2021063025505' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-15092', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2021053024944' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-14967', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2021049024788' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-14968', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2021049024779' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-14969', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2021049024777' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-12772', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2021004022294' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-12646', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200363022106' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-12279', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200351021674' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-14805', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200349021489' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5800', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200290018513' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5801', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200290018512' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5802', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200290018510' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5803', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200290018479' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5804', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200289018448' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5805', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200289018445' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5658', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200289018436' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5660', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200289018356' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5665', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200289018353' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5666', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200289018347' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5670', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200289018344' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5668', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200288018239' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5518', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200287018215' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5517', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200287018206' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5516', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200287018204' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5515', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200287018151' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5514', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200283018054' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5513', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200283018032' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5512', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200283018008' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5510', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200282017918' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5509', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200282017905' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5508', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200282017891' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5507', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200281017855' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5289', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200281017821' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5288', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200281017818' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5287', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200281017766' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5286', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200280017735' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5285', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200280017662' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5208', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200280017647' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-5125', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200279017565' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-43805', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20230154050800' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-43804', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20230154050799' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-30166', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20220297045031' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-30165', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20220216042949' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-18590', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20210323035458' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-18407', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20210312035012' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-23659', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20210293034203' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-23298', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20210281033793' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-15824', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20210208031391' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-15084', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20210195030871' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-14761', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20210182030389' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-14598', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20210180030304' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-14246', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20210166029821' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-12643', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20210105027492' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-12368', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20210105027459' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-15003', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20210102027309' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-16420', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2021083026522' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-15981', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2021074026027' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-15766', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2021068025748' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-10421', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2021050024840' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-10373', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2021048024651' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-10072', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2021041024305' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-30441', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S2021032023721' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-7878', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200346021411' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-7764', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200344021305' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-8122', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200318020139' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-6810', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200314019915' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CJAMS-10726', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200314019897' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-6691', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200310019783' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-6708', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200310019729' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-6495', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200304019531' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-6509', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200304019485' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-6510', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200304019482' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-6359', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200302019354' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-6327', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200302019352' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-6407', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200302019343' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-6441', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200302019287' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-6211', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200301019210' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-26046', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200294018690' and activeflag = 1 and jirarequestno is null;
update defecttracking.supportlog set jirarequestno = 'CDM-6197', updatedby = 'CIDM-7252-3', updatedon = now() where supportno= 'S20200289018348' and activeflag = 1 and jirarequestno is null;


-- 4) Approved Tickets with NO jirarequestno (CJAMS number) AND NOT in Jira - Update Status as Pending
update defecttracking.supportlog set jirarequestsent = NULL, updatedby = 'CIDM-7252-4', updatedon = now() where supportno= 'S2023039047860' and activeflag = 1 and jirarequestsent in ('Approved', 'Approve') ;
update defecttracking.supportlog set jirarequestsent = NULL, updatedby = 'CIDM-7252-4', updatedon = now() where supportno= 'S2023034047773' and activeflag = 1 and jirarequestsent in ('Approved', 'Approve') ;
update defecttracking.supportlog set jirarequestsent = NULL, updatedby = 'CIDM-7252-4', updatedon = now() where supportno= 'S20220209042698' and activeflag = 1 and jirarequestsent in ('Approved', 'Approve') ;
update defecttracking.supportlog set jirarequestsent = NULL, updatedby = 'CIDM-7252-4', updatedon = now() where supportno= 'S20220166041612' and activeflag = 1 and jirarequestsent in ('Approved', 'Approve') ;
update defecttracking.supportlog set jirarequestsent = NULL, updatedby = 'CIDM-7252-4', updatedon = now() where supportno= 'S20220157041394' and activeflag = 1 and jirarequestsent in ('Approved', 'Approve') ;
update defecttracking.supportlog set jirarequestsent = NULL, updatedby = 'CIDM-7252-4', updatedon = now() where supportno= 'S20220152041295' and activeflag = 1 and jirarequestsent in ('Approved', 'Approve') ;
update defecttracking.supportlog set jirarequestsent = NULL, updatedby = 'CIDM-7252-4', updatedon = now() where supportno= 'S20220152041284' and activeflag = 1 and jirarequestsent in ('Approved', 'Approve') ;
update defecttracking.supportlog set jirarequestsent = NULL, updatedby = 'CIDM-7252-4', updatedon = now() where supportno= 'S20220105039979' and activeflag = 1 and jirarequestsent in ('Approved', 'Approve') ;
update defecttracking.supportlog set jirarequestsent = NULL, updatedby = 'CIDM-7252-4', updatedon = now() where supportno= 'S2022090039469' and activeflag = 1 and jirarequestsent in ('Approved', 'Approve') ;
update defecttracking.supportlog set jirarequestsent = NULL, updatedby = 'CIDM-7252-4', updatedon = now() where supportno= 'S2022038037609' and activeflag = 1 and jirarequestsent in ('Approved', 'Approve') ;
update defecttracking.supportlog set jirarequestsent = NULL, updatedby = 'CIDM-7252-4', updatedon = now() where supportno= 'S20200289018342' and activeflag = 1 and jirarequestsent in ('Approved', 'Approve') ;

