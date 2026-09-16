import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SleepingComponent } from './sleeping.component';

describe('SleepingComponent', () => {
  let component: SleepingComponent;
  let fixture: ComponentFixture<SleepingComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SleepingComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SleepingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
