export interface Vehicle {
    id: number;
    plateNumber: string;
    maker: string;
    type: string;
    yearModel: string;
    status: 'Active' | 'Inactive' | 'Under Maintenance';

}

export interface VechicleFormProps {
    initialData?: Vehicle | undefined; // selected row data
    onSuccess?: () => void; // callback after successful update
}
export type VehicleStatus = 'Active' | 'Inactive' | 'Under Maintenance';
