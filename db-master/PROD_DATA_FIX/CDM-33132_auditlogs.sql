/*
   Issue Description: CDM-33132
   Category/ Module  : 
   Root cause:user need to Remove the OOH  end date and Change the caseworker name
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/

update intakeservreqchildremoval_history set  modifieddata = replace(modifieddata::text, 'Melissa Myers', 'Tracey Hongtong')::jsonb
  where  intakeservreqchildremovalhistoryid='59c33d47-464e-4601-904d-7b6d7b8b1bbe';

update intakeservreqchildremoval_history set  modifieddata = replace(modifieddata::text, 'Chayla Fleming', 'Peg Ryan')::jsonb
  where  intakeservreqchildremovalhistoryid='46d672af-af66-46d2-a94f-80aab8369ba7';

update intakeservreqchildremoval_history set  modifieddata = replace(modifieddata::text, 'Lisa Holden', 'Carrie Vincent')::jsonb
  where  intakeservreqchildremovalhistoryid='cb113033-c7ae-4cf1-8da1-abf3f3c12bc5';

update intakeservreqchildremoval_history set  modifieddata = replace(modifieddata::text, 'Emmett Woodard', 'Tracey Hongtong')::jsonb
  where  intakeservreqchildremovalhistoryid='06843b8d-ec7a-4894-b5d6-f1f02f21b40a';

update intakeservreqchildremoval_history set  modifieddata = replace(modifieddata::text, 'Cheryl Filloramo', 'Tracey Hongtong')::jsonb
  where  intakeservreqchildremovalhistoryid='0c00a28c-7aee-485b-8a72-a588772a7faa';

update intakeservreqchildremoval_history set  modifieddata = replace(modifieddata::text, 'Paula Hogg', 'Amanda Reiblich')::jsonb, updatedby = '8cb570ed-39e2-4a95-8089-76f5951d3c33'
  where  intakeservreqchildremovalhistoryid='6c19dc6b-419e-4917-8576-274a4181dda4';

update intakeservreqchildremoval_history set  modifieddata = replace(modifieddata::text, 'Iris Parreco', 'Peg Ryan')::jsonb
  where  intakeservreqchildremovalhistoryid='6fa4f449-09b2-41d3-a940-fd0dfb954525';

update intakeservreqchildremoval_history set  modifieddata = replace(modifieddata::text, 'Kamaria Clemons', 'Peg Ryan')::jsonb
  where  intakeservreqchildremovalhistoryid='ea3fdf62-b67e-422c-8582-68385ce6f476';

update intakeservreqchildremoval_history set  modifieddata = replace(modifieddata::text, 'Kevin Greene', 'Carrie Vincent')::jsonb
  where  intakeservreqchildremovalhistoryid='80038187-7d2c-4ce8-a19e-3285036ed741';