/*
   Issue Description: CDM-15914
   Category/ Module  :  Approvals
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update placement
set updatedby = 'CDM-15914', updatedon = now(), activeflag = 0
where placementid in (
'a00b26f9-9f03-4733-a567-5bc5b78d4f3d',
'9ce00ec6-1429-4c59-8c53-64ae6a32e74c',
'fa7479f4-5ef6-453e-87f3-02d6f8ded5df',
'5dad0bb0-5db5-49fb-8f11-7501afd46d87',
'b76475e9-7db0-464b-b391-9a0cffda05f9',
'6ce50b32-3f4c-429b-9cb3-35954645c1a8',
'c50860c4-f4e9-40c3-96b5-5db8b5cdfada',
'e2e1b9c9-1741-4741-be91-359d6a10707e',
'1b9a1107-1eb4-4411-91ae-7dcf8c24ed16',
'e65f4612-2777-4737-b52f-76362382a3f5',
'a83fa48b-5bcf-43bd-a566-8afb52e4f749',
'7dbda926-d4df-4794-9e83-e456a1805cc2',
'd71b8d14-9987-434a-933a-84c02dbff56b',
'5454c38c-f2d5-4b0e-acb8-6482852f2e99',
'467ad25a-26d8-499d-92c4-85969faa9b77',
'01272f32-0a9d-4fcb-98a7-f2cd26f3d354',
'302255c6-b98d-4a7c-9113-e573d778b1c4',
'b58da0c8-41bd-4740-b30a-1359d3f6321f',
'2c27f54e-97b9-455d-a77a-718286c97123',
'74dce8d2-839a-442c-b6af-638b0cd36f28');


update livingarrangement 
set updatedby = 'CDM-15914', updatedon = now(), activeflag = 0
where placementid in (
'a00b26f9-9f03-4733-a567-5bc5b78d4f3d',
'9ce00ec6-1429-4c59-8c53-64ae6a32e74c',
'fa7479f4-5ef6-453e-87f3-02d6f8ded5df',
'5dad0bb0-5db5-49fb-8f11-7501afd46d87',
'b76475e9-7db0-464b-b391-9a0cffda05f9',
'6ce50b32-3f4c-429b-9cb3-35954645c1a8',
'c50860c4-f4e9-40c3-96b5-5db8b5cdfada',
'e2e1b9c9-1741-4741-be91-359d6a10707e',
'1b9a1107-1eb4-4411-91ae-7dcf8c24ed16',
'e65f4612-2777-4737-b52f-76362382a3f5',
'a83fa48b-5bcf-43bd-a566-8afb52e4f749',
'7dbda926-d4df-4794-9e83-e456a1805cc2',
'd71b8d14-9987-434a-933a-84c02dbff56b',
'5454c38c-f2d5-4b0e-acb8-6482852f2e99',
'467ad25a-26d8-499d-92c4-85969faa9b77',
'01272f32-0a9d-4fcb-98a7-f2cd26f3d354',
'302255c6-b98d-4a7c-9113-e573d778b1c4',
'b58da0c8-41bd-4740-b30a-1359d3f6321f',
'2c27f54e-97b9-455d-a77a-718286c97123',
'74dce8d2-839a-442c-b6af-638b0cd36f28');


update routing 
set updatedby = 'CDM-15914', updatedon = now(), activeflag = 0
where objectid in (
'a00b26f9-9f03-4733-a567-5bc5b78d4f3d',
'9ce00ec6-1429-4c59-8c53-64ae6a32e74c',
'fa7479f4-5ef6-453e-87f3-02d6f8ded5df',
'5dad0bb0-5db5-49fb-8f11-7501afd46d87',
'b76475e9-7db0-464b-b391-9a0cffda05f9',
'6ce50b32-3f4c-429b-9cb3-35954645c1a8',
'c50860c4-f4e9-40c3-96b5-5db8b5cdfada',
'e2e1b9c9-1741-4741-be91-359d6a10707e',
'1b9a1107-1eb4-4411-91ae-7dcf8c24ed16',
'e65f4612-2777-4737-b52f-76362382a3f5',
'a83fa48b-5bcf-43bd-a566-8afb52e4f749',
'7dbda926-d4df-4794-9e83-e456a1805cc2',
'd71b8d14-9987-434a-933a-84c02dbff56b',
'5454c38c-f2d5-4b0e-acb8-6482852f2e99',
'467ad25a-26d8-499d-92c4-85969faa9b77',
'01272f32-0a9d-4fcb-98a7-f2cd26f3d354',
'302255c6-b98d-4a7c-9113-e573d778b1c4',
'b58da0c8-41bd-4740-b30a-1359d3f6321f',
'2c27f54e-97b9-455d-a77a-718286c97123',
'74dce8d2-839a-442c-b6af-638b0cd36f28') and activeflag = 1;