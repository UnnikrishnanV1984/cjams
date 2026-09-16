import { Pipe, PipeTransform} from '@angular/core';
import { DynamicObject } from '../entities/common.entities';


@Pipe({
    name: 'noDataDisplay',
    standalone: false
})
export class NoDataDisplayPipe implements PipeTransform {
    private dynamicObject: DynamicObject = {};
    transform(value: any, elementId: string, noDataDisplayText: string): any {
        const el = <any>document.querySelector('#' + elementId); // NOSONAR
        if (!el) {
            return value;}
        if ((Array.isArray(value) && !value.length) || (!Array.isArray(value) && !value)) {
            if (!this.dynamicObject[elementId]) {
                const tr = document.createElement('tr');
                const td = document.createElement('td');
                td.colSpan = el.parentNode.querySelectorAll('thead > tr > th').length;
                td.textContent = noDataDisplayText;
                tr.appendChild(td);
                el.appendChild(tr);
                this.dynamicObject[elementId] = true;
            }
        } else {
            for (let element of el.children) {
                if (element.textContent === noDataDisplayText) {
                    el.removeChild(element);
                    this.dynamicObject[elementId] = false;
                }
            }
        }

        return value;
    }
}
