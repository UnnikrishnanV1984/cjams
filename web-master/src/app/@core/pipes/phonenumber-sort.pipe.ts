import { PipeTransform, Pipe } from '@angular/core';
@Pipe({
    name: 'phonenumberSort',
    standalone: false
})
export class PhonenumberSortPipe implements PipeTransform {
    private order = ["HM",
        "CL",
        "WK",
        "OTH",
        "BU",
        "FA"];
    // tslint:disable-next-line:no-shadowed-variable
    transform(array: any[]): any[] {
        if (!array) {
            return array;
        }

        array.sort((contact1: any, contact2: any): any => {
            if(contact1.startdate === null && contact2.startdate === null) {return 0}
            if(contact1.startdate === null) {return 1}
            if(contact2.startdate === null) {return -1}
            
            const dateA: any = new Date(contact1.startdate);
            const dateB: any = new Date(contact2.startdate);

            return  dateB - dateA;

        });
        return array.sort((contact1, contact2) => {
            return this.order.indexOf(contact1.personphonetypekey) - this.order.indexOf(contact2.personphonetypekey)
        });
    }
}
