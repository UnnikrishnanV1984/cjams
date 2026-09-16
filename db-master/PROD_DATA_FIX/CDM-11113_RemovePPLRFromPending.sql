-- CDM-11113 - remove permanency review from pending dashboard

update routing set activeflag =0, updatedby = 'CDM-11113', updatedon =now() where routingid in ('8c53cc1a-a67a-4ae4-a9c2-7ddec6796a8f','37455fcd-569a-48d5-b4f9-0b8b4d8c25e4','cf7ccd5e-cc03-4b42-a76e-ac01faaec918');
