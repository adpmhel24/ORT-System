"use client";
import React, { useState, useEffect } from "react";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { TextField, Button, Box, Alert, MenuItem, CircularProgress } from "@mui/material";
import { VechicleFormProps, VehicleStatus } from "../types/vehicle_models";



export default function VehicleForm({ initialData, onSuccess }: VechicleFormProps) {
    const queryClient = useQueryClient();
    const [plateNumber, setplateNumber] = useState("");
    const [maker, setmaker] = useState("");
    const [type, settype] = useState("");
    const [yearModel, setyearModel] = useState("");
    const [status, setstatus] = useState<VehicleStatus>('Active');
    const [errorMessage, setErrorMessage] = useState("");
    // Populate form when initialData changes
    useEffect(() => {
        if (initialData) {
            setplateNumber(initialData.plateNumber);
            setmaker(initialData.maker);
            settype(initialData.type);
            setyearModel(initialData.yearModel);
            setstatus(initialData.status);
        }
    }, [initialData])


    const addOrUpdate = useMutation({
        mutationFn: async () => {
            const body = {
                plateNumber, maker, type, yearModel: Number(yearModel), status
            }
            const url = initialData
                ? `/masterdata/vehicles/api/${initialData.id}` // PUT for update
                : `/masterdata/vehicles/api`; //
            const res = await fetch(url, {
                method: initialData ? "PUT" : "POST",
                body: JSON.stringify(body),
            });

            const data = await res.json();
            if (!res.ok) throw new Error(data.error || "Failed to save vehicle");
            return data;
        }, onSuccess: () => {
            queryClient.invalidateQueries({ queryKey: ["vehicles"] });
            setplateNumber("");
            setmaker("");
            setyearModel("");
            setstatus("Active");
            settype("");
            setErrorMessage("");
            onSuccess?.();
        },
        onError: (err: any) => {
            setErrorMessage(err.message || "Something went wrong");
        },

    });

    const handleSubmit = () => addOrUpdate.mutate();

    return (
        <Box display="flex"
            flexDirection="column"
            gap={2} mb={4}>
            {errorMessage && <Alert severity="error">{errorMessage}</Alert>}
            <Box display="flex" gap={2} flexWrap="wrap">
                <TextField
                    size="small"
                    label="Plate Number"
                    value={plateNumber}
                    onChange={(e) => setplateNumber(e.target.value)}>
                </TextField>
                <TextField
                    size="small"
                    label="Maker"
                    value={maker}
                    onChange={(e) => setmaker(e.target.value)}>
                </TextField>
                <TextField
                    size="small"
                    label="Type"
                    value={type}
                    onChange={(e) => settype(e.target.value)}>
                </TextField>
                <TextField
                    size="small"
                    label="Year Model"
                    value={yearModel}
                    type="number"
                    onChange={(e) => setyearModel(e.target.value)}>
                </TextField>
                <TextField
                    size="small"
                    label="Status"
                    select
                    value={status}
                    onChange={(e) => setstatus(e.target.value as VehicleStatus)}
                >
                    <MenuItem value="Active">Active</MenuItem>
                    <MenuItem value="Inactive">Inactive</MenuItem>
                    <MenuItem value="Under Maintenance">Under Maintenance</MenuItem>
                </TextField>
                <Button
                    variant="contained"
                    color="primary"
                    onClick={handleSubmit}
                    disabled={addOrUpdate.isPending}
                    sx={{ minWidth: 120 }}
                >
                    {addOrUpdate.isPending ? (
                        <>
                            <CircularProgress size={20} sx={{ color: "white", mr: 1 }} />
                            Saving...
                        </>
                    ) : initialData ? (
                        "Update"
                    ) : (
                        "Add"
                    )}
                </Button>

            </Box>
        </Box>
    )

}