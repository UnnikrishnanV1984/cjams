/*
 * CDM-33141 - Contact note error
 * Customer Email ID:theresa.kleppinger@maryland.gov
 * Customer Name:Theresa Kleppinger
 * Focus Area:Contacts: Notes
 * Description - 221030017303:Could the contact note be updated to take out a selected "monthly visit"? There was a previous ticket completed by 
 * the caseworker stating that the contact did not save, and that she had entered it on 7/5 while working at the office location. The audit trail 
 * showed that a note was not entered/saved?Contact Date : 07/03/2023Start Time : 3:30 PMEnd Time : 4:30 PMContact Duration : 
 * 1 Hr(s) 0 Min(s)Jul 17, 2023, 10:41:51 AM MikaelaBernard - Foster CareUserJul 17, 2023, 10:48:01 AMMonthly VisitPlease remove "monthly visit" 
 * as worker is required to complete another visit. 
 * Had a call with user ,provide the data fix for the following
 * Case # : 221030017303
 * Contact ID: 10979523
 * Change the contact purpose from 'Monthly Visit' to 'Case Management' 
 */

UPDATE cjams.progressnote
SET updatedby='CDM-33141', updatedon=now(), progressnotereasontypekey='CM' 
WHERE progressnoteid='a9e760e4-bb77-4e90-84ee-0f0e048679f8';