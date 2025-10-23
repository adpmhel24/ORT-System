package middleware

import (
	"context"
	"net/http"
	"ort-backend/utils"
)

func AuthMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		var tokenString string

		// ✅ 1. Try from cookie
		cookie, err := r.Cookie("access_token")
		if err == nil {
			tokenString = cookie.Value
		}

		// ✅ 2. Fallback to Authorization header
		if tokenString == "" {
			tokenString = r.Header.Get("Authorization")
			if len(tokenString) > 7 && tokenString[:7] == "Bearer " {
				tokenString = tokenString[7:]
			}
		}

		// 🚫 If still empty → reject
		if tokenString == "" {
			http.Error(w, "Missing token", http.StatusUnauthorized)
			return
		}

		// 🔐 Validate JWT
		claims, err := utils.ValidateToken(tokenString)
		if err != nil {
			http.Error(w, "Invalid or expired token", http.StatusUnauthorized)
			return
		}

		// ✅ Extract claims
		userID := uint(claims["user_id"].(float64))
		username := claims["username"].(string)

		// Store user info in request context
		ctx := context.WithValue(r.Context(), "user_id", userID)
		ctx = context.WithValue(ctx, "username", username)

		next.ServeHTTP(w, r.WithContext(ctx))
	})
}
