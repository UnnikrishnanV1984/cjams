/*
-- CDM-22720- 

-- Issue Description: 
 Unable to remove In home Program Assignments
  
-- Customer Email ID: ciara.dismuke@maryland.gov

-- Root cause: Data fix to remove In home Program Assignments
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update personprogramarea set activeflag = 0, updatedon = now(), updatedby = 'CDM-22720' where personprogramid in 
(
'baf3d732-bf83-4065-b970-41ce653bd83a',
'68d64e2b-b363-4718-a180-0d48607f8409',
'3c85c72e-7219-4412-aeb2-700c11afff22',
'9eba5c65-6926-4f4c-9387-1b499115dd76',
'3d57b3c4-4db1-4dcd-9c6b-9b96f49179d3',
'82f4b2eb-8343-4d33-a907-2d9894bc0470'
) and activeflag = 1;