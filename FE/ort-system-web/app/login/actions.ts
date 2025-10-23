"use server";

import { cookies } from "next/headers";
import { redirect } from "next/navigation";

export async function loginAction(formData: FormData) {
    const email = formData.get("email");
    const password = formData.get("password");

    // Call your FastAPI backend
    const res = await fetch(`${process.env.URL}/login`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email, password }),
    });

    if (!res.ok) {
        const err = await res.json();
        console.log(err);
        return { error: err.detail || "Login failed" };
    }

    const data = await res.json();

    // Set cookies securely
    // Store tokens in HttpOnly cookies
    const cookieStore = await cookies();
    cookieStore.set("access_token", data.token, {
        httpOnly: true,
        secure: process.env.NODE_ENV === "production",
        sameSite: "lax",
        path: "/",
        maxAge: 60 * 15, // 15 minutes
    });

    cookieStore.set("refresh_token", data.token, {
        httpOnly: true,
        secure: process.env.NODE_ENV === "production",
        sameSite: "lax",
        path: "/",
        maxAge: 60 * 60 * 24 * 7, // 7 days
    });

    // You can redirect or return data
    redirect("/");
    return { success: true };
}
