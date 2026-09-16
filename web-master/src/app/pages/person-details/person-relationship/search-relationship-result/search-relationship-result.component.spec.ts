import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SearchRelationshipResultComponent } from './search-relationship-result.component';

describe('SearchRelationshipResultComponent', () => {
  let component: SearchRelationshipResultComponent;
  let fixture: ComponentFixture<SearchRelationshipResultComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SearchRelationshipResultComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SearchRelationshipResultComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
