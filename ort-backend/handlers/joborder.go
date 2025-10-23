package handlers

import (
	"context"
	"encoding/json"
	"net/http"
	"time"

	"ort-backend/config"
	"ort-backend/models"
	"ort-backend/utils"

	"gorm.io/gorm"
)

// POST /api/joborders
func CreateJobOrder(w http.ResponseWriter, r *http.Request) {
	var payload models.JobOrderHeader
	if err := json.NewDecoder(r.Body).Decode(&payload); err != nil {
		http.Error(w, "Invalid JSON: "+err.Error(), http.StatusBadRequest)
		return
	}

	// Generate reference if not provided
	if payload.Reference == "" {
		ref, err := utils.GenerateJobOrderReference()
		if err != nil {
			http.Error(w, "Failed to generate reference: "+err.Error(), http.StatusInternalServerError)
			return
		}
		payload.Reference = ref
	}

	// 🟢 Extract user_id from context (set by your JWT middleware)
	// Pass user ID into GORM context
	userID := r.Context().Value("user_id").(uint) // set by your AuthMiddleware
	ctx := context.WithValue(r.Context(), utils.UserIDKey, userID)

	// 🧱 Wrap in a transaction
	err := config.DB.WithContext(ctx).Transaction(func(tx *gorm.DB) error {
		// Set DeliveryDate if not provided
		if payload.DeliveryDate.IsZero() {
			payload.DeliveryDate = time.Now()
		}

		// Create header
		if err := tx.Create(&payload).Error; err != nil {
			return err
		}

		// Assign HeaderId to each row and create them
		for i := range payload.Rows {
			payload.Rows[i].HeaderId = payload.ID
		}
		if len(payload.Rows) > 0 {
			if err := tx.Create(&payload.Rows).Error; err != nil {
				return err
			}
		}

		return nil
	})

	if err != nil {
		http.Error(w, "Failed to create Job Order: "+err.Error(), http.StatusInternalServerError)
		return
	}

	// ✅ Success — respond with created job order
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(payload)
}
