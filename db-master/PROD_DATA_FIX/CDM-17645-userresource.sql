-- Remove homestudy,recuirter trainee,LDSS permissions
update userresource set activeflag = 0, updatedby = 'CDM-17645', updatedon= now()
where userid = 10055 and 
userresourceid in ('7c716bb9-3cf8-4876-972a-eb7babbf42d8','e065390c-5444-45b7-a878-af085837cb51','a96254ba-cf0f-4cd8-b69a-6f2541b86211', 
'80e13c0f-7991-46aa-9fbb-3dbdafd4cb6d', 'efa330ea-810c-478f-adf2-1f9c1df0acf8', '18b2f6e3-166a-4681-8bf8-5a9f5a4856b1','890b9aa5-6d23-458b-b381-2b8a0f772d1a');