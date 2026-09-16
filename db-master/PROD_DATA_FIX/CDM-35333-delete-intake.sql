-- CDM-35333 - Can't approve case
/* Issue Description:I231011424146:Not able to process for approval. 

-- Case ID: I231011424146

-- Category/ Module: Decision/Disposition

-- Root cause: user wants to delete intake as its a duplicate
-- Fix Provided:  updated intakedastatus and intakedastaging with active flag to 0. # I231011424146
-- Pull request# N/A
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35333'
where intakenumber = 'I231011424146' and activeflag=1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35333'
where intakenumber = 'I231011424146'and activeflag=1;