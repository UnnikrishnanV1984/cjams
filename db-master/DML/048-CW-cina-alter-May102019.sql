
ALTER TABLE cinapetition 
alter COLUMN ispreviousjuvenilecourt type integer USING ispreviousjuvenilecourt::integer; 

ALTER TABLE cinapetition 
alter COLUMN within12months type integer USING within12months::integer; 

ALTER TABLE cinapetition 
alter COLUMN severechronicdisability type integer USING severechronicdisability::integer; 

ALTER TABLE cinapetition 
alter COLUMN mentalhealthdisorder type integer USING mentalhealthdisorder::integer; 

ALTER TABLE cinapetition 
alter COLUMN bornsubstanceexposed type integer USING bornsubstanceexposed::integer; 

ALTER TABLE cinapetition 
alter COLUMN inadequatehousing type integer USING inadequatehousing::integer; 

ALTER TABLE cinapetition 
alter COLUMN activechildwelfare type integer USING activechildwelfare::integer; 