update routing
set activeflag=0, updatedon =now(), updatedby = 'CDM-12822'
where routingid in ('c24beddf-d136-48fd-99e7-1204cbc7685d','75686371-dc60-47ef-a0c7-59db48405ca2','7241c8d0-cb87-4b3e-8d5e-b368a3c1cbe6','010b11d3-fa3e-4dde-a8b4-2949cd57021f');