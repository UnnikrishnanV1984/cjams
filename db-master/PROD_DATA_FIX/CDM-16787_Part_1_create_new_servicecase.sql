/*
    Issue no : CDM-16787
    Issue desc : Service case not created and linked for ROH-CPS intake after approved
    Root cause : Unknown. Creating a data fix to link a new service 
*/

select * from cjams.createservicecase('8f96a564-2fcf-4d83-9bca-bdc83ee8296a', null, 1, 'd01eb0ea-2486-4422-87ce-8e036fe78425', 'intake', '');
