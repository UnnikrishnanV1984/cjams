/*
 * CJAMS-63373 - Wrong person entered
 * Customer Email ID: leslie.valerio1@maryland.gov
 * Focus Area:Persons
 * Description - 251023112073:Worker entered Teressa Lathbury into this case as a person by accident. 
 She is not affiliated with this case. Can you please remove her from this case. 
 * 
 */

-- Delete Program Assignment(s)
update personprogramarea
set activeflag = 0,
	updatedby = 'CJAMS-63373',
	updatedon = now()
where personid = 'f332c3ba-90cd-4e18-9375-9467e66be447'
	and objectid = '46ee94ee-829c-4bed-8395-a6692beca0d6' 
	and activeflag = 1 ;

-- Delete Actor

update actor
set activeflag = 0,
	updatedby = 'CJAMS-63373',
	updatedon = now()
where personid = 'f332c3ba-90cd-4e18-9375-9467e66be447'
	and intakeserviceid = '46ee94ee-829c-4bed-8395-a6692beca0d6'
	and activeflag = 1 ;

-- Delete Person Role(s)

update personrole
set activeflag = 0,
	updatedby = 'CJAMS-63373',
	updatedon = now()
where personid = 'f332c3ba-90cd-4e18-9375-9467e66be447'
	and intakeserviceid = '46ee94ee-829c-4bed-8395-a6692beca0d6'
	and activeflag = 1 ;

-- Delete Person Relationship(s)
update actorrelationship	
set activeflag = 0,
	updatedby = 'CJAMS-63373',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid in ('f332c3ba-90cd-4e18-9375-9467e66be447')
			and intakeserviceid = '46ee94ee-829c-4bed-8395-a6692beca0d6'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CJAMS-63373',
	updatedon = now()
where personid = 'f332c3ba-90cd-4e18-9375-9467e66be447'
	and intakeserviceid = '46ee94ee-829c-4bed-8395-a6692beca0d6'
	and activeflag = 1 ;

-- Delete personroletype

UPDATE cjams.personroletype
SET activeflag=0, 
    updatedby = 'CJAMS-63373',
    updatedon = now()
WHERE personroletypeid = '5de5c3e7-5776-4cd0-b710-d497977f91a3'--personroleid = 'c15525f7-2b49-476c-90f5-7ff129203fee'
    and activeflag = 1 ;