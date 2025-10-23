/* generated using openapi-typescript-codegen -- do not edit */
/* istanbul ignore file */
/* tslint:disable */
/* eslint-disable */
import type { models_User } from '../models/models_User';
import type { CancelablePromise } from '../core/CancelablePromise';
import { OpenAPI } from '../core/OpenAPI';
import { request as __request } from '../core/request';
export class AuthService {
    /**
     * Log in a user
     * Authenticate user and return a JWT token
     * @param credentials Login credentials
     * @returns string OK
     * @throws ApiError
     */
    public static postLogin(
        credentials: models_User,
    ): CancelablePromise<Record<string, string>> {
        return __request(OpenAPI, {
            method: 'POST',
            url: '/login',
            body: credentials,
            errors: {
                401: `Unauthorized`,
            },
        });
    }
    /**
     * Register a new user
     * Create a new user account
     * @param user User registration
     * @returns string Created
     * @throws ApiError
     */
    public static postRegister(
        user: models_User,
    ): CancelablePromise<Record<string, string>> {
        return __request(OpenAPI, {
            method: 'POST',
            url: '/register',
            body: user,
            errors: {
                400: `Bad Request`,
            },
        });
    }
}
