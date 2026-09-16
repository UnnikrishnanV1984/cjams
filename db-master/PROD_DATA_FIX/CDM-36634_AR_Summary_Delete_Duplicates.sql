/* 
   Issue Description: CDM-36634
   Category/ Module  : ARSUMMARY
   Root cause: user wants to delete duplicate records from ARSummary tab
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update investigationallegation 
	set activeflag = 0, updatedon = now(), updatedby = 'CDM-36634' 
	where investigationallegationid in ('4d26a343-b86e-4cda-a8a4-9b4270ff31c1',
									'46e7727d-fba6-462a-8b53-d0df47ede341',
									'bede2dc3-3ef9-4b6e-a564-c2ee73bd3ed8',
									'827a0112-d497-4947-92cd-84f0461065f8',
									'7a0031f6-1d02-4548-9c71-f208bea6a08a',
									'7f4132ab-8ba0-46b1-b861-528d3ec8e910',
									'c7a000f6-e413-4fc6-80f8-bd822408dd55',
									'7c3270c8-5f5c-4245-b033-15e700262ca3') and activeflag = 1;

update investigationallegationmaltreators 
	set activeflag = 0, updatedon = now(), updatedby = 'CDM-36634' 
	where investigationallegationid in ('4d26a343-b86e-4cda-a8a4-9b4270ff31c1',
									'46e7727d-fba6-462a-8b53-d0df47ede341',
									'bede2dc3-3ef9-4b6e-a564-c2ee73bd3ed8',
									'827a0112-d497-4947-92cd-84f0461065f8',
									'7a0031f6-1d02-4548-9c71-f208bea6a08a',
									'7f4132ab-8ba0-46b1-b861-528d3ec8e910',
									'c7a000f6-e413-4fc6-80f8-bd822408dd55',
									'7c3270c8-5f5c-4245-b033-15e700262ca3') and activeflag = 1;


