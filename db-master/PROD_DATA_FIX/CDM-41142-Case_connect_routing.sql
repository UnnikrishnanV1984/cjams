/*
 * CDM-41142 - Case Connect
 * Customer Email ID:jenet.artis@maryland.gov
 * Focus Area:Case connect.
 * Description - This is a case connect review approval issue. The case is closed and there are no open service cases to connect to anad the case connect button is not available.
                Was told to submit a ticket to request the removal. 
 */


update routing 
set activeflag =0, updatedby ='CDM-41142', updatedon=now()
where routingid ='9674b79c-ee76-4c4d-a5b4-f104163d31bd';