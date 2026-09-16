import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonHistoryDetailsComponent } from './person-history-details.component';

describe('PersonHistoryDetailsComponent', () => {
  let component: PersonHistoryDetailsComponent;
  let fixture: ComponentFixture<PersonHistoryDetailsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonHistoryDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonHistoryDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
