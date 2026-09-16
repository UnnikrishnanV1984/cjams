-- CDM-9909 - Change routing status of the cases in Appeal coordinator dashboard

update routing set activeflag = 1, updatedby = 'CDM-9909', updatedon = now() where  routingid in ('22b3b079-59d7-4882-a460-74f826ca53f9','206ef086-3e3c-40a8-981e-87493c492e10','0db8b781-648e-4f6d-82a6-1094bcdd4bb3');