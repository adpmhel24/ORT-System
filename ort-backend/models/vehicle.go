package models

import (
	"fmt"
	"time"

	"gorm.io/gorm"
)

type Vehicle struct {
	ID          uint         `json:"id" gorm:"primaryKey;autoIncrement"`
	PlateNumber string       `json:"plateNumber" gorm:"not null;uniqueIndex"`
	Type        string       `json:"type" gorm:"not null" `
	Maker       string       `json:"maker" gorm:"not null" `
	YearModel   int          `json:"yearModel"`
	Status      string       `json:"status" gorm:"default:'available'" `
	Logs        []VehicleLog `json:"logs" gorm:"foreignKey:VehicleId;constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;"`
}

type VehicleLog struct {
	ID        uint      `json:"id" gorm:"primaryKey;autoIncrement"`
	VehicleId uint      `json:"vehicleId" gorm:"constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;"`
	Vehicle   Vehicle   `json:"vehicle" gorm:"constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;foreignKey:VehicleId;references:ID"`
	UserId    uint      `json:"userId" gorm:"constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;"`
	User      User      `json:"User" gorm:"foreignKey:UserId;references:ID"`
	LogDate   time.Time `json:"logDate" gorm:"type:date"`
	Action    string    `json:"action"` // e.g. Created, Updated, Deleted
	Remarks   string    `json:"remarks"`
}

//
// 🔥 HOOKS SECTION
//

// AfterCreate — logs when a new Personnel record is created
func (p *Vehicle) AfterCreate(tx *gorm.DB) (err error) {
	ctx := tx.Statement.Context
	var userID uint
	if v := ctx.Value("user_id"); v != nil {
		userID = v.(uint)
	}

	log := VehicleLog{
		VehicleId: p.ID,
		UserId:    userID,
		LogDate:   time.Now(),
		Action:    "Created",
		Remarks:   fmt.Sprintf("Vehicle created: %s", p.PlateNumber),
	}
	return tx.Create(&log).Error
}

// AfterUpdate — logs when an existing Personnel record is updated
func (p *Vehicle) AfterUpdate(tx *gorm.DB) (err error) {
	ctx := tx.Statement.Context
	var userID uint
	if v := ctx.Value("user_id"); v != nil {
		userID = v.(uint)
	}

	log := VehicleLog{
		VehicleId: p.ID,
		UserId:    userID,
		LogDate:   time.Now(),
		Action:    "Updated",
		Remarks:   fmt.Sprintf("Vehicle updated: %s", p.PlateNumber),
	}
	return tx.Create(&log).Error
}

// AfterDelete — logs when a Personnel record is deleted
func (p *Vehicle) AfterDelete(tx *gorm.DB) (err error) {
	ctx := tx.Statement.Context
	var userID uint
	if v := ctx.Value("user_id"); v != nil {
		userID = v.(uint)
	}

	log := VehicleLog{
		VehicleId: p.ID,
		UserId:    userID,
		LogDate:   time.Now(),
		Action:    "Deleted",
		Remarks:   fmt.Sprintf("Vehicle deleted: %s", p.PlateNumber),
	}
	return tx.Create(&log).Error
}

// ✅ Automatically register models when this package loads
func init() {
	RegisterModel(&Vehicle{})
	RegisterModel(&VehicleLog{})
}
