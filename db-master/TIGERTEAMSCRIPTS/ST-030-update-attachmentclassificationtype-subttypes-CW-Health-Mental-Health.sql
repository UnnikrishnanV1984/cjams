--D20306-update subcategory -CW-Health-Mental Health-to match with ECMS value 
update cjams.attachmentclassificationtype set subcategory = 'CW-Health-Mental Health'
,updatedby = 'admin'
,updatedon = Now()
where subcategory = 'CW-Health_Mental Health' 
and typedescription  =  'CW-Health' 
and sequencenumber = '32';
