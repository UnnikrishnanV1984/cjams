import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
    name: 'filterNoMatch',
    standalone: false
})
export class FilterNoMatchPipe implements PipeTransform {

  transform(items: any[], searchText: string, serchKey: string): any[] {
    if (!items) {
        return [];
    }
    if (!searchText) {
        return items;
    }
searchText = searchText.toLowerCase();
return items.filter( it => {
      return !it[serchKey].toLowerCase().includes(searchText);
    });
   }

}
