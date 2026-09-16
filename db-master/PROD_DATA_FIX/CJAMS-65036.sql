/*
Issue Description: CJAMS-65036
261023433671:There is a glitch on the investigation finding. 
			There are two investigation findings on the same case. 
			I filled out the first one. The second one needs to be removed.
Category/ Module  :Maltreatment Allegations and Investigation findings
Root cause: There is a duplicate investigation maltreatment record which is resulting two investigation findings
Fix provided: Removed the duplicate maltreatment record
Pull request# for code fix: 
Reason why no related code fix: 
Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
*/

update investigationmaltreatment 
	set activeflag =0,
		updatedby ='CJAMS-65036',
		updatedon =now() 
	where maltreatmentid = 'd436042b-1b99-4e2f-99a3-a8775ac8ba61' 
		and activeflag= 1;