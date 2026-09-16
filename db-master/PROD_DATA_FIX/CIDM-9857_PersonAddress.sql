-- CIDM-9857 - Update Person Address
/* Issue Description: Person address 'City Name' to be corrected

-- Category/ Module: Person

-- Root cause: Person address 'City Name' to be corrected, The city name now shows as numbers and invalid charaters which is not a valid data. 
-- Fix Provided: Datafix has been provided to update city names
-- Pull request# N/A

*/

-- Baltimore
update personaddress
set city = 'Baltimore',
updatedby='CIDM-9857',
updatedon=now()
where LOWER(city) like '%*baltimore%'
	or LOWER(city) like '%.baltimore%'
	or LOWER(city) like '%.altimore%'
	or LOWER(city) like '%`altimore%'
    or LOWER(city) like '% baltimore%'
	or LOWER(city) like 'balto.%'
	or LOWER(city) like '%balt.%'
	or lower(city) like '%ba;timore%'
	or lower(city) ~* '[0-9]baltimore|[0-9]altimore|balto[0-9]|baltim[0-9]re|baltim[0-9]ore|baltimor[0-9]e|ba;to,|ba;to'
	or lower(city) ~* '21206|21207|21224'
	or city ~* 'BALTIORE|BATIMORE|BE;TSVO;;E|BALTLIMORE,|BALTLIMORE[0-9]|BLATIMORE,|BLTIMORE|BALTIMIORE|Bal;timore|BA;LTIMORE'
	or city ~* 'BA;TOMORE|BALT0|BALT4MORE|Baltimoe21223|BALTIMOR`'
	or LOWER(city) like 'baltimore%'
	and trim(LOWER(city)) <> 'baltimore';

-- Annandale
update personaddress
set city=trim(city),
updatedby='CIDM-9857',
updatedon=now() 
where city like '% Annandale%';

-- Annapolis
update personaddress
set city = 'Annapolis',
updatedby='',
updatedon=now()
where Lower(city) like '%* annapolis%'
	or Lower(city) like '% annapolis%'
	or Lower(city) like '%*annapolis%'
	or Lower(city) like '%annapolis   `%'
	or Lower(city) like '%annapolis`%'
	or Lower(city) = '21403'
	or city ~* 'Annapolis[0-9]|ANNAP[0-9]LIS'
	or LOWER(city) like '%annapolis,%'
	or LOWER(city) like '%annapolis, MD%';

-- Beltsville
update personaddress
set city='Beltsville',
updatedby='CIDM-9857',
updatedon=now() 
where city like '% Beltsville%';

-- Bel Air
update personaddress 
set city='Bel Air',
updatedby='CIDM-9857',
updatedon=now() 
where lower(city) like '%bel  air%'
or city like '%Bel Air   (germany)%'
or lower(city) = ' belair'
or lower(city) ~* 'bel air,|bel air`';

-- Berwyn Heights
update personaddress 
set city = 'Berwyn Heights',
updatedby='CIDM-9857',
updatedon=now() 
where city like '%BERWYN  HEIGHTS%'
or city like '%Berwyn Hghts.%'
or city like '%BERWYN HGTS.%';

-- Bladensburg
update personaddress 
set city = 'Bladensburg',
updatedby='CIDM-9857',
updatedon=now() 
where lower(city) like '% bladensburg%' and activeflag=1;

-- Blue Ridge Summit
update personaddress 
set city = 'Blue Ridge Summit',
updatedby='CIDM-9857',
updatedon=now() 
where city like '%Blue Ridge  Sm%';

-- Boonsboro
update personaddress 
set city = 'Boonsboro',
updatedby='CIDM-9857',
updatedon=now() 
where lower(city) like '% boonsboro%';

-- Bowie
update personaddress 
set city = 'Bowie',
updatedby='CIDM-9857',
updatedon=now()  
where lower(city) ~* '16010|20715'
or city like'%Bowie/mitchellville%'
or city like '%(from Balti.city)bowie%'
or city like '%(belair)bowie%'
or city ~* 'Belair,bowie|Bowie,';

-- Brookeville
update personaddress 
set city = 'Brookeville',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) like 'brookville,%';

-- BROOKLYN
update personaddress 
set city = 'BROOKLYN',
updatedby='CIDM-9857',
updatedon=now()  
where LOWER(city) like 'brooklyn  %'
	or city like '%BRADDOCK  HEIGHTS%'
	or city = '21225'
	or city like '%Brooklyn Park/baltimore%'
	or city like '%Brooklyn, MD%'
	or city like '%Brooklyn Park,%';

-- Bryans Road
update personaddress 
set city = 'Bryans Road',
updatedby='CIDM-9857',
updatedon=now()  
where LOWER(city) like 'bryans  %'
 	or LOWER(city) like 'bryan  %'
 	or city like '%BRYANS RD.%';

-- Capitol Heights
update personaddress 
set city = 'Capitol Heights',
updatedby='CIDM-9857',
updatedon=now()  
where LOWER(city) like '%boulevard hghts.%'
 	or LOWER(city) like '%bradbury hghts.%'
 	or LOWER(city) like '%, capitol heights%'
 	or LOWER(city) like '%boulevard hts.%'
 	or LOWER(city) like '%bradbury hts.%';

-- Clinton
update personaddress 
set city = 'Clinton',
updatedby='CIDM-9857',
updatedon=now()  
where city = '(from Wash.co.)clinton'
or city = '(howard Co.)clinton'
or city = '20735';

-- College Park
update personaddress 
set city = 'College Park',
updatedby='CIDM-9857',
updatedon=now()  
where city = '20740';

-- Columbia
update personaddress 
set city = 'Columbia',
updatedby='CIDM-9857',
updatedon=now()  
where city like '%, Columbia%';

-- District Heights
update personaddress 
set city = 'District Heights',
updatedby='CIDM-9857',
updatedon=now()   
where city like '%District  Heights%'
or city like '%District Hghts.%'
or city like '%South District Hghts.%';

-- Elkridge
update personaddress
set city='Elkridge',
updatedby='CIDM-9857',
updatedon=now() 
where city like '% Elkridge%';

-- Ellicott City
update personaddress
set city='Ellicott City',
updatedby='CIDM-9857',
updatedon=now() 
where lower(city) like '%ellicott  city%'
or LOWER(city) like 'ellicott,%'
or LOWER(city) like 'ellicott city,%'
or city = 'ELLICOT  CITY' 
or city like '%Ellicott   City%';

-- Fairmont Heights
update personaddress
set city='Fairmont Heights',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) like 'fairmont hght%'
or LOWER(city) like 'fairmount hghts%'
or lower(city) in ('fairmont <heights','fairmount hgts.', 'fairmount  hgtts', 'fairmont hgts.');

-- Frederick
update personaddress
set city='Frederick',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) like 'frederick,%'
or LOWER(city) like ' frederick%'
or lower(city) in (', frederick', 'frederick*');

-- Gaithersburg
update personaddress
set city='Gaithersburg',
updatedby='CIDM-9857',
updatedon=now() 
where city = '20878';

-- Glen Burnie
update personaddress
set city='Glen Burnie',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) in ('\len burnie', 'glen  burnie', 'glen burnie`', 'glen bu;rnie','glen burnie =','glen b urnie','glen urnie', ' glen burnie', 'glen burnie md 21061')
or lower(city) like '%glen-%'
or lower(city) like '%glen burnie,%'
or lower(city) like '%glen burnie  %'
or lower(city) ~* 'glen burnie[0-9]|glen burni[0-9]e';

-- Goshen
update personaddress
set city='Goshen',
updatedby='CIDM-9857',
updatedon=now() 
where city = 'Goshen   N';

-- Great Falls
update personaddress
set city='Great Falls',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) like '%great  falls%';

-- Great Mills
update personaddress
set city='Great Mills',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) like '%great  mills%'
or LOWER(city) like '%great mills road%';

-- Greenbelt
update personaddress
set city='Greenbelt',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) like '% greenbelt%'
or LOWER(city) like 'greenbelt,%'
or lower(city) ~* 'greenbelt[0-9]';

-- Hagerstown
update personaddress
set city='Hagerstown',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) like 'hagerstown,%';

-- Halethorpe
update personaddress
set city='Halethorpe',
updatedby='CIDM-9857',
updatedon=now() 
where city = '21227';

-- Havre De Grace
update personaddress
set city='Havre De Grace',
updatedby='CIDM-9857',
updatedon=now() 
where city in ('21078', 'Havre  de Grace');

-- Hillcrest Heights
update personaddress
set city='Hillcrest Heights',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) in ('201')
or lower(city) like '%hillcrest hghts.%'
or lower(city) like '%hillcrest hght.%'
or lower(city) like '%hillcrest hgts.%'
or lower(city) like '%hillcrest hts.%'
or lower(city) like '%hillcrest heights,%';

-- Hyattsville
update personaddress
set city='Hyattsville',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) in (' hyattsville','hyattsville.','hyattsville`','hyattsville  w', 'hyatt.', 'hyattsville - chillum')
or lower(city) like '%hyattsville,%'
or lower(city) like '%hyattsville/%'
or lower(city) ~* 'hyattsville [0-9]';

-- Indian Head
update personaddress
set city='Indian Head',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) like '% indian head%'
or LOWER(city) like '%indian  head%';

-- Joppatowne
update personaddress
set city='Joppatowne',
updatedby='CIDM-9857',
updatedon=now() 
where city = '21085';

-- Kensington
update personaddress
set city='Kensington',
updatedby='CIDM-9857',
updatedon=now() 
where city = 'Kensingto;n';

-- Lanham
update personaddress
set city='Lanham',
updatedby='CIDM-9857',
updatedon=now() 
where city like '%:lanham%'
or lower(city) ~* '[0-9]lanham';

-- Lansdowne
update personaddress
set city='Lansdowne',
updatedby='CIDM-9857',
updatedon=now() 
where city = '21227';

-- Laurel
update personaddress
set city='Laurel',
updatedby='CIDM-9857',
updatedon=now() 	
where lower(city) like 'laurel,%'
or LOWER(city) like 'laurel md,%'
or LOWER(city) like 'laurel.%'
or LOWER(city) = ' laurel';

-- Lexington Park
update personaddress
set city='Lexington Park',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) in ('lexington  park', 'lexington   park','lexington     park', 'lexington 0park' ,'lexington co.')
or LOWER(city) like 'lexington park%'
and trim(LOWER(city)) <> 'lexington park';

-- Linthicum Heights
update personaddress
set city='Linthicum Heights',
updatedby='CIDM-9857',
updatedon=now() 
where city = '21090';

-- Mount Rainier
update personaddress
set city='Mount Rainier',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) like '%mt.rainier%'
or LOWER(city) like '%mt.rainer%'
or city in ('Mt  Rainer', 'Mt  Rainier','Mt.ranier', '20712');

-- New Carrollton
update personaddress
set city='New Carrollton',
updatedby='CIDM-9857',
updatedon=now() 
where city = '20784';

-- New London
update personaddress
set city='New London',
updatedby='CIDM-9857',
updatedon=now() 
where city = ',new London';

-- Odenton
update personaddress
set city='Odenton',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) ~* '[0-9]denton';

-- Olney
update personaddress
set city='Olney',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) ~* '[0-9]lney';

-- Owings Mills
update personaddress
set city='Owings Mills',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) ~* '[0-9]wings'
or LOWER(city) like 'owings mill,%'
or lower(city) in ('owings milll rd.', 'owings  mills', 'owings  mill','owings   mills','owings      mills');

-- Oxon Hill
update personaddress
set city='Oxon Hill',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) ~* '[0-9]xon hill'
or LOWER(city) ~* 'ox[0-9]n hill'
or LOWER(city) like 'oxon hill,%'
or LOWER(city) like '% oxon hill%'
or lower(city) in ('oxon  hill','oxon   hill','oxon hill;');

-- Pikesville
update personaddress
set city='Pikesville',
updatedby='CIDM-9857',
updatedon=now() 
where city = '21208';

-- Potomac
update personaddress
set city='Potomac',
updatedby='CIDM-9857',
updatedon=now() 
where city = '> Potomac';

-- Prince Frederick
update personaddress
set city='Prince Frederick',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) like 'prince frederick,%'
or lower(city) in ('prince  frederick', 'prince  fredericik');

-- Rockville
update personaddress
set city='Rockville',
updatedby='CIDM-9857',
updatedon=now() 
where city = '20855';

-- Silver Spring
update personaddress
set city='Silver Spring',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) like 'silver spring,%'
or lower(city) in ('silver  spring', 'silver spring`','20906','20910')
or lower(city) ~* 'silver spring[0-9]';

-- St Leonard
update personaddress
set city='St Leonard',
updatedby='CIDM-9857',
updatedon=now() 
where city ='St  Leonard';

-- Towson
update personaddress
set city='Towson',
updatedby='CIDM-9857',
updatedon=now() 
where city ='*towson';

-- Upper Marlboro
update personaddress
set city='Upper Marlboro',
updatedby='CIDM-9857',
updatedon=now() 
where city ='Upper  Marlboro';

-- Washington
update personaddress
set city='Washington',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) in ('washington  d.','washington co.', 'washington 22,','washingtond.c.', ' washington')
or city like '%Washington D.C%'
or lower(city) like '%washington,%'
and lower(city) not like '%fort washington,%';

-- Westminster
update personaddress
set city='Westminster',
updatedby='CIDM-9857',
updatedon=now() 
where city = '21157';

-- Wheaton
update personaddress
set city='Wheaton',
updatedby='CIDM-9857',
updatedon=now() 
where city = '20902';

-- Williamsport
update personaddress
set city='Williamsport',
updatedby='CIDM-9857',
updatedon=now() 
where city = 'Williamsport,';

-- Windsor Mill
update personaddress
set city='Windsor Mill',
updatedby='CIDM-9857',
updatedon=now() 
where LOWER(city) in ('windsor  mill', 'windsor  mills', ' windsor mill')
or lower(city) like '%windsor mill,%';
	
	



	
	








 	

















