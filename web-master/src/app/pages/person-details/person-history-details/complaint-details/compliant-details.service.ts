import { Injectable } from '@angular/core';
import { GenericService } from '../../../../@core/services';

@Injectable()
export class CompliantDetailsService {

  complaintDetails: any = null;
  constructor(private _service: GenericService<any>) { }

  getComplaintDetails(intakeservicerequestevaluationid: string) {
    const where = {
      intakeservicerequestevaluationid: intakeservicerequestevaluationid,
      foldersearch: null, statussearch: null
    };
    return this._service.getArrayList(
      {
        limit: 1,
        page: 1,
        count: 1,
        where: where,
        method: 'get'
      },
      'intakeservicerequestpetition/clientcentriclegalactionbycomplaint?filter'
    );
  }

}
