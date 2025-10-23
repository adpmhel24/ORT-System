"use server";

import { cookies } from "next/headers";
import { redirect } from "next/navigation";

export async function logoutAction() {
    // ❌ Remove the token cookie
    const cookieStore = await cookies();
    cookieStore.set({
        name: "access_token",
        value: "",
        expires: new Date(0),
        path: "/",
    });

    // 🔁 Redirect back to login page
    redirect("/login");
}
