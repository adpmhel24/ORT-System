import { cookies } from "next/headers";
import { NextRequest, NextResponse } from "next/server";
const apiUrl = process.env.URL || "http://localhost:8000";

export async function GET(req: NextRequest, { params }: { params: { id: string } }) {
    const id = params.id; // "1", "2", etc.

    try { // Call backend API for this personnel
        const res = await fetch(`${apiUrl}/api/personnel/${id}`);
        const data = await res.json();


        if (!res.ok)
            return NextResponse.json({ error: data.detail || "Failed to load personnel" }, { status: res.status });

        return NextResponse.json({ success: true, data });

    } catch (err) {
        console.error(`"Get personnel ${id} error:"`, err);
        return NextResponse.json({ error: "Internal Server Error" }, { status: 500 });
    }

}

export async function PUT(req: NextRequest, { params }: { params: { id: string } }) {
    const { id } = await params; // id = "1"
    const cookieStore = await cookies();
    const token = cookieStore.get("access_token")?.value;
    try {
        const body = await req.json();
        const res = await fetch(`${apiUrl}/api/personnel/${id}`, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json",
                Authorization: `Bearer ${token}`,
            },
            body: JSON.stringify(body),
        });

        const data = await res.json();

        if (!res.ok)
            return NextResponse.json({ error: data.detail || "Failed to update personnel" }, { status: res.status });

        return NextResponse.json({ success: true, data });
    } catch (err) {
        console.error(`"Put personnel ${id} error:"`, err);
        return NextResponse.json({ error: "Internal Server Error" }, { status: 500 });
    }
}
