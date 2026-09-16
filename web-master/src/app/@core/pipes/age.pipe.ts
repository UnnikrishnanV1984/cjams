import { PipeTransform, Pipe } from '@angular/core';
import moment from 'moment';
@Pipe({
    name: 'ageCal',
    standalone: false
})
export class AgePipe implements PipeTransform {
    ageCalculate!: string;
    // tslint:disable-next-line:no-shadowed-variable
    transform(value: string): string {
        const today = moment();
        const birthdate = moment(value);
        const years = today.diff(birthdate, 'years');
        this.ageCalculate = years + ' yr ';
        this.ageCalculate += today.subtract(years, 'years').diff(birthdate, 'months') + ' mon';
        return this.ageCalculate;
    }
}
