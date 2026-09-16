import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';

@Injectable()
export class EmploymentProfileService {
  public isShowAddEmployment$ = new Subject<any>();

  isShowAddEmploymentEnabled(value:any) {
    this.isShowAddEmployment$.next(value);
  }  
}
