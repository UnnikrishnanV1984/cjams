/*
Issue: CJAMS-67091 Removal Tab
Category/Module: Child Removal
Root cause: User requested to mofify the exit type from change in placement to  Permanently Leaving Custody & Care.
Fix provided:  Data fix has been done to  Update the Exit Type from Change in Placement Structure to Permanently Leaving Custody & Care .
Data/Code fix ticket#:  CJAMS-67091
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/




update placement  
set exittypekey = 'PLCC', --	Permanently Leaving Custody & Care
    exitreasontypekey='REUNIF',
	updatedon = now(), 
	updatedby = 'CJAMS-67091'
where placementid = '347b58db-7d43-42a3-8d39-11d524bbd701'
	and activeflag = 1 ;

update placementrevision 
set exittypekey='PLCC',
    exitreasontypkey = 'REUNIF',
    updatedon = now(), 
    updatedby = 'CJAMS-67091' 
where placementid ='347b58db-7d43-42a3-8d39-11d524bbd701' 
and activeflag =1;
