/*
    Issue Description: CJAMS-69766
  Category/ Module  : Investigation Findings
  Root cause: The case was closed with the investigation finding recorded as Unsubstantiated ('UD').
              User requested the finding be corrected to Indicated ('ID').
  Fix provided: Data fix has been done to update the investigation finding from Unsubstantiated to Indicated
  Is code fix required: N
  Regression impacts : NO 
  Reason why no related code fix: User error
  Status of the code fix if already submitted and expected prod fix date: N/A
*/


update investigationfinding
set investigationfindingtypekey ='ID',
	updatedby ='CJAMS-69766',
	updatedon =now()
where investigationfindingid ='306d1fc3-c663-41d0-90c3-3624b0774fc3' and activeflag =1;
