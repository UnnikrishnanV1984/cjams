import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { AuthService } from '../../../../@core/services';
import { DropdownModel } from '../../../../@core/entities/common.entities';
import moment from 'moment';


@Injectable()
export class CourtResolverService {
  [key: string]: any;
  dtformat1 = 'YYYY-MM-DD';
  dtformat2 = 'YYYY/MM/DD';


  constructor(private readonly auth: AuthService) { }

  resolve(): Observable<any>{
    return this.auth.initAuthService('court');     
  }

  getCourt(): Observable<any> {
    return this.auth.initAuthService('court'); 
  }

  filterAndMapItems(event: any, items: any) {
    const filteredItems = items.filter((item: { value: any; }) => event.includes(item.value));
    return filteredItems.map((res: { text: any; }) => res.text);
  }

  selectCourtType(event: any, key: any, typeKey: any, observable$: any, descriptionKey: any) {
      if (event) {
          const courtType = event.map((res: any) => ({ [typeKey]: res }));
          this[key] = courtType;
          observable$.subscribe((items: any) => {
              if (items) {
                  this[descriptionKey] = this.filterAndMapItems(event, items);
              }
          });
      }
    }

    mapToDropdownModel(data: any, textKey: any, valueKey: any) {
      return data.map((res: { [x: string]: any; }) => new DropdownModel({
          text: res[textKey],
          value: res[valueKey]
      }));
    }

    generateTimeList(is24hrs = true) {
      const x = 15; // minutes interval
      const times = []; // time array
      const ap = [' AM', ' PM']; // AM-PM

      // loop to increment the time and push results in array
      for (let tt = 0; tt < 24 * 60; tt+=x) {
          const hh = Math.floor(tt / 60); // getting hours of day in 0-24 format
          const mm = (tt % 60); // getting minutes of the hour in 0-55 format
          if (is24hrs) {
              times.push(`${('0' + (hh % 24)).slice(-2)}:${('0' + mm).slice(-2)}`); // pushing data in array in [00:00 - 12:00 AM/PM format]
          } else {
              times.push(`${('0' + (hh % 12)).slice(-2)}:${('0' + mm).slice(-2)}${ap[Math.floor(hh / 12)]}`); // pushing data in array in [00:00 - 12:00 AM/PM format]
          }
      }
      return times;
    }

    formatDateTime = (date: any, time: any) => `${moment(date).format(this.dtformat2)} ${time}`;

}
