-- CDM-13179 - GAP Payment
/*
-- Issue Description: 
	GAP case established for this child on 7/21/20. 
	Provider has not received one payment since that date.
	   
	Case ID: 3301822
	Client ID: 4389513 (ALIYAH KIMBLE) - 6dc8b435-1d97-4f5e-8c49-bb065bc13626
	GAP ID: 1005485 - 07/31/2020 - 07/07/2034 - d75d42e3-c9b9-4e38-8598-69141a30642a

-- Category/ Module: GAP  (Case Management) 
-- Root cause: This GAP Agreement was approved without Rates and so there are no payments.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select gapid, activeflag, updatedby, updatedon 
	from gapagreement 
where gapid = 'd75d42e3-c9b9-4e38-8598-69141a30642a'
	and activeflag  = 1 ;
	
update gapagreement
set activeflag = 0,
	updatedby = 'CDM-13179',
	updatedon =  now()	
where gapid = 'd75d42e3-c9b9-4e38-8598-69141a30642a'
	and activeflag  = 1 ;
	
select gapid, activeflag, updatedby, updatedon
	from gapagreementrevision 
where gapid = 'd75d42e3-c9b9-4e38-8598-69141a30642a'
	and activeflag = 1 ;
		
update gapagreementrevision
set activeflag = 0,
	updatedby = 'CDM-13179',
	updatedon =  now()	
where gapid = 'd75d42e3-c9b9-4e38-8598-69141a30642a'
	and activeflag = 1 ;

select servicerequestnumber, eventcode, activeflag , updatedby, updatedon 
	from routing
where eventcode::text = 'GAAR'::text
	and objectid = '8d581de0-6edc-4427-b3be-38c74690c56f'
	and activeflag = 1	;
	
update routing
set activeflag = 0,
	updatedby = 'CDM-13179',
	updatedon =  now()	
where eventcode::text = 'GAAR'::text
	and objectid = '8d581de0-6edc-4427-b3be-38c74690c56f'
	and activeflag = 1	;
	
