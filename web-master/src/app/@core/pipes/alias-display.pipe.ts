import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
    name: 'aliasDisplay',
    standalone: false
})
export class AliasDisplayPipe implements PipeTransform {

  transform(aliases: any, args?: any): string {
      let alias = "";
      if (!aliases) {
        return alias;}
      if (Array.isArray(aliases)) {
        alias = this.formAliasForArray(aliases); //SonarQube - moved it to seperate function to reduce code complexity

      } else {
        switch (typeof aliases) {
          case 'object':
            alias = (aliases.firstname ? aliases.firstname : '') + ' ' + (aliases.lastname ? aliases.lastname : '');
            break;
          case 'string':
            alias = aliases;
            break;
        }
      }
      //}
      return alias;
  }

  formAliasForArray(aliases: any){
    return aliases.map((item: any) => {
      let result = "";
      const fname = (item.firstname ? item.firstname : '');
      const lname = (item.lastname ? item.lastname : '');
      if (fname == '' && lname == '') {
        return;
      }
      result =  (fname ? fname + ' ' : '') + lname;
      return result;
    })
    .filter((item: any) => {return typeof item != 'undefined'})
    .join(", ");

  }

}
