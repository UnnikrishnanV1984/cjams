
update cjams.routing
set activeflag = 0, updatedon = now() 
where routingid in ('c1da4e42-e7f7-48b1-a0f5-f16dc9e29c57', 
'ae3c6194-b55d-4cd6-a7d7-b87105d6e105', 
'692de9cd-72e8-4bc2-98f7-d3323eabc1de',
'31cad1a4-4a6f-4d9e-8c0e-5081c8262862',
'd8e23d94-4fc0-4a47-9304-16fa6237aeb1');

