/*
 Issue Description: CDM-43233
 Category/ Module: Child Removal
 Root cause: User error, Request to remove the end date and time
 Pull request# for code fix: NA
 Reason why no related code fix: NA
 Status of the code fix if already submitted and expected prod fix date: NO
 Backup before update/ delete: NA
 */

 --ANAKIN LEWIS

update cjams.placement  
set enddatetime = null, 
	endtime = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-43233'
where placementid = 'aa959d93-333f-4340-b373-fd28cbc10942'
	and activeflag  = 1 ;

-- Placement Revision

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-43233'
where placementid = '07b0bfbe-b091-4868-a3bf-b5bb1362ef38' 
	and activeflag =1;

--JABEZ C LEWIS

update cjams.placement  
set enddatetime = null, 
	endtime = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-43233'
where placementid = '9eb09932-d5b3-4e57-a181-edae24ff8a82'
	and activeflag  = 1 ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-43233'
where placementid = '9eb09932-d5b3-4e57-a181-edae24ff8a82' 
	and activeflag =1;

--SOFIA ELAINE LEWIS

update cjams.placement  
set enddatetime = null, 
	endtime = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-43233'
where placementid = '2542ff74-e65d-40e3-bf4c-ade929497db7'
	and activeflag  = 1 ;


update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-43233'
where placementrevisionid = '2542ff74-e65d-40e3-bf4c-ade929497db7'  
	and activeflag =1;

	
