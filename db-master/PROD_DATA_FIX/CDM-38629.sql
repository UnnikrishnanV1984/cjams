-- CDM-38629 - Need to remove IVe request
/*
-- Issue Description: 
	3282641: trying to close a case but it keeps giving me a notification that a request for IV-E needs to be made. no need of request so we need to revert the request.
   
-- Case ID: 3282641

   
-- Category/ Module: ivecaseclosure
-- Root cause: already IV-E request been sent.
-- Resolution: Removed the IV-E request  by setting active flag to 0.
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from ivecaseclosurereview WHERE objectid='cbff8543-9705-46ac-bf6f-8c85ff2a24a5';
select * from ivecaseclosurereview where ivecaseclosurereviewid='001f2030-c182-4e0d-92cf-05304ebf17de';
select * from routing where objectid='001f2030-c182-4e0d-92cf-05304ebf17de';
select * from routing where routingid='44f71f16-5c30-485e-9ef7-7446fdfacf8f';

UPDATE cjams.routing
SET   activeflag = 0,
	updatedby = 'CDM-38629',
	updatedon = now() WHERE routingid='44f71f16-5c30-485e-9ef7-7446fdfacf8f'
	and activeflag = 1;

	UPDATE cjams.ivecaseclosurereview
SET   activeflag = 0,
	updatedby = 'CDM-38629',
	updatedon = now() WHERE ivecaseclosurereviewid='001f2030-c182-4e0d-92cf-05304ebf17de'
	and activeflag = 1;