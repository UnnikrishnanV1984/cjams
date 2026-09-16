/*
    Issue no : CDM-15874
    Issue desc : Service case not created and linked for ROH-CPS intake after approved
    Root cause : Unknown. Creating a data fix to link a new service 
*/

select * from cjams.createservicecase('f4e7d4cb-0912-4251-829b-5ac049282a96', null, 1, 'd01eb0ea-2486-4422-87ce-8e036fe78425', 'intake', '');
