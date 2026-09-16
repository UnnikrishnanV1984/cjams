import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SearchRelationshipComponent } from './search-relationship.component';

describe('SearchRelationshipComponent', () => {
  let component: SearchRelationshipComponent;
  let fixture: ComponentFixture<SearchRelationshipComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SearchRelationshipComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SearchRelationshipComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
