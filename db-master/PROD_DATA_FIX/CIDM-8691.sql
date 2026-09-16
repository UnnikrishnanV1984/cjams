/*
 * CIDM-8691 - CJAMS Prod Test users to be made inactive
 * Description - We have 12 active test user profiles in CJAMS
 * securityusersid :
	39c1b326-305b-44d9-873f-263795787296
	6f798278-43e9-4d15-a96f-a0cef33b6d6c
	d733b331-5f06-4997-9928-1601df63444e
	5c7b2ad4-aba6-4877-89d9-be36759c1fc5
	09336f9d-d445-429c-bb91-1e5aac06ffb4
	cc3a5c34-71ee-4058-a27d-31a98bd4cefc
	8a4c1371-cd77-4a73-9c7d-6c842a34ff12
	c4cb360d-f056-4a08-9877-dec78e7cac11
	a7166d79-8429-4729-9ab5-a0afedf9caac
	24e8c790-dee5-4b93-982d-89f6f263fb43
	87a23f22-7c36-48da-9974-7de1294520c3
	a8ea937d-2901-4b65-a1c6-527059e8774c
	d88a9ca2-ce20-4989-9c6f-10f2ee4d641b
	b98e3e4e-f4bb-475d-9848-64ed9938baac
	74a9d347-ba4f-4e05-bb14-d9754484bcc8
	ebf6879e-4e6d-4a7c-a19e-4f94b7beb73d
	4b37f518-bf70-41e1-9aa6-3c5e256fb331
	cd86d0c7-7561-468a-948c-d5a6c8b2f7f4
	2ad6febe-9a80-4bd3-a969-ac5d2aca7777
	f3defda9-0594-428d-8b06-9d98782c6e0c
	acf309bd-47e9-4d23-8a6a-62b8aec324c6
	c6f5b4d6-27a1-4485-a7cd-1ac452114ea6
	7ffce740-1190-4f10-8357-f29c3847b6a4
 */

select * from userprofile where securityusersid in (
	'39c1b326-305b-44d9-873f-263795787296',
	'6f798278-43e9-4d15-a96f-a0cef33b6d6c',
	'd733b331-5f06-4997-9928-1601df63444e',
	'5c7b2ad4-aba6-4877-89d9-be36759c1fc5',
	'09336f9d-d445-429c-bb91-1e5aac06ffb4',
	'cc3a5c34-71ee-4058-a27d-31a98bd4cefc',
	'8a4c1371-cd77-4a73-9c7d-6c842a34ff12',
	'c4cb360d-f056-4a08-9877-dec78e7cac11',
	'a7166d79-8429-4729-9ab5-a0afedf9caac',
	'24e8c790-dee5-4b93-982d-89f6f263fb43',
	'87a23f22-7c36-48da-9974-7de1294520c3',
	'a8ea937d-2901-4b65-a1c6-527059e8774c',
	'd88a9ca2-ce20-4989-9c6f-10f2ee4d641b',
	'b98e3e4e-f4bb-475d-9848-64ed9938baac',
	'74a9d347-ba4f-4e05-bb14-d9754484bcc8',
	'ebf6879e-4e6d-4a7c-a19e-4f94b7beb73d',
	'4b37f518-bf70-41e1-9aa6-3c5e256fb331',
	'cd86d0c7-7561-468a-948c-d5a6c8b2f7f4',
	'2ad6febe-9a80-4bd3-a969-ac5d2aca7777',
	'f3defda9-0594-428d-8b06-9d98782c6e0c',
	'acf309bd-47e9-4d23-8a6a-62b8aec324c6',
	'c6f5b4d6-27a1-4485-a7cd-1ac452114ea6',
	'7ffce740-1190-4f10-8357-f29c3847b6a4'
	) 
		AND activeflag = 1;

UPDATE userprofile
	SET activeflag = 0,
		updatedby = 'CIDM-8691',
		updatedon = now()
	WHERE securityusersid in (
	'39c1b326-305b-44d9-873f-263795787296',
	'6f798278-43e9-4d15-a96f-a0cef33b6d6c',
	'd733b331-5f06-4997-9928-1601df63444e',
	'5c7b2ad4-aba6-4877-89d9-be36759c1fc5',
	'09336f9d-d445-429c-bb91-1e5aac06ffb4',
	'cc3a5c34-71ee-4058-a27d-31a98bd4cefc',
	'8a4c1371-cd77-4a73-9c7d-6c842a34ff12',
	'c4cb360d-f056-4a08-9877-dec78e7cac11',
	'a7166d79-8429-4729-9ab5-a0afedf9caac',
	'24e8c790-dee5-4b93-982d-89f6f263fb43',
	'87a23f22-7c36-48da-9974-7de1294520c3',
	'a8ea937d-2901-4b65-a1c6-527059e8774c',
	'd88a9ca2-ce20-4989-9c6f-10f2ee4d641b',
	'b98e3e4e-f4bb-475d-9848-64ed9938baac',
	'74a9d347-ba4f-4e05-bb14-d9754484bcc8',
	'ebf6879e-4e6d-4a7c-a19e-4f94b7beb73d',
	'4b37f518-bf70-41e1-9aa6-3c5e256fb331',
	'cd86d0c7-7561-468a-948c-d5a6c8b2f7f4',
	'2ad6febe-9a80-4bd3-a969-ac5d2aca7777',
	'f3defda9-0594-428d-8b06-9d98782c6e0c',
	'acf309bd-47e9-4d23-8a6a-62b8aec324c6',
	'c6f5b4d6-27a1-4485-a7cd-1ac452114ea6',
	'7ffce740-1190-4f10-8357-f29c3847b6a4'
	) 
		AND activeflag = 1;
		
select * from muser WHERE securityusersid in (
	'39c1b326-305b-44d9-873f-263795787296',
	'6f798278-43e9-4d15-a96f-a0cef33b6d6c',
	'd733b331-5f06-4997-9928-1601df63444e',
	'5c7b2ad4-aba6-4877-89d9-be36759c1fc5',
	'09336f9d-d445-429c-bb91-1e5aac06ffb4',
	'cc3a5c34-71ee-4058-a27d-31a98bd4cefc',
	'8a4c1371-cd77-4a73-9c7d-6c842a34ff12',
	'c4cb360d-f056-4a08-9877-dec78e7cac11',
	'a7166d79-8429-4729-9ab5-a0afedf9caac',
	'24e8c790-dee5-4b93-982d-89f6f263fb43',
	'87a23f22-7c36-48da-9974-7de1294520c3',
	'a8ea937d-2901-4b65-a1c6-527059e8774c',
	'd88a9ca2-ce20-4989-9c6f-10f2ee4d641b',
	'b98e3e4e-f4bb-475d-9848-64ed9938baac',
	'74a9d347-ba4f-4e05-bb14-d9754484bcc8',
	'ebf6879e-4e6d-4a7c-a19e-4f94b7beb73d',
	'4b37f518-bf70-41e1-9aa6-3c5e256fb331',
	'cd86d0c7-7561-468a-948c-d5a6c8b2f7f4',
	'2ad6febe-9a80-4bd3-a969-ac5d2aca7777',
	'f3defda9-0594-428d-8b06-9d98782c6e0c',
	'acf309bd-47e9-4d23-8a6a-62b8aec324c6',
	'c6f5b4d6-27a1-4485-a7cd-1ac452114ea6',
	'7ffce740-1190-4f10-8357-f29c3847b6a4'
	) 
		AND activeflag = 1; 	
		
UPDATE muser
	SET activeflag = 0,
		updatedby = 'CIDM-8691',
		updatedon = now()
	WHERE securityusersid in (
	'39c1b326-305b-44d9-873f-263795787296',
	'6f798278-43e9-4d15-a96f-a0cef33b6d6c',
	'd733b331-5f06-4997-9928-1601df63444e',
	'5c7b2ad4-aba6-4877-89d9-be36759c1fc5',
	'09336f9d-d445-429c-bb91-1e5aac06ffb4',
	'cc3a5c34-71ee-4058-a27d-31a98bd4cefc',
	'8a4c1371-cd77-4a73-9c7d-6c842a34ff12',
	'c4cb360d-f056-4a08-9877-dec78e7cac11',
	'a7166d79-8429-4729-9ab5-a0afedf9caac',
	'24e8c790-dee5-4b93-982d-89f6f263fb43',
	'87a23f22-7c36-48da-9974-7de1294520c3',
	'a8ea937d-2901-4b65-a1c6-527059e8774c',
	'd88a9ca2-ce20-4989-9c6f-10f2ee4d641b',
	'b98e3e4e-f4bb-475d-9848-64ed9938baac',
	'74a9d347-ba4f-4e05-bb14-d9754484bcc8',
	'ebf6879e-4e6d-4a7c-a19e-4f94b7beb73d',
	'4b37f518-bf70-41e1-9aa6-3c5e256fb331',
	'cd86d0c7-7561-468a-948c-d5a6c8b2f7f4',
	'2ad6febe-9a80-4bd3-a969-ac5d2aca7777',
	'f3defda9-0594-428d-8b06-9d98782c6e0c',
	'acf309bd-47e9-4d23-8a6a-62b8aec324c6',
	'c6f5b4d6-27a1-4485-a7cd-1ac452114ea6',
	'7ffce740-1190-4f10-8357-f29c3847b6a4'
	)
		AND activeflag = 1;
	
select * from rolemapping	WHERE principalid IN (select id::character varying 
							from muser 
							where securityusersid in (
	'39c1b326-305b-44d9-873f-263795787296',
	'6f798278-43e9-4d15-a96f-a0cef33b6d6c',
	'd733b331-5f06-4997-9928-1601df63444e',
	'5c7b2ad4-aba6-4877-89d9-be36759c1fc5',
	'09336f9d-d445-429c-bb91-1e5aac06ffb4',
	'cc3a5c34-71ee-4058-a27d-31a98bd4cefc',
	'8a4c1371-cd77-4a73-9c7d-6c842a34ff12',
	'c4cb360d-f056-4a08-9877-dec78e7cac11',
	'a7166d79-8429-4729-9ab5-a0afedf9caac',
	'24e8c790-dee5-4b93-982d-89f6f263fb43',
	'87a23f22-7c36-48da-9974-7de1294520c3',
	'a8ea937d-2901-4b65-a1c6-527059e8774c',
	'd88a9ca2-ce20-4989-9c6f-10f2ee4d641b',
	'b98e3e4e-f4bb-475d-9848-64ed9938baac',
	'74a9d347-ba4f-4e05-bb14-d9754484bcc8',
	'ebf6879e-4e6d-4a7c-a19e-4f94b7beb73d',
	'4b37f518-bf70-41e1-9aa6-3c5e256fb331',
	'cd86d0c7-7561-468a-948c-d5a6c8b2f7f4',
	'2ad6febe-9a80-4bd3-a969-ac5d2aca7777',
	'f3defda9-0594-428d-8b06-9d98782c6e0c',
	'acf309bd-47e9-4d23-8a6a-62b8aec324c6',
	'c6f5b4d6-27a1-4485-a7cd-1ac452114ea6',
	'7ffce740-1190-4f10-8357-f29c3847b6a4'
	))
		and activeflag = 1;			
		
UPDATE rolemapping 
	SET activeflag = 0, 
		updatedby = 'CIDM-8691', 
		updatedon = now()
	WHERE principalid IN (select id::character varying 
							from muser
							where securityusersid in (
	'39c1b326-305b-44d9-873f-263795787296',
	'6f798278-43e9-4d15-a96f-a0cef33b6d6c',
	'd733b331-5f06-4997-9928-1601df63444e',
	'5c7b2ad4-aba6-4877-89d9-be36759c1fc5',
	'09336f9d-d445-429c-bb91-1e5aac06ffb4',
	'cc3a5c34-71ee-4058-a27d-31a98bd4cefc',
	'8a4c1371-cd77-4a73-9c7d-6c842a34ff12',
	'c4cb360d-f056-4a08-9877-dec78e7cac11',
	'a7166d79-8429-4729-9ab5-a0afedf9caac',
	'24e8c790-dee5-4b93-982d-89f6f263fb43',
	'87a23f22-7c36-48da-9974-7de1294520c3',
	'a8ea937d-2901-4b65-a1c6-527059e8774c',
	'd88a9ca2-ce20-4989-9c6f-10f2ee4d641b',
	'b98e3e4e-f4bb-475d-9848-64ed9938baac',
	'74a9d347-ba4f-4e05-bb14-d9754484bcc8',
	'ebf6879e-4e6d-4a7c-a19e-4f94b7beb73d',
	'4b37f518-bf70-41e1-9aa6-3c5e256fb331',
	'cd86d0c7-7561-468a-948c-d5a6c8b2f7f4',
	'2ad6febe-9a80-4bd3-a969-ac5d2aca7777',
	'f3defda9-0594-428d-8b06-9d98782c6e0c',
	'acf309bd-47e9-4d23-8a6a-62b8aec324c6',
	'c6f5b4d6-27a1-4485-a7cd-1ac452114ea6',
	'7ffce740-1190-4f10-8357-f29c3847b6a4'
	))
		and activeflag = 1;	

select * from teammember WHERE teammemberid IN (
		select tm.teammemberid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  
				join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
				where up.securityusersid in (
	'39c1b326-305b-44d9-873f-263795787296',
	'6f798278-43e9-4d15-a96f-a0cef33b6d6c',
	'd733b331-5f06-4997-9928-1601df63444e',
	'5c7b2ad4-aba6-4877-89d9-be36759c1fc5',
	'09336f9d-d445-429c-bb91-1e5aac06ffb4',
	'cc3a5c34-71ee-4058-a27d-31a98bd4cefc',
	'8a4c1371-cd77-4a73-9c7d-6c842a34ff12',
	'c4cb360d-f056-4a08-9877-dec78e7cac11',
	'a7166d79-8429-4729-9ab5-a0afedf9caac',
	'24e8c790-dee5-4b93-982d-89f6f263fb43',
	'87a23f22-7c36-48da-9974-7de1294520c3',
	'a8ea937d-2901-4b65-a1c6-527059e8774c',
	'd88a9ca2-ce20-4989-9c6f-10f2ee4d641b',
	'b98e3e4e-f4bb-475d-9848-64ed9938baac',
	'74a9d347-ba4f-4e05-bb14-d9754484bcc8',
	'ebf6879e-4e6d-4a7c-a19e-4f94b7beb73d',
	'4b37f518-bf70-41e1-9aa6-3c5e256fb331',
	'cd86d0c7-7561-468a-948c-d5a6c8b2f7f4',
	'2ad6febe-9a80-4bd3-a969-ac5d2aca7777',
	'f3defda9-0594-428d-8b06-9d98782c6e0c',
	'acf309bd-47e9-4d23-8a6a-62b8aec324c6',
	'c6f5b4d6-27a1-4485-a7cd-1ac452114ea6',
	'7ffce740-1190-4f10-8357-f29c3847b6a4'
	))
		and activeflag = 1;
	
UPDATE teammember
	SET activeflag = 0,
		updatedby = 'CIDM-8691',
		updatedon = now()
	WHERE teammemberid IN (
		select tm.teammemberid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  
				join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
				where up.securityusersid in (
	'39c1b326-305b-44d9-873f-263795787296',
	'6f798278-43e9-4d15-a96f-a0cef33b6d6c',
	'd733b331-5f06-4997-9928-1601df63444e',
	'5c7b2ad4-aba6-4877-89d9-be36759c1fc5',
	'09336f9d-d445-429c-bb91-1e5aac06ffb4',
	'cc3a5c34-71ee-4058-a27d-31a98bd4cefc',
	'8a4c1371-cd77-4a73-9c7d-6c842a34ff12',
	'c4cb360d-f056-4a08-9877-dec78e7cac11',
	'a7166d79-8429-4729-9ab5-a0afedf9caac',
	'24e8c790-dee5-4b93-982d-89f6f263fb43',
	'87a23f22-7c36-48da-9974-7de1294520c3',
	'a8ea937d-2901-4b65-a1c6-527059e8774c',
	'd88a9ca2-ce20-4989-9c6f-10f2ee4d641b',
	'b98e3e4e-f4bb-475d-9848-64ed9938baac',
	'74a9d347-ba4f-4e05-bb14-d9754484bcc8',
	'ebf6879e-4e6d-4a7c-a19e-4f94b7beb73d',
	'4b37f518-bf70-41e1-9aa6-3c5e256fb331',
	'cd86d0c7-7561-468a-948c-d5a6c8b2f7f4',
	'2ad6febe-9a80-4bd3-a969-ac5d2aca7777',
	'f3defda9-0594-428d-8b06-9d98782c6e0c',
	'acf309bd-47e9-4d23-8a6a-62b8aec324c6',
	'c6f5b4d6-27a1-4485-a7cd-1ac452114ea6',
	'7ffce740-1190-4f10-8357-f29c3847b6a4'
	))
		and activeflag = 1;

	select * from teammemberassignment
	WHERE teammemberassignmentid IN (
		select tma.teammemberassignmentid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  and tma.activeflag = 1
				where up.securityusersid in (
	'39c1b326-305b-44d9-873f-263795787296',
	'6f798278-43e9-4d15-a96f-a0cef33b6d6c',
	'd733b331-5f06-4997-9928-1601df63444e',
	'5c7b2ad4-aba6-4877-89d9-be36759c1fc5',
	'09336f9d-d445-429c-bb91-1e5aac06ffb4',
	'cc3a5c34-71ee-4058-a27d-31a98bd4cefc',
	'8a4c1371-cd77-4a73-9c7d-6c842a34ff12',
	'c4cb360d-f056-4a08-9877-dec78e7cac11',
	'a7166d79-8429-4729-9ab5-a0afedf9caac',
	'24e8c790-dee5-4b93-982d-89f6f263fb43',
	'87a23f22-7c36-48da-9974-7de1294520c3',
	'a8ea937d-2901-4b65-a1c6-527059e8774c',
	'd88a9ca2-ce20-4989-9c6f-10f2ee4d641b',
	'b98e3e4e-f4bb-475d-9848-64ed9938baac',
	'74a9d347-ba4f-4e05-bb14-d9754484bcc8',
	'ebf6879e-4e6d-4a7c-a19e-4f94b7beb73d',
	'4b37f518-bf70-41e1-9aa6-3c5e256fb331',
	'cd86d0c7-7561-468a-948c-d5a6c8b2f7f4',
	'2ad6febe-9a80-4bd3-a969-ac5d2aca7777',
	'f3defda9-0594-428d-8b06-9d98782c6e0c',
	'acf309bd-47e9-4d23-8a6a-62b8aec324c6',
	'c6f5b4d6-27a1-4485-a7cd-1ac452114ea6',
	'7ffce740-1190-4f10-8357-f29c3847b6a4'
	))
		and activeflag = 1;	
		
UPDATE teammemberassignment
	SET activeflag = 0,
		updatedby = 'CIDM-8691',
		updatedon = now()
	WHERE teammemberassignmentid IN (
		select tma.teammemberassignmentid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  and tma.activeflag = 1
				where up.securityusersid in (
	'39c1b326-305b-44d9-873f-263795787296',
	'6f798278-43e9-4d15-a96f-a0cef33b6d6c',
	'd733b331-5f06-4997-9928-1601df63444e',
	'5c7b2ad4-aba6-4877-89d9-be36759c1fc5',
	'09336f9d-d445-429c-bb91-1e5aac06ffb4',
	'cc3a5c34-71ee-4058-a27d-31a98bd4cefc',
	'8a4c1371-cd77-4a73-9c7d-6c842a34ff12',
	'c4cb360d-f056-4a08-9877-dec78e7cac11',
	'a7166d79-8429-4729-9ab5-a0afedf9caac',
	'24e8c790-dee5-4b93-982d-89f6f263fb43',
	'87a23f22-7c36-48da-9974-7de1294520c3',
	'a8ea937d-2901-4b65-a1c6-527059e8774c',
	'd88a9ca2-ce20-4989-9c6f-10f2ee4d641b',
	'b98e3e4e-f4bb-475d-9848-64ed9938baac',
	'74a9d347-ba4f-4e05-bb14-d9754484bcc8',
	'ebf6879e-4e6d-4a7c-a19e-4f94b7beb73d',
	'4b37f518-bf70-41e1-9aa6-3c5e256fb331',
	'cd86d0c7-7561-468a-948c-d5a6c8b2f7f4',
	'2ad6febe-9a80-4bd3-a969-ac5d2aca7777',
	'f3defda9-0594-428d-8b06-9d98782c6e0c',
	'acf309bd-47e9-4d23-8a6a-62b8aec324c6',
	'c6f5b4d6-27a1-4485-a7cd-1ac452114ea6',
	'7ffce740-1190-4f10-8357-f29c3847b6a4'
	))
		and activeflag = 1;	
