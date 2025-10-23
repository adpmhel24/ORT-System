package models

import (
	"fmt"
	"time"

	"gorm.io/gorm"
)

type BusinessPartner struct {
	ID       uint                 `json:"id" gorm:"primaryKey;autoIncrement"`
	BpName   string               `json:"bpName" gorm:"not null;uniqueIndex" `
	BpType   string               `json:"bpType" gorm:"not null"` // e.g. Customer, Supplier
	Address  string               `json:"address"`
	IsActive bool                 `json:"isActive" gorm:"default:true" `
	Logs     []BusinessPartnerLog `json:"logs" gorm:"foreignKey:BpId;constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;"`
}

type BusinessPartnerLog struct {
	ID              uint            `json:"id" gorm:"primaryKey;autoIncrement"`
	BpId            uint            `json:"bpId" gorm:"constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;index;"`
	BusinessPartner BusinessPartner `json:"bp" gorm:"constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;foreignKey:BpId;references:ID"`
	UserId          uint            `json:"userId" gorm:"constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;"`
	User            User            `json:"User" gorm:"foreignKey:UserId;references:ID"`
	LogDate         time.Time       `json:"logDate" gorm:"type:date"`
	Action          string          `json:"action"` // e.g. Created, Updated, Deleted
	Remarks         string          `json:"remarks"`
}

//
// 🔥 HOOKS SECTION
//

// AfterCreate — logs when a new Personnel record is created
func (p *BusinessPartner) AfterCreate(tx *gorm.DB) (err error) {
	ctx := tx.Statement.Context
	var userID uint
	if v := ctx.Value("user_id"); v != nil {
		userID = v.(uint)
	}

	log := BusinessPartnerLog{
		BpId:    p.ID,
		UserId:  userID,
		LogDate: time.Now(),
		Action:  "Created",
		Remarks: fmt.Sprintf("BusinessPartner created: %s", p.BpName),
	}
	return tx.Create(&log).Error
}

// AfterUpdate — logs when an existing Personnel record is updated
func (p *BusinessPartner) AfterUpdate(tx *gorm.DB) (err error) {
	ctx := tx.Statement.Context
	var userID uint
	if v := ctx.Value("user_id"); v != nil {
		userID = v.(uint)
	}

	log := BusinessPartnerLog{
		BpId:    p.ID,
		UserId:  userID,
		LogDate: time.Now(),
		Action:  "Updated",
		Remarks: fmt.Sprintf("BusinessPartner updated: %s", p.BpName),
	}
	return tx.Create(&log).Error
}

// AfterDelete — logs when a Personnel record is deleted
func (p *BusinessPartner) AfterDelete(tx *gorm.DB) (err error) {
	ctx := tx.Statement.Context
	var userID uint
	if v := ctx.Value("user_id"); v != nil {
		userID = v.(uint)
	}

	log := BusinessPartnerLog{
		BpId:    p.ID,
		UserId:  userID,
		LogDate: time.Now(),
		Action:  "Deleted",
		Remarks: fmt.Sprintf("BusinessPartner deleted: %s", p.BpName),
	}
	return tx.Create(&log).Error
}

// ✅ Automatically register models when this package loads
func init() {
	RegisterModel(&BusinessPartner{})
	RegisterModel(&BusinessPartnerLog{})
}
