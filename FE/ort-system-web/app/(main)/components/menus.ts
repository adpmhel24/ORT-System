
export interface Menu {
    name?: string;
    path: string;
    children?: Menu[]; // recursive type
}

export default function Menus(): Menu[] {
    return [
        {
            name: "Dashboard",
            path: "/",
        },
        {
            name: "Operations",
            path: "",
            children: [
                { name: "Job Orders", path: "/operations/job-orders" },
                { name: "Assigments", path: "/operations/assignments" },
            ],
        },
        {
            name: "Master Data",
            path: "#",
            children: [
                { name: "Users", path: "/masterdata/users" },
                { name: "Personnels", path: "/masterdata/personnels" },
                { name: "Vehicles", path: "/masterdata/vehicles" },
            ],
        },
    ];
}
