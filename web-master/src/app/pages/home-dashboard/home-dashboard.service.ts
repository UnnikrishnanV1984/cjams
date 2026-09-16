import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';

@Injectable()
export class HomeDashboardService {
  public assignUserListener$ = new Subject<any>();
  public assignSupervisorListener$ = new Subject<any>();
  public assignCommentListener$ = new Subject<any>();

}
