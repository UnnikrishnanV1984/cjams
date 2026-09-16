/*
   Issue Description: CDM-20271
   Category/ Module  : approval inbox
   Root cause: user wants remove approved record which is still in pending
   Pull request# for code fix: 5258
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

select *
	from routing 
where routingid  in
	(	'95debe31-0bee-4e4b-a12e-820dd7bfe595',
		'8b0ef9f2-a04a-4f5a-b503-9645a9def6d9',
		'5d725926-6dcd-49af-9052-f1b08a9ef6b5',
		'cc0b2063-b77a-4980-9925-71fd9cad2ae1',
		'75fdf5a1-9782-4d02-9575-fd1b4b00eb87',
		'3be156a6-1a8a-4348-b1d4-e589594a42ff',
		'15c347d5-bb9b-444a-a4a5-a70802ea26e9',
		'6cb26357-3e16-4e03-b0fb-49a344a4a888',
		'259e3796-607f-4075-8e78-6e23c765cf80'
		
	)
	and objectid = '1805990'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid  in
	(	'95debe31-0bee-4e4b-a12e-820dd7bfe595',
		'8b0ef9f2-a04a-4f5a-b503-9645a9def6d9',
		'5d725926-6dcd-49af-9052-f1b08a9ef6b5',
		'cc0b2063-b77a-4980-9925-71fd9cad2ae1',
		'75fdf5a1-9782-4d02-9575-fd1b4b00eb87',
		'3be156a6-1a8a-4348-b1d4-e589594a42ff',
		'15c347d5-bb9b-444a-a4a5-a70802ea26e9',
		'6cb26357-3e16-4e03-b0fb-49a344a4a888',
		'259e3796-607f-4075-8e78-6e23c765cf80'
	)
	and objectid = '1805990'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;