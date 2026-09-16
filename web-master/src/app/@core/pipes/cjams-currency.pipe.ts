import { Pipe, PipeTransform } from '@angular/core';
import { CurrencyPipe } from '@angular/common';

@Pipe({
    name: 'cjamsCurrency',
    standalone: false
})
export class CjamsCurrencyPipe implements PipeTransform {
  constructor(private currencyPipe: CurrencyPipe) {}
  transform(value: any, currency: string = '$', symbol: boolean = false): string | null {
    if (value != null){
      return this.currencyPipe.transform(value, currency, symbol);
    }
    const currTransformedValue = this.currencyPipe.transform(0, currency, symbol);
    return  currTransformedValue ? currTransformedValue.split('0.00')[0] : '';
  }
}
