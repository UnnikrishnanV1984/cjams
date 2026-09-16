import { Pipe, Injectable, PipeTransform } from '@angular/core';
@Pipe({
    name: 'intakeFilter',
    pure: false,
    standalone: false
})
@Injectable()

export class IntakeFilterPipe implements PipeTransform {
    transform(value: any[], searchQuery: string): any[] {
      return value.filter((x: any) => x.CLIENTID.startsWith(searchQuery));

    }
  }
