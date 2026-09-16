import _ from 'lodash'; // # sorry use lodash for this example (another dependency ...)
import { Component, Input, EventEmitter, Output } from '@angular/core';

@Component({
    selector: 'pagination',
    templateUrl: './pagination.component.html',
    styleUrls: ['./pagination.component.scss'],
    standalone: false
})
export class PaginationComponent {
  totalPage: number = 0;

  @Input()
  params: {[key: string]: string | number} = {};

  @Input()
  total: number = 0;

  @Input()
  pageSize: number = 5;

  @Input()
  page: number = 1;

  @Output()
  goTo: EventEmitter<number> = new EventEmitter<number>();

  totalPages() {
    // # 10 items per page per default
    return Math.ceil(this.total / this.pageSize);
  }


  pagesRange() {
    const total = this.totalPages();
    const maxPagesToShow = 4;
    let start = Math.max(1, this.page - Math.floor(maxPagesToShow / 2));
    let end = start + maxPagesToShow - 1;
    if (end > total) {
      end = total;
      start = Math.max(1, end - maxPagesToShow + 1);
    }
    return _.range(start, end + 1);
  }
  prevPage() {
    return Math.max(1, this.page - 1);
  }

  nextPage() {
    return Math.min(this.page + 1, this.totalPages());
  }

  pageClicked(page: number) {
    this.goTo.next(page);
  }
}