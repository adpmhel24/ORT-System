"use client";
import { useState } from 'react';
import { DataGrid, GridColDef, GridRenderCellParams } from '@mui/x-data-grid';
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import {
    Paper,
    CircularProgress,
    IconButton,
    Dialog,
    DialogTitle,
    DialogContent,
    Typography,
    DialogActions,
    Button,
    Box,
} from "@mui/material";
import DeleteIcon from "@mui/icons-material/Delete";
import EditIcon from "@mui/icons-material/Edit";
import { Vehicle } from '../types/vehicle_models';
import VehicleForm from './VehicleForm';




export default function VehicleTable() {
    const queryClient = useQueryClient();
    const [selectedRow, setSelectedRow] = useState<Vehicle | null>(null)
    const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
    const [vehicleToDelete, setvehicleToDelete] = useState<Vehicle | null>(null);
    const paginationModel = { page: 0, pageSize: 10 };

    // Grid settings

    const columns: GridColDef[] = [
        { field: 'id', headerName: 'ID', width: 70 },
        { field: 'plateNumber', headerName: 'Plate Number', width: 130 },
        { field: 'maker', headerName: 'Maker', width: 130 },

        { field: 'type', headerName: 'Type', width: 130 },
        { field: 'yearModel', headerName: 'Year Model', width: 130 },
        { field: 'status', headerName: 'Status', width: 130 },
        {
            field: "actions",
            headerName: "Actions",
            width: 120,
            sortable: false,
            filterable: false,
            renderCell: (params: GridRenderCellParams<Vehicle>) => (
                <>
                    <IconButton
                        color="primary"
                        onClick={() => setSelectedRow(params.row)} // edit
                    >
                        <EditIcon />
                    </IconButton>
                    <IconButton
                        color="error"
                        onClick={() => handleDeleteClick(params.row)} // open delete modal delete
                    >
                        <DeleteIcon />
                    </IconButton>
                </>
            ),
        },

    ];

    // ✅ GET personnel
    const { data: vehicles, isLoading, error } = useQuery<Vehicle[]>({
        queryKey: ["vehicles"],
        queryFn: async () => {
            const res = await fetch("/masterdata/vehicles/api");
            if (!res.ok) throw new Error("Failed to fetch vehicles");
            return res.json();
        },
        staleTime: 5 * 60 * 100,
        refetchOnWindowFocus: false,

    });
    // ✅ Delete mutation
    const deleteVehicle = useMutation({
        mutationFn: async (id: number) => {
            const res = await fetch(`/masterdata/vehicles/api/${id}`, {
                method: "DELETE",
            });
            const data = await res.json();
            if (!res.ok) throw new Error(data.error || "Failed to delete personnel");
            return data;
        },
        onSuccess: () => queryClient.invalidateQueries({ queryKey: ["personnels"] }),
        onError: (err: any) => console.error(err),
    });

    const confirmDelete = () => {
        if (!vehicleToDelete) return;
        deleteVehicle.mutate(vehicleToDelete.id);
        setDeleteDialogOpen(false);
        setvehicleToDelete(null);
    };
    const handleDeleteClick = (person: Vehicle) => {
        setvehicleToDelete(person);
        setDeleteDialogOpen(true);
    };

    // ✅ When loading
    if (isLoading) {
        return (
            <Box
                display="flex"
                justifyContent="center"
                alignItems="center"
                height="70vh"
            >
                <CircularProgress />
            </Box>
        );
    }

    return (
        <div style={{ display: "flex", flexDirection: "column", height: "100vh" }}>
            <VehicleForm
                initialData={selectedRow || undefined}
                onSuccess={() => setSelectedRow(null)}
            />
            <Paper sx={{ height: '500', width: '100%' }}>

                <DataGrid
                    rows={vehicles}
                    columns={columns}
                    initialState={{ pagination: { paginationModel } }}
                    pageSizeOptions={[10, 20, 50]}
                    sx={{ border: 0 }}
                // onRowClick={(v) => {
                //     setSelectedRow(v.row);
                // }}
                />
            </Paper>

            {/* Delete Confirmation Dialog */}
            <Dialog open={deleteDialogOpen}
                onClose={() => setDeleteDialogOpen(false)}
                disableEnforceFocus={false} // e
            >
                <DialogTitle>Confirm Delete</DialogTitle>
                <DialogContent>
                    <Typography>
                        Are you sure you want to delete{" "}
                        <strong>{vehicleToDelete?.plateNumber}</strong>?
                    </Typography>
                </DialogContent>
                <DialogActions>
                    <Button onClick={() => setDeleteDialogOpen(false)}>Cancel</Button>
                    <Button color="error" onClick={confirmDelete}>
                        Delete
                    </Button>
                </DialogActions>
            </Dialog>
        </div>

    );

}