/*
   Issue Description: CDM-28085
   Category/ Module : Assessment
   Root cause: Audit log capturing incorrect data
   Status of the code fix if already submitted and expected prod fix date: Veera already did code fix
*/

update assessment_history 
set modifieddata = replace(modifieddata::text 
			, '{"key": "deceasedChildName", "data_type": "text", "new_value": "AIDEN MICHAEL MATHER", "old_value": null, "display_name": "Deceased Child Name"}'
			, '{"key": "deceasedChildName", "data_type": "text", "new_value": null, "old_value": null, "display_name": "Deceased Child Name"}'
	)::json, updatedon = now()
where assessmenthistoryid = 'c38f0873-ab25-462d-aa08-7978376ace8c';