import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonFinanceComponent } from './finance.component';

describe('PersonFinanceComponent', () => {
  let component: PersonFinanceComponent;
  let fixture: ComponentFixture<PersonFinanceComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonFinanceComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonFinanceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
