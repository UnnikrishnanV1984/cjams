import { PipeTransform, Pipe } from '@angular/core';

@Pipe({
    name: 'keys',
    standalone: false
})
export class KeysPipe implements PipeTransform {
  transform(value: any, args: string[]): any {
    const keys = [];
    // tslint:disable-next-line:forin
    for (const key in value) {
      keys.push(key);
    }
    return keys;
  }
}
