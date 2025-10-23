"use client";

import { DataGrid, GridColDef, GridRenderCellParams } from '@mui/x-data-grid';
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { Personnel } from "../types/personnel_type";

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
} from "@mui/material";
import DeleteIcon from "@mui/icons-material/Delete";
import EditIcon from "@mui/icons-material/Edit";
import PersonnelForm from './PersonnelForm';
import { useState } from 'react';
import React from 'react';


export default function PersonnelTable() {
    const [selectedRow, setSelectedRow] = useState<Personnel | null>(null);
    const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
    const [personToDelete, setPersonToDelete] = useState<Personnel | null>(null);
    const queryClient = useQueryClient();


    // Grid settings

    const columns: GridColDef[] = [
        { field: 'id', headerName: 'ID', width: 70 },
        { field: 'firstName', headerName: 'First name', width: 130 },
        { field: 'lastName', headerName: 'Last name', width: 130 },

        {
            field: 'fullName',
            headerName: 'Full name',
            description: 'This column has a value getter and is not sortable.',
            sortable: false,
            width: 160,
            valueGetter: (value, row) => `${row.firstName || ''} ${row.lastName || ''}`,
        },
        { field: 'position', headerName: 'Position', width: 130 },
        {
            field: "actions",
            headerName: "Actions",
            width: 120,
            sortable: false,
            filterable: false,
            renderCell: (params: GridRenderCellParams<Personnel>) => (
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

    const paginationModel = { page: 0, pageSize: 10 };



    // ✅ GET personnel
    const { data: personnels, isLoading, error } = useQuery<Personnel[]>({
        queryKey: ["personnels"],
        queryFn: async () => {
            const res = await fetch("/masterdata/personnels/api");
            if (!res.ok) throw new Error("Failed to fetch personnels");
            return res.json();
        },
        staleTime: 5 * 60 * 100,
        refetchOnWindowFocus: false,

    });

    // ✅ Delete mutation
    const deletePersonnel = useMutation({
        mutationFn: async (id: number) => {
            const res = await fetch(`/masterdata/personnels/api/${id}`, {
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
        if (!personToDelete) return;
        deletePersonnel.mutate(personToDelete.id);
        setDeleteDialogOpen(false);
        setPersonToDelete(null);
    };
    const handleDeleteClick = (person: Personnel) => {
        setPersonToDelete(person);
        setDeleteDialogOpen(true);
    };



    if (isLoading) return <CircularProgress />;
    if (error) return <p>Error: {(error as Error).message}</p>;
    return (
        <div style={{ display: "flex", flexDirection: "column", height: "100vh" }}>
            <PersonnelForm
                initialData={selectedRow || undefined}
                onSuccess={() => setSelectedRow(null)}
            />
            <Paper sx={{ height: '500', width: '100%' }}>

                <DataGrid
                    rows={personnels}
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
                        <strong>{personToDelete?.firstName} {personToDelete?.lastName}</strong>?
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
