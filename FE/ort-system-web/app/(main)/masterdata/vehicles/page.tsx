import React from 'react'
import VehicleTable from './components/VehicleTable';

export default function Vehicles() {

    return (
        <div className="p-8">
            <h1 className="text-2xl font-semibold mb-4">Vehicle Management</h1>
            <VehicleTable />
        </div>
    );
}
