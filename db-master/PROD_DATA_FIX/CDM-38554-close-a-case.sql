-- CDM-38554 - Need to remove IVe request
/*
-- Issue Description: 
	231030061184: trying to close a case but it keeps giving me a notification that a request for IV-E needs to be made. no need of request so we need to revert the request.
   
-- Case ID: 231030061184

   
-- Category/ Module: ivecaseclosure
-- Root cause: already IV-E request been sent.
-- Resolution: Removed the IV-E request  by setting active flag to 0.
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
select * from ivecaseclosurereview where ivecaseclosurereviewid  in ('1c0a5aca-f759-4e34-be06-3be733c91286', '244901c0-5b78-4ee7-b807-0066eca3359b');
select *  from routing where objectid  in ('1c0a5aca-f759-4e34-be06-3be733c91286', '244901c0-5b78-4ee7-b807-0066eca3359b');

UPDATE cjams.routing
SET   activeflag = 0,
	updatedby = 'CDM-38554',
	updatedon = now() WHERE routingid='88ef8592-a1b5-4df4-a34a-82910484314d'
	and activeflag = 1;

	UPDATE cjams.ivecaseclosurereview
SET   activeflag = 0,
	updatedby = 'CDM-38554',
	updatedon = now() WHERE ivecaseclosurereviewid='1c0a5aca-f759-4e34-be06-3be733c91286'
	and activeflag = 1;

UPDATE cjams.routing
SET   activeflag = 0,
	updatedby = 'CDM-38554',
	updatedon = now() WHERE routingid='49bc4f3c-8445-4fcb-b8cc-94e4d865a680'
	and activeflag = 1;

	UPDATE cjams.ivecaseclosurereview
SET   activeflag = 0,
	updatedby = 'CDM-38554',
	updatedon = now() WHERE ivecaseclosurereviewid='244901c0-5b78-4ee7-b807-0066eca3359b'
	and activeflag = 1;