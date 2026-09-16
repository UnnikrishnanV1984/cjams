import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { LegalCustodyComponent } from './legal-custody.component';

describe('LegalCustodyComponent', () => {
  let component: LegalCustodyComponent;
  let fixture: ComponentFixture<LegalCustodyComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ LegalCustodyComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LegalCustodyComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
