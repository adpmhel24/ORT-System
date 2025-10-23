'use client';

import React from 'react'
import { useState } from 'react';
import { useFormStatus } from "react-dom";
import { loginAction } from "./actions";
export default function LoginPage() {
    // const [email, setEmail] = useState("");
    // const [password, setPassword] = useState("");
    // const [error, setError] = useState("");

    // async function handleLogin(e: React.FormEvent) {
    //     e.preventDefault();

    //     const res = await fetch("/api/auth/login", {
    //         method: "POST",
    //         headers: { "Content-Type": "application/json" },
    //         body: JSON.stringify({ email, password }),
    //     });

    //     if (res.ok) {
    //         window.location.href = "/dashboard";
    //     } else {
    //         console.log(res)
    //         const err = await res.json();
    //         setError(err.detail || "Login failed");
    //     }
    // }
    const [error, setError] = useState<string | null>(null);

    const handleSubmit = async (formData: FormData) => {
        const res = await loginAction(formData);
        if (res?.error) setError(res.error);
    };

    return (
        <div className='flex items-center justify-center h-screen '>
            <div className="card">
                <div className='card-body'>
                    <form action={handleSubmit}
                        className="w-96 bg-base-100 shadow-sm p-6">
                        <h2 className="text-2xl mb-4 text-center">Login</h2>
                        <label className="input  w-full text-gray-700 mb-4" htmlFor="Email" >
                            <span className='label'>Email</span>
                            <input
                                type="email"
                                // onChange={(e) => setEmail(e.target.value)}
                                name="email"
                            />

                        </label>
                        <label className="input w-full text-gray-700 mb-4" htmlFor="Email" >
                            <span className='label'>Password</span>
                            <input
                                type="password"
                                // onChange={(e) => setPassword(e.target.value)}
                                name="password"
                            />
                        </label>
                        {error && <p className="text-red-500 text-sm mb-2">{error}</p>}
                        <SubmitButton />
                    </form>
                </div>
            </div>
        </div>

    )
}

function SubmitButton() {
    const { pending } = useFormStatus();
    return (
        <button type="submit" className='btn btn-primary w-full tracking-wide' disabled={pending}>
            {pending ? "Logging in..." : "Login"}
        </button>
    );
}