package models

import (
	"fmt"
	"time"

	"gorm.io/gorm"
)

type Personnel struct {
	ID        uint           `json:"id" gorm:"primaryKey;autoIncrement"`
	FirstName string         `json:"firstName" gorm:"not null;index" `
	LastName  string         `json:"lastName" gorm:"not null;index" `
	Position  string         `json:"position" gorm:"not null" `
	IsActive  bool           `json:"isActive" gorm:"default:true" `
	Logs      []PersonnelLog `json:"logs" gorm:"foreignKey:PersonnelId;constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;"`
	IsArchive bool           `json:"isArchive" gorm:"default:false" `
}

type PersonnelLog struct {
	ID          uint      `json:"id" gorm:"primaryKey;autoIncrement"`
	PersonnelId uint      `json:"personnelId" gorm:"not null;index"`
	Personnel   Personnel `json:"personnel" gorm:"constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;foreignKey:PersonnelId;references:ID"`
	UserId      uint      `json:"userId" gorm:"constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;"`
	User        User      `json:"User" gorm:"foreignKey:UserId;references:ID"`
	LogDate     time.Time `json:"logDate" gorm:"type:date"`
	Action      string    `json:"action"` // e.g. Created, Updated, Deleted
	Remarks     string    `json:"remarks"`
}

//
// 🔥 HOOKS SECTION
//

// AfterCreate — logs when a new Personnel record is created
func (p *Personnel) AfterCreate(tx *gorm.DB) (err error) {
	ctx := tx.Statement.Context
	var userID uint
	if v := ctx.Value("user_id"); v != nil {
		userID = v.(uint)
	}

	log := PersonnelLog{
		PersonnelId: p.ID,
		UserId:      userID,
		LogDate:     time.Now(),
		Action:      "Created",
		Remarks:     fmt.Sprintf("Personnel created: %s %s", p.FirstName, p.LastName),
	}
	return tx.Create(&log).Error
}

// AfterUpdate — logs when an existing Personnel record is updated
func (p *Personnel) AfterUpdate(tx *gorm.DB) (err error) {
	ctx := tx.Statement.Context
	var userID uint
	if v := ctx.Value("user_id"); v != nil {
		userID = v.(uint)
	}

	log := PersonnelLog{
		PersonnelId: p.ID,
		UserId:      userID,
		LogDate:     time.Now(),
		Action:      "Updated",
		Remarks:     fmt.Sprintf("Personnel updated: %s %s", p.FirstName, p.LastName),
	}
	return tx.Create(&log).Error
}

// AfterDelete — logs when a Personnel record is deleted
func (p *Personnel) AfterDelete(tx *gorm.DB) (err error) {
	ctx := tx.Statement.Context
	var userID uint
	if v := ctx.Value("user_id"); v != nil {
		userID = v.(uint)
	}

	log := PersonnelLog{
		PersonnelId: p.ID,
		UserId:      userID,
		LogDate:     time.Now(),
		Action:      "Deleted",
		Remarks:     fmt.Sprintf("Personnel deleted: %s %s", p.FirstName, p.LastName),
	}
	return tx.Create(&log).Error
}

// ✅ Automatically register models when this package loads
func init() {
	RegisterModel(&Personnel{})
	RegisterModel(&PersonnelLog{})
}
