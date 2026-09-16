import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable()
export class Title4eFosterCareService { 

  fosterCareData: any;
  public fileuploadcompleted = new BehaviorSubject<boolean | null>(null);

    uploadCompleted() {
      this.fileuploadcompleted.next(true);
   }

}
