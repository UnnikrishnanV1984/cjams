--S202007906360

update adoptioncase set statustypekey='Closed', activeflag=0, updatedon=now() where adoptioncasenumber='202007301070';

update adoptioncaseactor set personid = null, updatedon = now() where 
adoptioncaseid in (select adoptioncaseid from adoptioncase where adoptioncasenumber='202007301070');

