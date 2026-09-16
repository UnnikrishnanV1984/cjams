-- CDM-14236 - Contact Notes Error
/*
-- Issue Description: 
   Contact Note's addendum description is diplaying the exact copy of original notes. 
   
-- CPS-IR: 2021098099912
-- Progress Note ID: 92053e1b-902c-4967-b675-00fe988a3418 (Inserted ON 06/04/2021)
-- Datafix to update the addendum description.
		   
-- Category/ Module: Contact Note 
-- Root cause: Contact Note Auto save functionality issue. Code fix was done as a prt of last build.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Before
select description, updatedby, updatedon
	from progressnotedetail  
where progressnoteid = '92053e1b-902c-4967-b675-00fe988a3418'
	and progressnotedetailid  = '90b5e47a-5f15-4a9c-ae61-a2d56b78840a'
	and activeflag  = 1 ;

update progressnotedetail 
set description = '<p>During this visit this writer obtained copies of documentation completed by Ms. Patterson''s previous worker. This worker observed King, Jakayla, and Blake all children appeared healthy, well groomed and appropriately dressed. This writer asked if the family required any additional services in which they denied. This writer informed the family that they would be completing the summary required to close their investigation. Ms. Patterson acknowledged.</p>',
	updatedby = 'CDM-14236',
	updatedon = now()
where progressnoteid = '92053e1b-902c-4967-b675-00fe988a3418'
	and progressnotedetailid  = '90b5e47a-5f15-4a9c-ae61-a2d56b78840a'
	and activeflag  = 1 ;

