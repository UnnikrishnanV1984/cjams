/*
   Issue Description: CDM-38293
   Category/ Module  : Application Defect: Incorrect CPS Program Assignment
   Root cause: data fix on the CPS case # 241021874943
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
--Decision Tab

update intakeservicerequestdispositioncode 
set activeflag=1, updatedby ='CDM-38293', updatedon =now()
where intakeservicerequestdispositioncodeid ='1264f661-98c8-4130-8d30-d5170e22b0b3'
and intakeserviceid = '9073dd1f-50f1-4ca0-adf2-e05182bd5955' and activeflag =0;

update intakeservicerequestdispositioncode 
set activeflag=0, updatedby ='CDM-38293', updatedon =now()
where intakeservicerequestdispositioncodeid ='9d28c72f-e77a-47eb-bbe3-bb62c8d17fe4'
and intakeserviceid = '9073dd1f-50f1-4ca0-adf2-e05182bd5955' and activeflag =1;

--program assignment

update personprogramarea 
set activeflag =1 where personprogramid ='6e8268cc-1f98-497d-ab07-645ada742565'
and personid ='03efd2b4-7101-4871-9179-ce4ad32234a6' and activeflag =0;

update personprogramarea 
set activeflag =1 where personprogramid ='52783cee-78b7-4be9-9f86-df2f75928821'
and personid ='c9ce8e97-3641-43a6-a3e6-fdfad4255591' and activeflag =0;