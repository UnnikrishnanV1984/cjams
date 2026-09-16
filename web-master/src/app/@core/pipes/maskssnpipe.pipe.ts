import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
    name: 'ssnmaskpipe',
    standalone: false
})
export class MaskPipessn implements PipeTransform {
    transform(value: string, showSsnMask: boolean): string {
        if (value != null || value === '') {
            value = value.replace(/-/g, '');
        }
        if (showSsnMask === true) {
            if (String(value).startsWith('*') && String(value).length < 9) {
                return '';
            }
            if (String(value).match('^[0-9]{9}$')) {
                return '***-**-' + String(value).substr(String(value).length - 4);
            }
        } else {
            if (String(value).startsWith('*')) {
                return '';
            }
            if (String(value).match('^[0-9]{9}$')) {
                return (String(value).substring(0, 3) + '-' + String(value).substring(3, 5) + '-' + String(value).substring(5, 9));
            } else { return ''; }
        }
        return value;
    }
}
