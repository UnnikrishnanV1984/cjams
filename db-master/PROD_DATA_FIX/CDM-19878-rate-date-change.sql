/*
   Issue Description: CDM-19878
   Category/ Module  : change rate start date
   Root cause: user requeseted to change rate start date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update gapagreementrate g2 set startdate ='2021-12-18 10:00:00',updatedby ='CDM-19878',updatedon =now() where gapagreementrateid ='b117a65e-65e9-4e46-8044-c53712b63aac';
update gapratesrevision set ratestartdate = '2021-12-18 10:00:00',approvaldate =current_date, updatedby = 'CDM-19878', updatedon = now() where gaprateid = 'b117a65e-65e9-4e46-8044-c53712b63aac';
