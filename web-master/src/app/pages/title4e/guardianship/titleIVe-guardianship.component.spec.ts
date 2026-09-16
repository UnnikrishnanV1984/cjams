import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { GuardianshipComponent } from './titleIVe-guardianship.component';

describe('GuardianshipComponent', () => {
  let component: GuardianshipComponent;
  let fixture: ComponentFixture<GuardianshipComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [GuardianshipComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(GuardianshipComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
