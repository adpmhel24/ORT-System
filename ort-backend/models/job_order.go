package models

import (
	"fmt"
	"time"

	"gorm.io/gorm"
)

type JobOrderHeader struct {
	ID              uint            `json:"id" gorm:"primaryKey;autoIncrement"`
	DeliveryDate    time.Time       `json:"delivery_date" gorm:"type:date;default:CURRENT_DATE"`
	Reference       string          `json:"reference" gorm:"uniqueIndex;not null"`
	BpID            uint            `json:"bp_id" gorm:"not null;index"`
	BusinessPartner BusinessPartner `json:"business_partner" gorm:"foreignKey:BpID;constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;"`
	DeliveryAddress string          `json:"deliveryAddress"`
	Remarks         string          `json:"remarks"`
	Rows            []JobOrderRow   `json:"rows" gorm:"foreignKey:HeaderId;constraint:OnUpdate:CASCADE,OnDelete:CASCADE;"`
	Logs            []JobOrderLog   `json:"logs" gorm:"foreignKey:HeaderId;constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;"`
}

type JobOrderRow struct {
	ID          uint   `json:"id" gorm:"primaryKey;autoIncrement"`
	HeaderId    uint   `json:"headerId" gorm:"not null;index"`
	Description string `json:"description"`
}

type JobOrderLog struct {
	ID             uint           `json:"id" gorm:"primaryKey;autoIncrement"`
	HeaderId       uint           `json:"personnelId" gorm:"not null;index"`
	JobOrderHeader JobOrderHeader `json:"headerOrderHeader" gorm:"constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;foreignKey:HeaderId;references:ID"`
	UserId         uint           `json:"userId" gorm:"constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;"`
	User           User           `json:"User" gorm:"foreignKey:UserId;references:ID"`
	LogDate        time.Time      `json:"logDate" gorm:"type:date"`
	Action         string         `json:"action"` // e.g. Created, Updated, Deleted
	Remarks        string         `json:"remarks"`
}

//
// 🔥 HOOKS SECTION
//

// AfterCreate — logs when a new JobOrderHeader record is created
func (p *JobOrderHeader) AfterCreate(tx *gorm.DB) (err error) {
	ctx := tx.Statement.Context
	var userID uint
	if v := ctx.Value("user_id"); v != nil {
		userID = v.(uint)
	}

	log := JobOrderLog{
		HeaderId: p.ID,
		UserId:   userID,
		LogDate:  time.Now(),
		Action:   "Created",
		Remarks:  fmt.Sprintf("JobOrderHeader created: %s", p.Reference),
	}
	return tx.Create(&log).Error
}

// AfterUpdate — logs when an existing JobOrderHeader record is updated
func (p *JobOrderHeader) AfterUpdate(tx *gorm.DB) (err error) {
	ctx := tx.Statement.Context
	var userID uint
	if v := ctx.Value("user_id"); v != nil {
		userID = v.(uint)
	}

	log := JobOrderLog{
		HeaderId: p.ID,
		UserId:   userID,
		LogDate:  time.Now(),
		Action:   "Updated",
		Remarks:  fmt.Sprintf("JobOrderHeader updated: %s", p.Reference),
	}
	return tx.Create(&log).Error
}

// AfterDelete — logs when a JobOrderHeader record is deleted
func (p *JobOrderHeader) AfterDelete(tx *gorm.DB) (err error) {
	ctx := tx.Statement.Context
	var userID uint
	if v := ctx.Value("user_id"); v != nil {
		userID = v.(uint)
	}

	log := JobOrderLog{
		HeaderId: p.ID,
		UserId:   userID,
		LogDate:  time.Now(),
		Action:   "Deleted",
		Remarks:  fmt.Sprintf("JobOrderHeader deleted: %s", p.Reference),
	}
	return tx.Create(&log).Error
}

// ✅ Automatically register models when this package loads
func init() {
	RegisterModel(&JobOrderHeader{})
	RegisterModel(&JobOrderRow{})
	RegisterModel(&JobOrderLog{})
}
