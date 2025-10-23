package models

var registeredModels []interface{}

// RegisterModel adds a model struct to the global registry
func RegisterModel(model interface{}) {
	registeredModels = append(registeredModels, model)
}

// GetRegisteredModels returns all registered models for migration
func GetRegisteredModels() []interface{} {
	return registeredModels
}
