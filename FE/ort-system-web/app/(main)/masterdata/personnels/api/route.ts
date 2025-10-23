import { cookies } from "next/headers";
import { NextRequest, NextResponse } from "next/server";

const apiUrl = process.env.URL || "http://localhost:8000";

export async function GET() {
    const cookieStore = await cookies();
    const token = cookieStore.get("access_token")?.value;

    if (!token) {
        return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    try {
        const res = await fetch(`${apiUrl}/api/personnel/`, {
            method: "GET",
            headers: {
                Authorization: `Bearer ${token}`,
                "Content-Type": "application/json",
            },
            cache: "no-store",
        });

        const data = await res.json();

        if (!res.ok) return NextResponse.json({ status: res.status });

        return NextResponse.json(data);
    } catch (error) {
        console.error("Error fetching personnel:", error);
        return NextResponse.json({ error: "Internal Server Error" }, { status: 500 });
    }
}

export async function POST(req: NextRequest) {
    const cookieStore = await cookies();
    const token = cookieStore.get("access_token")?.value;

    if (!token) {
        return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    try {
        const body = await req.json();
        const res = await fetch(`${apiUrl}/api/personnel/`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                Authorization: `Bearer ${token}`,
            },
            body: JSON.stringify(body),
        });
        const data = await res.json();


        if (!res.ok)
            return NextResponse.json({ error: data.detail || "Failed to create personnel" }, { status: res.status });

        return NextResponse.json({ success: true, data });
    } catch (err) {
        console.error("POST error:", err);
        return NextResponse.json({ error: "Internal Server Error" }, { status: 500 });
    }
}

