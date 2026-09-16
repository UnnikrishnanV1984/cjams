import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PurchaseAuthorizationComponent } from './purchase-authorization.component';

describe('PurchaseAuthorizationComponent', () => {
  let component: PurchaseAuthorizationComponent;
  let fixture: ComponentFixture<PurchaseAuthorizationComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PurchaseAuthorizationComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PurchaseAuthorizationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
