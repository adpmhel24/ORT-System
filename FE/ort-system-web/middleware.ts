// middleware.ts
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
    const accessToken = request.cookies.get("access_token")?.value;

    const isLoginPage = request.nextUrl.pathname.startsWith("/login");

    // if not logged in, redirect to /login
    if (!accessToken && !isLoginPage) {
        return NextResponse.redirect(new URL("/login", request.url));
    }

    if (accessToken && isLoginPage) {
        return NextResponse.redirect(new URL("/", request.url));
    }

    return NextResponse.next();
}


// ✅ Only run middleware for app pages, not static files or login
export const config = {
    matcher: [
        '/((?!api|_next|static|favicon.ico|login|register|/).*)',
    ],
};
