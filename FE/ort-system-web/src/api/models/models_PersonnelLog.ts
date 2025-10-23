/* generated using openapi-typescript-codegen -- do not edit */
/* istanbul ignore file */
/* tslint:disable */
/* eslint-disable */
import type { models_Personnel } from './models_Personnel';
import type { models_User } from './models_User';
export type models_PersonnelLog = {
    User?: models_User;
    /**
     * e.g. Created, Updated, Deleted
     */
    action?: string;
    logDate?: string;
    personnel?: models_Personnel;
    personnelId?: number;
    remarks?: string;
    userId?: number;
};

