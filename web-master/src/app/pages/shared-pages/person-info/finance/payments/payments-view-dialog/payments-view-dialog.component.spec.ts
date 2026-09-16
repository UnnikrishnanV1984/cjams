import { ComponentFixture, TestBed } from '@angular/core/testing';
import { PaymentsViewDialogComponent } from './payments-view-dialog.component';

describe('PaymentsViewDialogComponent', () => {
  let component: PaymentsViewDialogComponent;
  let fixture: ComponentFixture<PaymentsViewDialogComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [PaymentsViewDialogComponent]
    })
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PaymentsViewDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
