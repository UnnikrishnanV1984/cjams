/*
Issue Description:CJAMS-64696 :241030409539:I am attempting to correct the living arrangement, since the original date was incorrect. 
					When attempting to edit the rejected living arrangement I am told that I need to first end date it. 
					I am not seeing the option to end date, and this is causing an ability to accurately enter the placement. 
					Placement must be immediately entered for this youth
	
	BA Connected with the user and assisted to Edit/Update and Approve the Living arrangement for "Relative Fictive/Kin Home" dated "01/13/2026". 
	Need data fix to delete the "Rejected" Living Arrangement record dated "01/14/2026"				
					
Root cause: Living arrangement was entered incorrectly and user requested to delete it
Fix provided: Data fix to delete living arrangement record.
Regression Impacts: N/A
Is Code fix Required?: yes
Code fix ticket#: TBD 
Reason why no related code fix: Data issue.
*/


update placement 
	set activeflag = 0,
		updatedby = 'CJAMS-64696',
		updatedon = now()
	where placementid ='28ded4a2-5a6c-483b-995d-163de88f2717' 
		and activeflag = 1;

update livingarrangement 
	set activeflag = 0,
		updatedby = 'CJAMS-64696', 
		updatedon = now()
	where placementid ='28ded4a2-5a6c-483b-995d-163de88f2717' 
		and activeflag = 1;


update placementrevision
	set activeflag = 0,
		updatedby = 'CJAMS-64696', 
		updatedon = now()
	where placementid ='28ded4a2-5a6c-483b-995d-163de88f2717' 
		and activeflag = 1;


UPDATE routing 
	SET activeflag = 0, 
		updatedby = 'CJAMS-64696', 
		updatedon = now() 
	WHERE objectid = '28ded4a2-5a6c-483b-995d-163de88f2717' 
	and activeflag = 1;