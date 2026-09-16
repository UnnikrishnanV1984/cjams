/*

Please carry out data fix to change the Suspension End Date as 05/23/2026 instead of 06/23/2026 for Client (Robin Hopkins CJAMSPID: 202698963) 

*/


update gapsuspension
set enddate = '2026-05-23 00:00:00',
	updatedby = 'CJAMS-69269',
	updatedon = now()	
where gapsuspensionid  = '1d66c53e-5e6b-4c05-8c94-3fc0468985f8' 
	and activeflag = 1 ;

update gapsuspensionrevision
set enddate = '2026-05-23 00:00:00',
	approvaldate = now(),	
	updatedby = 'CJAMS-69269',
	updatedon = now()
where suspensionid  = '1d66c53e-5e6b-4c05-8c94-3fc0468985f8' ;
	
