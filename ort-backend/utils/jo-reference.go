package utils

import (
	"fmt"
	"time"

	"ort-backend/config"
	"ort-backend/models"
)

func GenerateJobOrderReference() (string, error) {
	// Format current date
	today := time.Now()
	datePart := today.Format("01022006") // MMDDYYYY

	// Find the latest reference for today
	var lastOrder models.JobOrderHeader
	prefix := fmt.Sprintf("JO-%s-", datePart)

	if err := config.DB.
		Where("reference LIKE ?", prefix+"%").
		Order("id DESC").
		First(&lastOrder).Error; err != nil && err.Error() != "record not found" {
		return "", err
	}

	// Extract last sequence number
	var nextSeq int
	if lastOrder.Reference != "" {
		var lastSeq int
		_, err := fmt.Sscanf(lastOrder.Reference, "JO-%s-%05d", &datePart, &lastSeq)
		if err == nil {
			nextSeq = lastSeq + 1
		} else {
			nextSeq = 1
		}
	} else {
		nextSeq = 1
	}

	// Build new reference
	ref := fmt.Sprintf("JO-%s-%05d", datePart, nextSeq)
	return ref, nil
}
