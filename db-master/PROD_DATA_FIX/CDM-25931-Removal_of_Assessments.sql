/*
   Issue Description: CDM-25931
   Category/ Module  : Removal of Assessment which is approved
   Root cause: Remove Ready 21 Exit Survey Assessment request from user profile
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update assessment 
set assessmentstatustypekey = 'Accepted'
where assessmentid = '294e3d67-8777-4aad-aa98-f0e3677bd180';