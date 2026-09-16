import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AttachementScanDetailComponent } from './attachement-scan-detail.component';

describe('AttachementScanDetailComponent', () => {
  let component: AttachementScanDetailComponent;
  let fixture: ComponentFixture<AttachementScanDetailComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AttachementScanDetailComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AttachementScanDetailComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
