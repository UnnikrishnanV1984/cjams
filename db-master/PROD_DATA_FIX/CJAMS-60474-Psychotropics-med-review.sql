/*
   Issue Description: CJAMS-60474
   Category/ Module  : bug
   Root cause:  User Request, The Psychotropic medication request was created in error and needs to be voided.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
--select activeflag ,personid ,* from psychotropicmedications p where psychotropicid in ('84ced5b8-1e2d-4fa9-8c22-434e28771ff8','a61f2558-71eb-4c4f-9c01-76f2693a5731','a8f37cce-be5f-4561-a6a4-d53fd82751f9');
update psychotropicmedications
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-60474'
where psychotropicid in ('84ced5b8-1e2d-4fa9-8c22-434e28771ff8','a61f2558-71eb-4c4f-9c01-76f2693a5731','a8f37cce-be5f-4561-a6a4-d53fd82751f9')
and activeflag =1;

--select * from psycotrophicothercurrentmedication where psychotropicid in ('84ced5b8-1e2d-4fa9-8c22-434e28771ff8','a61f2558-71eb-4c4f-9c01-76f2693a5731','a8f37cce-be5f-4561-a6a4-d53fd82751f9')
--and activeflag =1;
update psycotrophicothercurrentmedication
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-60474'
where psychotropicid in ('84ced5b8-1e2d-4fa9-8c22-434e28771ff8','a61f2558-71eb-4c4f-9c01-76f2693a5731','a8f37cce-be5f-4561-a6a4-d53fd82751f9')
and activeflag =1;

--select * from routing r where objectid in ('84ced5b8-1e2d-4fa9-8c22-434e28771ff8','a61f2558-71eb-4c4f-9c01-76f2693a5731','a8f37cce-be5f-4561-a6a4-d53fd82751f9')
--and activeflag = 1;
update routing
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-60474'
where objectid in ('84ced5b8-1e2d-4fa9-8c22-434e28771ff8','a61f2558-71eb-4c4f-9c01-76f2693a5731','a8f37cce-be5f-4561-a6a4-d53fd82751f9')
and activeflag =1;

--select * from personmedicpshychotropic p where personid = '9bf9b292-0d26-41f7-ad81-ea514c4588dd'
/*
select updatedon ,* from personmedicpshychotropic_history ph where personmedicpshychotropicid  in ('dd4fa360-e041-43fc-a0e9-f7d70a1d8d9a',
'9ab39c9b-70eb-4ca8-8981-98508eeeabf5',
'de6b36a1-4620-4784-93d8-b797af4bfddd',
'625b3899-ef7e-45f5-976a-291d80c1b21f',
'c8bdcadb-bde2-474a-848b-965a54265bb4') order by updatedon desc;
*/

update personmedicpshychotropic_history
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-60474'
where personmedicpshychotropicid  in ('dd4fa360-e041-43fc-a0e9-f7d70a1d8d9a',
'9ab39c9b-70eb-4ca8-8981-98508eeeabf5',
'de6b36a1-4620-4784-93d8-b797af4bfddd',
'625b3899-ef7e-45f5-976a-291d80c1b21f',
'c8bdcadb-bde2-474a-848b-965a54265bb4') and activeflag =1;