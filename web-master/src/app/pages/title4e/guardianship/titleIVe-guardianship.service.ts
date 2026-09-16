import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable()
export class TitleIVeGuardianshipService {

  fosterCareData: any;
  public fileuploadcompleted = new BehaviorSubject<null |Boolean>(null);

  uploadCompleted() {
    this.fileuploadcompleted.next(true);
  }

}
