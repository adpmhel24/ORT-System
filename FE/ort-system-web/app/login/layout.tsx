import type { Metadata } from "next";
import "../globals.css";


export const metadata: Metadata = {
  title: "Login Page",
  description: "Login to access the application",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}
