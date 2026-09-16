/*
   Issue Description: CJAMS-58725 Hospitalization End Date
   Category/ Module  : Hospitilization
   Root cause:Case has been closed on 01/14/2025, 03:56 PM Data fix needed to enter the discharge date 2024-03-06 08:00:00 in the Medstar Good Samaritan Hospital record.
                  Client ID : 200957144 (Matthew Robert Speake)
                  Hospital Name : Medstar Good Samaritan Hospital
                  Case Number : 221030017108
   Fix Provided: Data fix has been done to enter the discharge date 2024-03-06 08:00:00 in the Medstar Good Samaritan Hospital record
   Regression Impacts : N/A
   Data/Code fix ticket number: CJAMS-58725
   Is Code fix needed: No
   Reason Why code fix needed: Case is closed and user requested for a data fix               
    */

update personhospitalization 
set hospital_dischargeddate = '2024-03-06 08:00:00',
    hospital_discharged = true,
	updatedby = 'CDM-43949',
	updatedon = now()
where hospitalizationid = 'b61d89c1-342b-4778-bf0b-64f71eae1c0a'
and personid = '55afe3eb-2233-4f1b-8754-16dd601f7d27'
and activeflag = 1;