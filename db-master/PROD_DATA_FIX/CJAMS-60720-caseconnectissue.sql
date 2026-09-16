/*
Issue Description: Case connect missing for the intake I251013322299 that was created for infromation and referral
Category/Module: Intake / Information and refferal
Root cause: Case connect didn't happen for while intake creation I251013322299 and we were unable to replicate this issue in stage-3.
            We will monitor this kind of issues and open a code fix ticket if needed.
Fix provided: Data fix has been to done to connect the case for this intake.
Data/Code fix ticket#:TBD
Regression Impacts: N/A
Is Code fix Required?: TBD
Code fix ticket#: N/A
Reason why no related code fix: This issue is not replicable in stage-3 while new intake creation and service case is getting created. We will monitor it for future replication.
*/

--intakeserviceid --> 9b65d2c7-ce02-4dec-81d7-97fdae367cde
--servicerequestnumber --> 251023092354
--supervisor id --> 7a8cd264-8789-4016-9bb1-353a27d24785
-- New Servicecaseno created --> 241030402122 

select * from cjams.createservicecase('9b65d2c7-ce02-4dec-81d7-97fdae367cde','',1,'7a8cd264-8789-4016-9bb1-353a27d24785',null,'ASSGN','intake');

