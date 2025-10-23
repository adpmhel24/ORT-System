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

// RegPersonnelRoutes registers personnel-related routes
func RegPersonnelRoutes(r chi.Router) {
	r.Route("/api/personnel", func(pr chi.Router) {
		pr.Get("/", GetPersonnel)
		pr.Post("/", CreatePersonnel)
		pr.Get("/{id}", GetPersonnelById)
		pr.Put("/{id}", UpdatePersonnel)
		pr.Delete("/{id}", DeletePersonnel)
	})
}

// GetPersonnel godoc
// @Summary Get all personnel
// @Description Retrieve all personnel records
// @Tags personnel
// @Security BearerAuth
// @Produce json
// @Success 200 {array} models.Personnel
// @Failure 500 {object} map[string]string
// @Router /api/personnel [get]
func GetPersonnel(w http.ResponseWriter, r *http.Request) {
	var personnel []models.Personnel

	if err := config.DB.Preload("Logs").Order("id ASC").Find(&personnel).Error; err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(personnel)
}

// CreatePersonnel godoc
// @Summary Create a new personnel record
// @Description Add a new personnel entry to the database
// @Tags personnel
// @Security BearerAuth
// @Accept json
// @Produce json
// @Param personnel body models.Personnel true "Personnel data"
// @Success 201 {object} models.Personnel
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /api/personnel [post]
func CreatePersonnel(w http.ResponseWriter, r *http.Request) {
	userID := r.Context().Value("user_id").(uint) // set by your AuthMiddleware

	w.Header().Set("Content-Type", "application/json") // set JSON response

	var personnel models.Personnel
	if err := json.NewDecoder(r.Body).Decode(&personnel); err != nil {
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode(map[string]string{"error": err.Error()})
		return
	}

	// Check if personnel with same first_name and last_name exists
	var existing models.Personnel
	ctx := context.WithValue(r.Context(), utils.UserIDKey, userID)
	err := config.DB.WithContext(ctx).
		Where("first_name = ? AND last_name = ?", personnel.FirstName, personnel.LastName).
		First(&existing).Error

	if err == nil {
		// Record found → return JSON error
		w.WriteHeader(http.StatusConflict)
		json.NewEncoder(w).Encode(map[string]string{"error": "Personnel with this first name and last name already exists"})
		return
	} else if err != gorm.ErrRecordNotFound {
		// Some other DB error
		w.WriteHeader(http.StatusInternalServerError)
		json.NewEncoder(w).Encode(map[string]string{"error": err.Error()})
		return
	}

	// Create new personnel
	if err := config.DB.WithContext(ctx).Create(&personnel).Error; err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		json.NewEncoder(w).Encode(map[string]string{"error": err.Error()})
		return
	}

	// Success response
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(personnel)
}

// GetPersonnelById godoc
// @Summary Get personnel by ID
// @Description Retrieve a single personnel record by its ID
// @Tags personnel
// @Security BearerAuth
// @Produce json
// @Param id path int true "Personnel ID"
// @Success 200 {object} models.Personnel
// @Failure 400 {object} map[string]string
// @Failure 404 {object} map[string]string
// @Router /api/personnel/{id} [get]
func GetPersonnelById(w http.ResponseWriter, r *http.Request) {
	id := chi.URLParam(r, "id")
	personnelID, err := strconv.Atoi(id)
	if err != nil {
		http.Error(w, "Invalid ID", http.StatusBadRequest)
		return
	}
	var personnel models.Personnel
	if result := config.DB.First(&personnel, personnelID); result.Error != nil {
		http.Error(w, "Personnel not found", http.StatusNotFound)
		return
	}
	json.NewEncoder(w).Encode(personnel)
}

// UpdatePersonnel godoc
// @Summary Update personnel
// @Description Update an existing personnel record
// @Tags personnel
// @Security BearerAuth
// @Accept json
// @Produce json
// @Param id path int true "Personnel ID"
// @Param personnel body models.Personnel true "Updated personnel data"
// @Success 200 {object} models.Personnel
// @Failure 400 {object} map[string]string
// @Failure 404 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /api/personnel/{id} [put]
func UpdatePersonnel(w http.ResponseWriter, r *http.Request) {
	id := chi.URLParam(r, "id")
	userID := r.Context().Value("user_id").(uint) // from JWT middleware

	var personnel models.Personnel
	if err := config.DB.First(&personnel, id).Error; err != nil {
		w.WriteHeader(http.StatusNotFound)
		json.NewEncoder(w).Encode(map[string]string{"error": "Personnel not found"})
		return
	}

	// Decode request body into a map
	var body map[string]interface{}
	if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode(map[string]string{"error": err.Error()})
		return
	}

	// Iterate over keys and update the personnel struct dynamically
	for key, value := range body {
		switch key {
		case "firstName":
			if v, ok := value.(string); ok {
				personnel.FirstName = v
			}
		case "lastName":
			if v, ok := value.(string); ok {
				personnel.LastName = v
			}
		case "position":
			if v, ok := value.(string); ok {
				personnel.Position = v
			}
		case "isActive":
			// JSON booleans are decoded as bool
			if v, ok := value.(bool); ok {
				personnel.IsActive = v
			}
		}
	}

	// Save changes
	ctx := context.WithValue(r.Context(), utils.UserIDKey, userID)
	if err := config.DB.WithContext(ctx).Save(&personnel).Error; err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		json.NewEncoder(w).Encode(map[string]string{"error": err.Error()})
		return
	}

	json.NewEncoder(w).Encode(personnel)
}

// DeletePersonnel godoc
// @Summary Delete personnel
// @Description Remove a personnel record by its ID
// @Tags personnel
// @Security BearerAuth
// @Param id path int true "Personnel ID"
// @Success 204 "No Content"
// @Failure 400 {object} map[string]string
// @Failure 404 {object} map[string]string
// @Router /api/personnel/{id} [delete]
func DeletePersonnel(w http.ResponseWriter, r *http.Request) {
	id := chi.URLParam(r, "id")
	personnelID, err := strconv.Atoi(id)
	if err != nil {
		http.Error(w, "Invalid ID", http.StatusBadRequest)
		return
	}

	var personnel models.Personnel
	if result := config.DB.First(&personnel, personnelID); result.Error != nil {
		http.Error(w, "Personnel not found", http.StatusNotFound)
		return
	}

	if result := config.DB.Delete(&personnel); result.Error != nil {
		http.Error(w, result.Error.Error(), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusNoContent)
}
