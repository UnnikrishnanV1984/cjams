/*
 * CDM-39034 - Education tab
 * Customer Email ID:tracy.adugyamfi@maryland.gov
 * Description - Dashboard:I am unable to end child's current school placement, in order to enter new one. 
 * After filling in the necessary information and hitting update, it just freezes. This has been happening since last week.
 * data fix for this issue. The Enrollment Date should be "05/06/2024" for the client AMERRA R TODD
 * PID: 200154988
 * School Name: Centreville Middle School PEALS Program 
 * Client Name: AMERRA R TODD
 * 
 */


update personeducation set enrollmentdate='2024-05-06 00:00:00',
updatedby='CDM-39034',updatedon=now()
where personeducationid='a40ccdec-e1b2-4716-a6f3-8fa151e3f267' and personid='92866569-e6d6-411c-a2e1-30feb750e31c';
