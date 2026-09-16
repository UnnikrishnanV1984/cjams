/*
 * CDM-36824 - Incorrect GAP agreement
 * Component/s: Child Welfare
 * Labels: User-Error 
 * Customer Email ID:natalie.gimperling@maryland.gov
 * Severity:Critical
 * Focus Area:Permanency Plan
 * Description - 3246690:Youth Dominic Gatti 3729757 is now in the guardianship of kinship provider, Shannon Proctor. 
 * Issues around Ms. Proctor being entered in as a provider delayed GAP agreement starting. When attempted to set this up last week, agreement with 
 * incorrect dates is now showing as being sent and approved by a worker and staff in another unit. This worker does not have access to the case and 
 * did not enter this information in or send it for approval. This needs to be deleted and reentered with the correct information to end the removal 
 * and also start the subsidy. 
 * User requested to reset agreement back
 * 
 */

select gapid, activeflag, updatedby, updatedon 
	from gapagreement 
where gapid = '5a0a55eb-49b8-4519-a0f8-82ba7328ba1f'
	and activeflag  = 1 ;
	
update gapagreement
set activeflag = 0,
	updatedby = 'CDM-36824',
	updatedon =  now()	
where gapid = '5a0a55eb-49b8-4519-a0f8-82ba7328ba1f'
	and activeflag  = 1 ;
	
select gapid, activeflag, updatedby, updatedon 
	from gapagreementrevision 
where gapid = '5a0a55eb-49b8-4519-a0f8-82ba7328ba1f'
	and activeflag = 1 ;
		
update gapagreementrevision
set activeflag = 0,
	updatedby = 'CDM-36824',
	updatedon =  now()	
where gapid = '5a0a55eb-49b8-4519-a0f8-82ba7328ba1f'
	and activeflag = 1 ;

select servicerequestnumber, eventcode, activeflag , updatedby, updatedon, * 
	from routing
where eventcode::text = 'GAAR'::text
	and objectid = 'ec8b9802-8731-4c33-8bc0-ad75341acf9b'
	and activeflag = 1	;
	
update routing
set activeflag = 0,
	updatedby = 'CDM-36824',
	updatedon =  now()	
where eventcode::text = 'GAAR'::text
	and objectid = 'ec8b9802-8731-4c33-8bc0-ad75341acf9b'
	and activeflag = 1	;
