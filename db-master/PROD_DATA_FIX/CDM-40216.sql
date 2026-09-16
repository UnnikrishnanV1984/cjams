/*
Issue Description: CDM-40216
-- Category/ Module: Living Arrangement (Case Management)
-- Root cause: User requested for data delete.
-- Fix Provided: Datafix has been promoted to update the flag.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update placement 
set activeflag =0, updatedby ='CDM-40216', updatedon =now()
where placementid in ('59d742ca-5a25-4a91-81ce-03ff6361280a',
					  'e614c4b5-c874-4d8c-b0f4-106d1fe68d49',
					  '2105f423-7a4d-42df-aabd-bccbad5e0310',
					  '22c5d37d-bbd9-4743-b0c8-2715f73daa14',
					  '241174b7-ad06-466e-8fb4-31903387f2c6')
and activeflag = 1;

update placementrevision 
set activeflag =0, updatedby ='CDM-40216', updatedon =now()
where placementid in ('59d742ca-5a25-4a91-81ce-03ff6361280a',
					  'e614c4b5-c874-4d8c-b0f4-106d1fe68d49',
					  '2105f423-7a4d-42df-aabd-bccbad5e0310',
					  '22c5d37d-bbd9-4743-b0c8-2715f73daa14',
					  '241174b7-ad06-466e-8fb4-31903387f2c6')
and activeflag = 1;

update livingarrangement 
set activeflag =0, updatedby ='CDM-40216', updatedon =now()
where placementid in ('59d742ca-5a25-4a91-81ce-03ff6361280a',
					  'e614c4b5-c874-4d8c-b0f4-106d1fe68d49',
					  '2105f423-7a4d-42df-aabd-bccbad5e0310',
					  '22c5d37d-bbd9-4743-b0c8-2715f73daa14',
					  '241174b7-ad06-466e-8fb4-31903387f2c6')
and activeflag = 1;

update routing 
set activeflag =0, updatedby ='CDM-40216', updatedon =now()
where objectid in ('59d742ca-5a25-4a91-81ce-03ff6361280a',
				   'e614c4b5-c874-4d8c-b0f4-106d1fe68d49',
				   '2105f423-7a4d-42df-aabd-bccbad5e0310',
				   '22c5d37d-bbd9-4743-b0c8-2715f73daa14',
				   '241174b7-ad06-466e-8fb4-31903387f2c6')
and activeflag = 1;