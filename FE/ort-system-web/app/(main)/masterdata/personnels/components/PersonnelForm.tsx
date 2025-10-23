/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import React, { useState, useEffect } from "react";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { TextField, Button, Box, Alert } from "@mui/material";
import { Personnel } from "../types/personnel_type";



interface PersonnelFormProps {
    initialData?: Personnel | undefined; // selected row data
    onSuccess?: () => void; // callback after successful update
}



export default function PersonnelForm({ initialData, onSuccess }: PersonnelFormProps) {
    const queryClient = useQueryClient();

    const [firstName, setFirstName] = useState("");
    const [lastName, setLastName] = useState("");
    const [position, setPosition] = useState("");
    const [errorMessage, setErrorMessage] = useState(""); // ✅ error state

    // ✅ Populate form when initialData changes
    useEffect(() => {
        if (initialData) {
            setFirstName(initialData.firstName);
            setLastName(initialData.lastName);
            setPosition(initialData.position);
        }
    }, [initialData]);


    const addOrUpdatePersonnel = useMutation({
        mutationFn: async () => {


            const body = { firstName: firstName, lastName: lastName, position };

            const url = initialData
                ? `/masterdata/personnels/api/${initialData.id}` // PUT for update
                : `/masterdata/personnels/api`; // POST for new personnel

            const res = await fetch(url, {
                method: initialData ? "PUT" : "POST",
                body: JSON.stringify(body),
            });

            const data = await res.json();
            if (!res.ok) throw new Error(data.error || "Failed to save personnel");
            return data;
        },
        onSuccess: () => {
            queryClient.invalidateQueries({ queryKey: ["personnels"] });
            setFirstName("");
            setLastName("");
            setPosition("");
            setErrorMessage("");
            onSuccess?.();
        },
        onError: (err: any) => {
            setErrorMessage(err.message || "Something went wrong");
        },
    });

    return (
        <Box display="flex" flexDirection="column" gap={2} mb={4}>
            {errorMessage && <Alert severity="error">{errorMessage}</Alert>}

            <Box display="flex" gap={2} flexWrap="wrap">
                <TextField
                    size="small"
                    label="First Name"
                    value={firstName}
                    onChange={(e) => setFirstName(e.target.value)}
                />
                <TextField
                    size="small"
                    label="Last Name"
                    value={lastName}
                    onChange={(e) => setLastName(e.target.value)}
                />
                <TextField
                    size="small"
                    label="Position"
                    value={position}
                    onChange={(e) => setPosition(e.target.value)}
                />
                <Button
                    variant="contained"
                    color="primary"
                    onClick={() => addOrUpdatePersonnel.mutate()}
                    disabled={addOrUpdatePersonnel.isPending} // ✅ disable button while posting
                >
                    {addOrUpdatePersonnel.isPending
                        ? "Saving..."
                        : initialData
                            ? "Update"
                            : "Add"}
                </Button>
            </Box>
        </Box>
    );
}
