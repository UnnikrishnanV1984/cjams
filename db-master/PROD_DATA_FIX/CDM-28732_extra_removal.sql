/*
   Issue Description: CDM-28732
   Category/ Module  : Extra Removal
   Root cause:3127702:This removal is a duplicate for some reason another removal was started for the 12/5/22 date and it was unnecessary. We need this removal deleted. Thank youWanda Noltwanda.nolt@maryland.gov667-209-7918
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update intakeservreqchildremoval set activeflag =0, updatedon = now(),updatedby ='CDM-28732' where intakeservreqchildremovalid ='a4618a6b-0379-4dba-88d1-c2d12e65c43c';


UPDATE routing SET activeflag =0, updatedon = now(),updatedby ='CDM-28732' WHERE objectid = 'a4618a6b-0379-4dba-88d1-c2d12e65c43c'  AND  activeflag = 1;