// app/api/auth/refresh/route.ts
import { cookies } from "next/headers";
const apiUrl = process.env.URL;

export async function POST() {

    const cookieStore = await cookies();
    const refreshToken = cookieStore.get("refresh_token")?.value;

    if (!refreshToken) {
        return new Response("Missing refresh token", { status: 401 });
    }

    const res = await fetch(`${apiUrl}/auth/refresh`, {
        method: "POST",
        headers: {
            Authorization: `Bearer ${refreshToken}`,
        },
    });

    const data = await res.json();

    if (!res.ok) {
        return new Response(JSON.stringify(data), {
            status: res.status,
            headers: { "Content-Type": "application/json" },
        });
    }

    cookieStore.set("access_token", data.access_token, {
        httpOnly: true,
        secure: process.env.NODE_ENV === "production",
        path: "/",
        maxAge: 60 * 15,
    });

    return Response.json({ message: "Token refreshed" });
}
