import { ComponentFixture, TestBed } from '@angular/core/testing';
import { BeaconViewDialogComponent } from './beacon-view-dialog.component';

describe('BeaconViewDialogComponent', () => {
  let component: BeaconViewDialogComponent;
  let fixture: ComponentFixture<BeaconViewDialogComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [BeaconViewDialogComponent]
    })
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(BeaconViewDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
