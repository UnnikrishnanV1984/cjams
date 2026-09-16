/*
 * CDM-35028 - GAP
 * Customer Email ID:amy.smith@maryland.gov
 * Customer Name:amy smith
 * Focus Area:Gap Application
 * Description - 202109207020:Please update the relationship as Maternal grand parent for below guardians
 */

update guardianship 
set primaryrelationshipkey = 'MATRNLGPRNT',
	secondaryrelationshipkey = 'MATRNLGPRNT',
	updatedby = 'CDM-35028',
	updatedon = now()
where gapid in ('c3850def-fd99-4b12-8d7a-a74829c1ee1e')	and activeflag = 1 ;