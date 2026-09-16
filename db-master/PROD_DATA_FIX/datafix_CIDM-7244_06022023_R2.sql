-- CIDM-7244 - Contact Support Tickets Clean-up 
/*
To delete Jira tickets craeted by MD Think Team

Category/ Module: Contact Support Ticket

To fix the county Name (ldssregion) values 
1443 	Prince George's
1444 	Queen Anne's
1446 	St. Mary's

*/

-- defecttracking
select ldssregion, application, supportno, jirarequestsent, jirarequestno, updatedby, updatedon  
	from defecttracking.supportlog 
where ldssregion = 'Saint Marys'
	and activeflag = 1 ;
	
update defecttracking.supportlog 
set ldssregion = 'St. Mary''s',
	updatedby = 'CIDM-7244-8', 
	updatedon = now()  
where ldssregion = 'Saint Marys'
	and activeflag = 1 ;
	
select ldssregion, application, supportno, jirarequestsent, jirarequestno, updatedby, updatedon  
	from defecttracking.supportlog
where ldssregion = 'St. Marys'
	and activeflag = 1 ;
	
update defecttracking.supportlog 
set ldssregion = 'St. Mary''s',
	updatedby = 'CIDM-7244-8', 
	updatedon = now()  
where ldssregion = 'St. Marys'
	and activeflag = 1 ;
	
select ldssregion, application, supportno, jirarequestsent, jirarequestno, updatedby, updatedon  
	from defecttracking.supportlog
where ldssregion = 'Prince Georges'
	and activeflag = 1 ;
	
update defecttracking.supportlog 
set ldssregion = 'Prince George''s',
	updatedby = 'CIDM-7244-8', 
	updatedon = now()  	
where ldssregion = 'Prince Georges'
	and activeflag = 1 ;
	
select ldssregion, application, supportno, jirarequestsent, jirarequestno, updatedby, updatedon  
	from defecttracking.supportlog
where ldssregion = 'Queen Annes'
	and activeflag = 1 ;

update defecttracking.supportlog 
set ldssregion = 'Queen Anne''s',
	updatedby = 'CIDM-7244-8', 
	updatedon = now()  	
where ldssregion = 'Queen Annes'
	and activeflag = 1 ;


-- cjams
select ldssregion, application, supportno, jirarequestsent, jirarequestno, updatedby, updatedon  
	from cjams.supportlog 
where ldssregion = 'Saint Marys'
	and activeflag = 1 ;
	
update cjams.supportlog 
set ldssregion = 'St. Mary''s',
	updatedby = 'CIDM-7244-8', 
	updatedon = now()  
where ldssregion = 'Saint Marys'
	and activeflag = 1 ;
	
select ldssregion, application, supportno, jirarequestsent, jirarequestno, updatedby, updatedon  
	from cjams.supportlog
where ldssregion = 'St. Marys'
	and activeflag = 1 ;
	
update cjams.supportlog 
set ldssregion = 'St. Mary''s',
	updatedby = 'CIDM-7244-8', 
	updatedon = now()  
where ldssregion = 'St. Marys'
	and activeflag = 1 ;
	
select ldssregion, application, supportno, jirarequestsent, jirarequestno, updatedby, updatedon  
	from cjams.supportlog
where ldssregion = 'Prince Georges'
	and activeflag = 1 ;
	
update cjams.supportlog 
set ldssregion = 'Prince George''s',
	updatedby = 'CIDM-7244-8', 
	updatedon = now()  	
where ldssregion = 'Prince Georges'
	and activeflag = 1 ;
	
select ldssregion, application, supportno, jirarequestsent, jirarequestno, updatedby, updatedon  
	from cjams.supportlog
where ldssregion = 'Queen Annes'
	and activeflag = 1 ;

update cjams.supportlog 
set ldssregion = 'Queen Anne''s',
	updatedby = 'CIDM-7244-8', 
	updatedon = now()  	
where ldssregion = 'Queen Annes'
	and activeflag = 1 ;
