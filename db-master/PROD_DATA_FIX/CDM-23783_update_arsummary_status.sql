/*
-- CDM-23783 
-- Issue Description: User asked to revert AR Summary Status from Approve to Draft
*/

update routing set activeflag = 0, updatedby = 'CDM-23783', updatedon = now()
where routingid = '6fd4b849-7e8d-4bfb-add0-f69015b5654c';