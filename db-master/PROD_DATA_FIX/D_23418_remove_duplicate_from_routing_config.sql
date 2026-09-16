--D-23418

update routingconfig set activeflag=0, updatedon=now() 
where routingconfigid in ('f7611a3d-d3e9-44c3-83f7-f4c016d9f82f', 'f86c851e-d338-4a46-b4a1-b1a0b8c73fad', '8b735a50-6cac-4fcf-9644-88af35c961aa');

update routing set activeflag=0, updatedon=now() 
where servicerequestnumber = '2020013014522' 
and eventcode = 'SCCR' 
and routingstatustypeid = 15 
and activeflag = 1 ;

update routing set activeflag=0, updatedon=now() 
where routingid = 'd0b6cc30-dc16-499e-92d6-7c0a6ad5c76e' ;

update routing set activeflag=0, updatedon=now() 
where servicerequestnumber = '20190310013682' 
and eventcode = 'SCCR' 
and routingstatustypeid = 15 
and activeflag = 1 ;