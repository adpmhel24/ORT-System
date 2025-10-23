import { cookies } from "next/headers";
const apiUrl = process.env.URL;


export async function Post(request: Request) {
    try {
        const body = await request.json();
        const res = await fetch(`${apiUrl}/api/v1/login`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(body),
        });
        const data = await res.json();
        if (!res.ok) {
            return new Response(JSON.stringify(data), {
                status: res.status,
                headers: { "Content-Type": "application/json" },
            });
        }

        // Store tokens in HttpOnly cookies
        const cookieStore = await cookies();
        cookieStore.set("access_token", data.access_token, {
            httpOnly: true,
            secure: process.env.NODE_ENV === "production",
            path: "/",
            maxAge: 60 * 15, // 15 minutes
        });
        cookieStore.set("refresh_token", data.refresh_token, {
            httpOnly: true,
            secure: process.env.NODE_ENV === "production",
            path: "/",
            maxAge: 60 * 60 * 24 * 7, // 7 days
        });

        return Response.json({ message: "Login successful" });

    } catch (error) {
        console.error("Login route error:", error);
        return Response.json(
            { ok: false, message: "Server error connecting to FastAPI" },
            { status: 500 }
        );
    }

}


