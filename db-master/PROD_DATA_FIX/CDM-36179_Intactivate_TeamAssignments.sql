/*
   Issue Description: CDM-36179
   Category/ Module  : WorkLoad 
   Root cause: Old Staff still shown on Workload list.
   Fix: Data fix to inactivate the team member records
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

select displayname, email, activeflag, securityusersid from userprofile 
where email in ('carrie.bailey@maryland.gov',
'christie.clouser@maryland.gov',
'dianelle.laney1@maryland.gov',
'erica.fielder@maryland.gov',
'evann.reichenbach@maryland.gov',
'jennifer.crooks@maryland.gov',
'kristen.berkowich@maryland.gov',
'latonya.cotton@maryland.gov',
'lynn.meekins@maryland.gov',
'mary.klesius@maryland.gov',
'nancy.reasin@maryland.gov',
'nicole.eder@maryland.gov',
'nicole.mckim@maryland.gov',
'rebecca.larson@dhr.state.md.us',
'sara.ries@maryland.gov',
'shalini.arora@maryland.gov',
'sue.winborne@maryland.gov')
order by displayname;

/*
CarrieBailey			carrie.bailey@maryland.gov			0	07a30347-9a6b-49a8-8f46-580f68aa667e
ChristieClouser			christie.clouser@maryland.gov		0	123c6461-d61c-4920-bd7f-7b2ad84a0252
DebraMeekins			lynn.meekins@maryland.gov			0	528d5f40-237c-4823-9a1c-db64a1c82b47
DianelleLaney			dianelle.laney1@maryland.gov		1	115531d4-281e-4ecc-972e-6aaad0f42b58
EricaFielder			erica.fielder@maryland.gov			0	db7f58f3-671b-40d4-a6a2-baf9f164204e
EvannReichenbach		evann.reichenbach@maryland.gov		0	03a46983-ce72-48f1-b431-6eef7e3d92fb
JenniferCrooks			jennifer.crooks@maryland.gov		0	8b83e1bf-f8d9-4430-92d5-ce6278bee1f0
KristenBerkowich		kristen.berkowich@maryland.gov		0	f74c6166-4f84-4ea2-bc2d-4c520914bca0
LatonyaCotton			latonya.cotton@maryland.gov			0	ce7f5b14-ceeb-462b-bcf8-c48625454355
MaryKlesius				mary.klesius@maryland.gov			0	5c11c3b6-42e0-496c-8b64-dbc033244b8d
NancyReasin				nancy.reasin@maryland.gov			1	44f3b85d-8fcb-4db5-870e-820563ea85ed
NicoleEder				nicole.eder@maryland.gov			0	d30e7657-d6de-4448-8017-a881176cac69
NicoleMcKim				nicole.mckim@maryland.gov			0	b8b9f8d0-7491-4c61-85c3-1c48d319458c
RebeccaLarson			rebecca.larson@dhr.state.md.us		0	8ad21d5b-2e91-4b04-86f1-72f64101647e
SaraRies				sara.ries@maryland.gov				0	64fd6ba0-7d91-45e8-be49-e18fb0b17525
ShaliniArora			shalini.arora@maryland.gov			0	1cca1c48-6f96-43fd-9ba2-58b28d9f70f9
SueWinborne				sue.winborne@maryland.gov			0	2008863b-b6fe-4596-bdf8-68a7a535e7ee
*/

UPDATE userprofile 
	SET updatedon = now(),
		updatedby = 'CDM-36179',
		activeflag = 0
	WHERE securityusersid IN ('115531d4-281e-4ecc-972e-6aaad0f42b58', '44f3b85d-8fcb-4db5-870e-820563ea85ed')
		and activeflag = 1;
		
UPDATE muser 
	SET updatedon = now(),
		updatedby = 'CDM-36179',
		activeflag = 0
	WHERE securityusersid IN ('115531d4-281e-4ecc-972e-6aaad0f42b58', '44f3b85d-8fcb-4db5-870e-820563ea85ed')
		and activeflag = 1;
		
UPDATE rolemapping
	SET updatedon = now(),
		updatedby = 'CDM-36179',
		activeflag = 0
	WHERE principalid::integer IN (select id from muser 
										WHERE securityusersid IN ('115531d4-281e-4ecc-972e-6aaad0f42b58', '44f3b85d-8fcb-4db5-870e-820563ea85ed'));
																
UPDATE teammember
	SET activeflag = 0,
		updatedby = 'CDM-36179',
		updatedon = now()
	WHERE teammemberid IN (
		select tm.teammemberid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  
				join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
			where up.securityusersid in ('07a30347-9a6b-49a8-8f46-580f68aa667e',
										'123c6461-d61c-4920-bd7f-7b2ad84a0252',
										'528d5f40-237c-4823-9a1c-db64a1c82b47',
										'115531d4-281e-4ecc-972e-6aaad0f42b58',
										'db7f58f3-671b-40d4-a6a2-baf9f164204e',
										'03a46983-ce72-48f1-b431-6eef7e3d92fb',
										'8b83e1bf-f8d9-4430-92d5-ce6278bee1f0',
										'f74c6166-4f84-4ea2-bc2d-4c520914bca0',
										'ce7f5b14-ceeb-462b-bcf8-c48625454355',
										'5c11c3b6-42e0-496c-8b64-dbc033244b8d',
										'44f3b85d-8fcb-4db5-870e-820563ea85ed',
										'd30e7657-d6de-4448-8017-a881176cac69',
										'b8b9f8d0-7491-4c61-85c3-1c48d319458c',
										'8ad21d5b-2e91-4b04-86f1-72f64101647e',
										'64fd6ba0-7d91-45e8-be49-e18fb0b17525',
										'1cca1c48-6f96-43fd-9ba2-58b28d9f70f9',
										'2008863b-b6fe-4596-bdf8-68a7a535e7ee'));
			
UPDATE teammemberassignment
	SET activeflag = 0,
		updatedby = 'CDM-36179',
		updatedon = now()
	WHERE teammemberassignmentid IN (
		select tma.teammemberassignmentid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  and tma.activeflag = 1
			where up.securityusersid in ('07a30347-9a6b-49a8-8f46-580f68aa667e',
										'123c6461-d61c-4920-bd7f-7b2ad84a0252',
										'528d5f40-237c-4823-9a1c-db64a1c82b47',
										'115531d4-281e-4ecc-972e-6aaad0f42b58',
										'db7f58f3-671b-40d4-a6a2-baf9f164204e',
										'03a46983-ce72-48f1-b431-6eef7e3d92fb',
										'8b83e1bf-f8d9-4430-92d5-ce6278bee1f0',
										'f74c6166-4f84-4ea2-bc2d-4c520914bca0',
										'ce7f5b14-ceeb-462b-bcf8-c48625454355',
										'5c11c3b6-42e0-496c-8b64-dbc033244b8d',
										'44f3b85d-8fcb-4db5-870e-820563ea85ed',
										'd30e7657-d6de-4448-8017-a881176cac69',
										'b8b9f8d0-7491-4c61-85c3-1c48d319458c',
										'8ad21d5b-2e91-4b04-86f1-72f64101647e',
										'64fd6ba0-7d91-45e8-be49-e18fb0b17525',
										'1cca1c48-6f96-43fd-9ba2-58b28d9f70f9',
										'2008863b-b6fe-4596-bdf8-68a7a535e7ee'));