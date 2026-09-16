import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SubsidyAggrementComponent } from './subsidy-aggrement.component';

describe('SubsidyAggrementComponent', () => {
  let component: SubsidyAggrementComponent;
  let fixture: ComponentFixture<SubsidyAggrementComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SubsidyAggrementComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SubsidyAggrementComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
