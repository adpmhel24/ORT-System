package handlers

import (
	"context"
	"encoding/json"
	"net/http"
	"ort-backend/config"
	"ort-backend/models"
	"ort-backend/utils"
	"strconv"

	"github.com/go-chi/chi/v5"
	"gorm.io/gorm"
)

// RegisterVehicleRoutes registers
func RegisterVehicleRoutes(r chi.Router) {
	r.Route("/api/vehicle", func(pr chi.Router) {
		pr.Get("/", GetVehicle)
		pr.Post("/", CreateVehicle)
		pr.Get("/{id}", GetVehicleById)
		pr.Put("/{id}", UpdateVehicle)
		pr.Delete("/{id}", DeleteVehicle)
	})
}

// GetVehicle godoc
// @Summary Get all vehicle
// @Description Retrieve all vehicle records
// @Tags vehicle
// @Security BearerAuth
// @Produce json
// @Success 200 {array} models.Vehicle
// @Failure 500 {object} map[string]string
// @Router /api/vehicle [get]
func GetVehicle(w http.ResponseWriter, r *http.Request) {
	var vehicle []models.Vehicle

	if err := config.DB.Preload("Logs").Order("id ASC").Find(&vehicle).Error; err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(vehicle)
}

// CreateVehicle godoc
// @Summary Create a new vehicle record
// @Description Add a new vehicle entry to the database
// @Tags vehicle
// @Security BearerAuth
// @Accept json
// @Produce json
// @Param vehicle body models.Vehicle true "Vehicle data"
// @Success 201 {object} models.Vehicle
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /api/vehicle [post]
func CreateVehicle(w http.ResponseWriter, r *http.Request) {
	userID := r.Context().Value("user_id").(uint) // set by your AuthMiddleware

	w.Header().Set("Content-Type", "application/json") // set JSON response

	var vehicle models.Vehicle
	if err := json.NewDecoder(r.Body).Decode(&vehicle); err != nil {
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode(map[string]string{"error": err.Error()})
		return
	}

	// Check if vehicle with same first_name and last_name exists
	var existing models.Vehicle
	ctx := context.WithValue(r.Context(), utils.UserIDKey, userID)
	err := config.DB.WithContext(ctx).
		Where("plate_number = ?", vehicle.PlateNumber).
		First(&existing).Error

	if err == nil {
		// Record found → return JSON error
		w.WriteHeader(http.StatusConflict)
		json.NewEncoder(w).Encode(map[string]string{"error": "Vehicle platenumber already exists"})
		return
	} else if err != gorm.ErrRecordNotFound {
		// Some other DB error
		w.WriteHeader(http.StatusInternalServerError)
		json.NewEncoder(w).Encode(map[string]string{"error": err.Error()})
		return
	}

	// Create new vehicle
	if err := config.DB.WithContext(ctx).Create(&vehicle).Error; err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		json.NewEncoder(w).Encode(map[string]string{"error": err.Error()})
		return
	}

	// Success response
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(vehicle)
}

// GetVehicleById godoc
// @Summary Get vehicle by ID
// @Description Retrieve a single vehicle record by its ID
// @Tags vehicle
// @Security BearerAuth
// @Produce json
// @Param id path int true "Vehicle ID"
// @Success 200 {object} models.Vehicle
// @Failure 400 {object} map[string]string
// @Failure 404 {object} map[string]string
// @Router /api/vehicle/{id} [get]
func GetVehicleById(w http.ResponseWriter, r *http.Request) {
	id := chi.URLParam(r, "id")
	vehicleID, err := strconv.Atoi(id)
	if err != nil {
		http.Error(w, "Invalid ID", http.StatusBadRequest)
		return
	}
	var vehicle models.Vehicle
	if result := config.DB.First(&vehicle, vehicleID); result.Error != nil {
		http.Error(w, "Vehicle not found", http.StatusNotFound)
		return
	}
	json.NewEncoder(w).Encode(vehicle)
}

// UpdateVehicle godoc
// @Summary Update vehicle
// @Description Update an existing vehicle record
// @Tags vehicle
// @Security BearerAuth
// @Accept json
// @Produce json
// @Param id path int true "Vehicle ID"
// @Param vehicle body models.Vehicle true "Updated vehicle data"
// @Success 200 {object} models.Vehicle
// @Failure 400 {object} map[string]string
// @Failure 404 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /api/vehicle/{id} [put]
func UpdateVehicle(w http.ResponseWriter, r *http.Request) {
	id := chi.URLParam(r, "id")
	userID := r.Context().Value("user_id").(uint) // from JWT middleware

	var vehicle models.Vehicle
	if err := config.DB.First(&vehicle, id).Error; err != nil {
		w.WriteHeader(http.StatusNotFound)
		json.NewEncoder(w).Encode(map[string]string{"error": "Vehicle not found"})
		return
	}

	// Decode request body into a map
	var body map[string]interface{}
	if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode(map[string]string{"error": err.Error()})
		return
	}

	// Iterate over keys and update the vehicle struct dynamically
	for key, value := range body {
		switch key {
		case "plateNumber":
			if v, ok := value.(string); ok {
				vehicle.PlateNumber = v
			}
		case "type":
			if v, ok := value.(string); ok {
				vehicle.Type = v
			}
		case "maker":
			if v, ok := value.(string); ok {
				vehicle.Maker = v
			}
		case "yearModel":
			if v, ok := value.(int); ok {
				vehicle.YearModel = v
			}
		case "status":
			if v, ok := value.(string); ok {
				vehicle.Status = v
			}
		}
	}

	// Save changes
	ctx := context.WithValue(r.Context(), utils.UserIDKey, userID)
	if err := config.DB.WithContext(ctx).Save(&vehicle).Error; err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		json.NewEncoder(w).Encode(map[string]string{"error": err.Error()})
		return
	}

	json.NewEncoder(w).Encode(vehicle)
}

// DeleteVehicle godoc
// @Summary Delete vehicle
// @Description Remove a vehicle record by its ID
// @Tags vehicle
// @Security BearerAuth
// @Param id path int true "Vehicle ID"
// @Success 204 "No Content"
// @Failure 400 {object} map[string]string
// @Failure 404 {object} map[string]string
// @Router /api/vehicle/{id} [delete]
func DeleteVehicle(w http.ResponseWriter, r *http.Request) {
	id := chi.URLParam(r, "id")
	vehicleID, err := strconv.Atoi(id)
	if err != nil {
		http.Error(w, "Invalid ID", http.StatusBadRequest)
		return
	}

	var vehicle models.Vehicle
	if result := config.DB.First(&vehicle, vehicleID); result.Error != nil {
		http.Error(w, "Vehicle not found", http.StatusNotFound)
		return
	}

	if result := config.DB.Delete(&vehicle); result.Error != nil {
		http.Error(w, result.Error.Error(), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusNoContent)
}
