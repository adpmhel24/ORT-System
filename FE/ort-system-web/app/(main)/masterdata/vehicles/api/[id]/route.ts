import { cookies } from "next/headers";
import { NextRequest, NextResponse } from "next/server";
const apiUrl = process.env.URL || "http://localhost:8000";
const pathUrl = "/api/vehicle/"

export async function GET(req: NextRequest, { params }: { params: { id: string } }) {
    const id = params.id;

    try {
        // Call backend API for this vehicle
        const res = await fetch(`${apiUrl}${pathUrl}${id}`);
        const data = await res.json();
        if (!res.ok)
            return NextResponse.json({ error: data.detail || "Failed to load vehicle" }, { status: res.status });

        return NextResponse.json({ success: true, data });

    } catch (err) {
        console.error(`"Get vehicle ${id} error:"`, err);
        return NextResponse.json({ error: "Internal Server Error" }, { status: 500 });
    }
}


export async function PUT(req: NextRequest, { params }: { params: { id: string } }) {
    const { id } = await params; // id = "1"
    const cookieStore = await cookies();
    const token = cookieStore.get("access_token")?.value;
    try {
        const body = await req.json();
        const res = await fetch(`${apiUrl}${pathUrl}${id}`, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json",
                Authorization: `Bearer ${token}`,
            },
            body: JSON.stringify(body),
        });

        const data = await res.json();

        if (!res.ok)
            return NextResponse.json({ error: data.detail || "Failed to update vehicle" }, { status: res.status });

        return NextResponse.json({ success: true, data });
    } catch (err) {
        console.error(`"Put vehicle ${id} error:"`, err);
        return NextResponse.json({ error: "Internal Server Error" }, { status: 500 });
    }
}