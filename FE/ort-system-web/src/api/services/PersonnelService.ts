/* generated using openapi-typescript-codegen -- do not edit */
/* istanbul ignore file */
/* tslint:disable */
/* eslint-disable */
import type { models_Personnel } from '../models/models_Personnel';
import type { CancelablePromise } from '../core/CancelablePromise';
import { OpenAPI } from '../core/OpenAPI';
import { request as __request } from '../core/request';
export class PersonnelService {
    /**
     * Get all personnel
     * Retrieve all personnel records
     * @returns models_Personnel OK
     * @throws ApiError
     */
    public static getApiPersonnel(): CancelablePromise<Array<models_Personnel>> {
        return __request(OpenAPI, {
            method: 'GET',
            url: '/api/personnel',
            errors: {
                500: `Internal Server Error`,
            },
        });
    }
    /**
     * Create a new personnel record
     * Add a new personnel entry to the database
     * @param personnel Personnel data
     * @returns models_Personnel Created
     * @throws ApiError
     */
    public static postApiPersonnel(
        personnel: models_Personnel,
    ): CancelablePromise<models_Personnel> {
        return __request(OpenAPI, {
            method: 'POST',
            url: '/api/personnel',
            body: personnel,
            errors: {
                400: `Bad Request`,
                500: `Internal Server Error`,
            },
        });
    }
    /**
     * Get personnel by ID
     * Retrieve a single personnel record by its ID
     * @param id Personnel ID
     * @returns models_Personnel OK
     * @throws ApiError
     */
    public static getApiPersonnel1(
        id: number,
    ): CancelablePromise<models_Personnel> {
        return __request(OpenAPI, {
            method: 'GET',
            url: '/api/personnel/{id}',
            path: {
                'id': id,
            },
            errors: {
                400: `Bad Request`,
                404: `Not Found`,
            },
        });
    }
    /**
     * Update personnel
     * Update an existing personnel record
     * @param id Personnel ID
     * @param personnel Updated personnel data
     * @returns models_Personnel OK
     * @throws ApiError
     */
    public static putApiPersonnel(
        id: number,
        personnel: models_Personnel,
    ): CancelablePromise<models_Personnel> {
        return __request(OpenAPI, {
            method: 'PUT',
            url: '/api/personnel/{id}',
            path: {
                'id': id,
            },
            body: personnel,
            errors: {
                400: `Bad Request`,
                404: `Not Found`,
                500: `Internal Server Error`,
            },
        });
    }
    /**
     * Delete personnel
     * Remove a personnel record by its ID
     * @param id Personnel ID
     * @returns void
     * @throws ApiError
     */
    public static deleteApiPersonnel(
        id: number,
    ): CancelablePromise<void> {
        return __request(OpenAPI, {
            method: 'DELETE',
            url: '/api/personnel/{id}',
            path: {
                'id': id,
            },
            errors: {
                400: `Bad Request`,
                404: `Not Found`,
            },
        });
    }
}
