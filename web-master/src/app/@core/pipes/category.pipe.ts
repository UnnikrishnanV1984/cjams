import { PipeTransform, Pipe } from '@angular/core';
@Pipe({
    name: 'category',
    standalone: false
})
export class CategoryPipe implements PipeTransform {

    // tslint:disable-next-line:no-shadowed-variable
    transform(list: any[], days: any): any[] {
        if(days === undefined || days === null){
            return [];
        }
        return list.filter((key, index) => index <= days + 1);
    }
}
