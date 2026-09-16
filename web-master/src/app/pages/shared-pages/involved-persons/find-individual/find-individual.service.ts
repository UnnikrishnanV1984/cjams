import { Injectable } from '@angular/core';
import { GenericService } from '../../../../@core/services';
import { InvolvedPersonSearchResponse } from '../_entities/involvedperson.data.model';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { ObjectUtils } from '../../../../@core/common/initializer';
import moment from 'moment';

@Injectable()
export class FindIndividualService {

  searchCriteria: any;
  constructor(private _involvedPersonSearchService: GenericService<InvolvedPersonSearchResponse>) { }

  searchPerson(pageNumber: number, paginationInfo: PaginationInfo) {
    if (this.searchCriteria.dob) {
      this.searchCriteria.dob = moment(this.searchCriteria.dob).format('MM/DD/YYYY');
    }
    ObjectUtils.removeEmptyProperties(this.searchCriteria);
    return this._involvedPersonSearchService
      .getPagedArrayList(
        {
          limit: paginationInfo.pageSize,
          order: paginationInfo.sortBy,
          page: pageNumber,
          count: paginationInfo.total,
          where: this.searchCriteria,
          method: 'post'
        },
        'globalpersonsearches/getEnhancedPersonSearchData'
      );
  }

  resetSearchCriteria() {
    this.searchCriteria = null;
  }

}
