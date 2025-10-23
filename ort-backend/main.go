package main

import (
	"log"
	"net/http"
	config2 "ort-backend/config"
	"ort-backend/handlers"
	middleware2 "ort-backend/middleware"
	"ort-backend/models"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/go-chi/cors"
	"github.com/joho/godotenv"

	_ "ort-backend/docs" // this line is important for swag to load the docs

	httpSwagger "github.com/swaggo/http-swagger"
)

// @title ORT Backend API
// @version 1.0
// @description This is the ORT backend REST API built with Go and Chi.
// @host localhost:8080
// @BasePath /
// @schemes http
func main() {
	if err := godotenv.Load(); err != nil {
		log.Println("⚠️ Warning: No .env file found, using system environment variables.")
	}

	if err := config2.ConnectDatabase(); err != nil {
		log.Fatalf("❌ Failed to connect to database: %v", err)
	}
	log.Println("✅ Connected to database successfully!")

	if err := config2.DB.AutoMigrate(models.GetRegisteredModels()...); err != nil {
		log.Fatalf("❌ AutoMigrate failed: %v", err)
	}
	log.Println("✅ Database migrations completed!")

	r := chi.NewRouter()
	r.Use(middleware.Logger)
	r.Use(middleware.Recoverer)

	// ✅ Add this CORS middleware here
	r.Use(cors.Handler(cors.Options{
		AllowedOrigins:   []string{"http://localhost:3000"}, // your Next.js app
		AllowedMethods:   []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowedHeaders:   []string{"Accept", "Authorization", "Content-Type"},
		ExposedHeaders:   []string{"Link"},
		AllowCredentials: true, // 👈 important for cookies
		MaxAge:           300,
	}))

	// Swagger endpoint
	r.Get("/swagger/*", httpSwagger.WrapHandler)

	// Public routes
	r.Post("/register", handlers.Register)
	r.Post("/login", handlers.Login)

	// Protected routes
	r.Group(func(protected chi.Router) {
		protected.Use(middleware2.AuthMiddleware)
		handlers.RegPersonnelRoutes(protected)
		handlers.RegisterVehicleRoutes(protected)
	})

	log.Println("🚀 Server running on http://localhost:8080")
	if err := http.ListenAndServe(":8080", r); err != nil {
		log.Fatalf("❌ Server failed: %v", err)
	}
}
