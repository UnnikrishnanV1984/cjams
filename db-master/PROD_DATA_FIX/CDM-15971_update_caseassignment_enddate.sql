/*
    CDM-15971
    Issue - Case assignment is not end dated when case is closing
    Fix - Done code fix to handle the case assignment end date updation when case is ending. And done data fix for the same
*/

update caseassignment set enddate = '2016-07-01 00:00:00', updatedby = 'CDM-15971', updatedon = now() where caseassignmentid = 'cd1b137e-8305-40b9-ae2e-752b9c3c0757';