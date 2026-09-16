/*
-- CDM-26594 - 
-- Issue Description: 
 Delete Duplicate Person from Persons Involved
-- Root cause: Data fix updated the activeflag to 0
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update
    personrole
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26594'
where
    personroleid in (
        '320d6980-bcbf-4613-b97f-7a7e82e7bc0f',
        'ab44b05c-7b72-47d2-9772-b14bbaad61ff',
        '8bffa60f-77ee-462e-a793-1056a8b5150e',
        '42cb8b21-c596-494a-9ebe-5684808a534f',
        'be249b53-aaec-4985-869d-4e78aa16b5fa',
        '6437a602-db14-4225-8cd5-a9e4755724c4',
        '91b962e7-fc69-451a-81e8-69f4ca21d827',
        '12c67def-4de1-4914-9dc5-86f47d7aa1d8'
    );


update
    personrole
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26594'
where
    personroleid = '4cb19347-c8f7-4f4a-8f02-08d1dc6a228d';