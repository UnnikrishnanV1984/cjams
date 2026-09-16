import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PhoneCreateUpdateComponent } from './phone-create-update.component';

describe('PhoneCreateUpdateComponent', () => {
  let component: PhoneCreateUpdateComponent;
  let fixture: ComponentFixture<PhoneCreateUpdateComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PhoneCreateUpdateComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PhoneCreateUpdateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
