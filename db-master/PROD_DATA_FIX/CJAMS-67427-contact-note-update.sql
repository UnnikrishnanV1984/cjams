-- CJAMS-67427 - Contact Notes missing
/*
-- Issue Description: 
   Contact Note's addendum description is missing 
-- Service case: 3209886
-- Progress Note ID: 5bc15d7b-fe57-429a-af2c-a3e9f597a87b (Inserted ON 03/25/2026)
-- Datafix to update the addendum description.	   
-- Category/ Module: Contact Note 
-- Root cause: Missed to update the contact note description
-- Fix Provided: Data fix was provided by updating the description as requested by the user
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE progressnotedetail
SET description = 'David was dressed appropriately upon the worker''s arrival. The purpose of the visit was to discuss concerns regarding David''s lack of communication and his interactions with his foster mother. David has a pattern of leaving the home abruptly without informing his foster mother of his destination, estimated return time, or mode of transportation. The worker addressed this, emphasizing that despite his age, the adults present are responsible for his safety. David was asked to provide his work schedule and communicate his whereabouts (when leaving and returning), including during visitation with his sister. David acknowledged his communication issues, stating he often ignores messages because he doesn''t know how to respond. The worker advised that a simple acknowledgment (thumbs up, "OK," or "I understand") is sufficient. David reported feeling uncomfortable in the current home environment and expressed a desire to move to Independent Living (IL). He was uncomfortable discussing his concerns with his foster mother, stating the placement "is not working out for him." The worker informed David that he will remain in his current placement until he meets the eligibility requirements for IL. The worker clarified that progress in communication and consistency (sticking to his word) are mandatory prerequisites before any IL programs will be explored. David is struggling in school, prioritizing work over academics. The worker stressed the importance of school and informed David that he must attend classes on time for assignments to be unlocked. David stated he is now attending on time and has access, but he has an abundance of missed assignments, leading him to believe catching up will not help him pass. The worker encouraged David to continue trying, attributing the assignment backlog to his prior lack of attendance. David''s attendance and/or employment are required for IL eligibility. David asked questions regarding taxes; the worker referred him to meet with the Department''s Independent Living Coordinator to discuss this as she was unaware of this process. David reported having over $4,000 saved in an account from his job income (received via a work-provided card). He stated his savings goal is for a car and a vacation. The worker applauded David on his effective saving and responsible spending habits. The worker observed David''s room to be cluttered with clothes and dishes. The worker reminded David that maintaining a clean space is a critical aspect of independent living and that he must begin practicing washing his dishes and cleaning his room. David appeared healthy and well. No concerns were reported during this visit.',
	updatedby ='CJAMS-67427',
	updatedon=now()
WHERE progressnoteid = '5bc15d7b-fe57-429a-af2c-a3e9f597a87b' and progressnotedetailid='5f6a974a-742d-4fc2-88d2-eaeee03612c6';
