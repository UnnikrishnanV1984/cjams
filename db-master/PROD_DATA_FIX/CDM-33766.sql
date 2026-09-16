/*
 * CDM-33766 - Ending Program Assignments
 * Customer Email ID:amanda.greenwood3@maryland.gov
 * Customer Name:Amanda Greenwood
 * Focus Area:Persons: Household
 * Description - 3296011:User trying to end the program assignment of CPS/AR which was originally opened in 2022 for all four household members. 
 * However, user unable to close - CJAMS sends a message. CPS AR # 221020233054 from the service case # 3296011. 
 * CPS AR # 221020233054 is not available in CJAMS 
 * 
 */ 

select intakenumber,* from intakeservicerequest where servicerequestnumber = '221020233054';
select programkey, subprogramkey, startdate, enddate, activeflag, * from personprogramarea where entityid = '221020233054';
UPDATE cjams.personprogramarea
SET activeflag=0, updatedby='CDM-33766', updatedon=now() 
WHERE entityid = '221020233054';