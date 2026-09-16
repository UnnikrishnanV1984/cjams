import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
    name: 'maskZip',
    standalone: false
})
export class MaskZipPipe implements PipeTransform {
	transform(value: string): string {
		if(String(value).length > 5){
			return String(value).slice(0,5)+'-'+String(value).slice(5)
		}
		return String('00000'+value).slice(-5);
	}
}
