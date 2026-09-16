-- B-112569 - Contact Notes Enhancement to Add Contact Purpose.
/*
Document Category - Health (CW-Health)

Update Sub Category # 813 as CW-Health-Infants and Toddlers Referral

(old value: CW-Health-Infants & Toddlers Referral)

*/

-- Before 
select sequencenumber, typedescription, subcategory, updatedby , updatedon
	from attachmentclassificationtype
where sequencenumber = 813;

update cjams.attachmentclassificationtype
set subcategory = 'CW-Health-Infants and Toddlers Referral',
	updatedon = now(),
	updatedby = 'B-112569-1'
where sequencenumber = 813;
		
-- After 
select sequencenumber, typedescription, subcategory, updatedby , updatedon
	from attachmentclassificationtype
where sequencenumber = 813;
	
	