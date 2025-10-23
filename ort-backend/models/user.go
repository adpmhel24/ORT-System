package models

type User struct {
	ID       uint   `json:"id" gorm:"primaryKey;autoIncrement"`
	Email    string `gorm:"uniqueIndex"`
	FullName string `gorm:"not null"`
	Password string
	IsActive bool `json:"is_active" gorm:"default:true" `
}

// ✅ Automatically register models when this package loads
func init() {
	RegisterModel(&User{})
}
