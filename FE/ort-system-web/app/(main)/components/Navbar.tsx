import Avatar from "@mui/material/Avatar";
import MenuIcon from '@mui/icons-material/Menu';
import Link from "next/link";
import Menus, { Menu } from "./menus";


export default function Navbar() {
    const menus: Menu[] = Menus();

    return (
        <div className="navbar bg-base-100 shadow-sm mb-2">
            <div className="navbar-start">
                <div className="dropdown">
                    <div tabIndex={0} role="button" className="btn btn-ghost lg:hidden">
                        <MenuIcon
                            fontSize="medium"
                        ></MenuIcon>
                    </div>
                    <ul
                        tabIndex={-1}
                        className="menu menu-sm dropdown-content bg-base-100 rounded-box z-1 mt-3 w-52 p-2 shadow">
                        {
                            menus.map((menu, j) => {
                                if (menu.children && menu.children.length > 0) {
                                    return (
                                        <li key={j}>
                                            <div className="dropdown">
                                                <div tabIndex={0} role="button">{menu.name}</div>
                                                <ul tabIndex={-1}
                                                    className="dropdown-content menu bg-base-100 rounded-box z-1 w-52 p-2 shadow-sm">
                                                    {
                                                        menu.children.map((menu, j) => (
                                                            <li key={j}>
                                                                <Link href={menu.path}>{menu.name}</Link>
                                                            </li>
                                                        )
                                                        )
                                                    }

                                                </ul>
                                            </div>
                                        </li>
                                    );
                                }
                                return (<li key={j}>
                                    <Link href={menu.path}>{menu.name}</Link>
                                </li>);
                            }
                            )
                        }
                    </ul>
                </div>
                <a className="btn btn-ghost text-xl">ORT System</a>
                <div className="hidden lg:flex">
                    <ul className="menu menu-horizontal px-1">
                        {
                            menus.map((menu, j) => {
                                if (menu.children && menu.children.length > 0) {
                                    return (
                                        <li key={j}>
                                            <div className="dropdown">
                                                <div tabIndex={0} role="button">{menu.name}</div>
                                                <ul tabIndex={-1}
                                                    className="dropdown-content menu bg-base-100 rounded-box z-1 w-52 p-2 shadow-sm">
                                                    {
                                                        menu.children.map((menu, j) => (
                                                            <li key={j}>
                                                                <Link href={menu.path}>{menu.name}</Link>
                                                            </li>
                                                        )
                                                        )
                                                    }

                                                </ul>
                                            </div>
                                        </li>
                                    );
                                }
                                return (<li key={j}>
                                    <Link href={menu.path}>{menu.name}</Link>
                                </li>);
                            }
                            )
                        }
                    </ul>

                </div>
            </div>

            <div className="navbar-end">
                <input type="checkbox" value="dark" className="toggle theme-controller mr-2" />
                <div className="dropdown dropdown-end">
                    <div tabIndex={0} role="button" className="btn btn-ghost btn-circle avatar">
                        <Avatar alt="User" src="/static/images/avatar/1.jpg" />
                    </div>
                    <ul
                        tabIndex={-1}
                        className="menu menu-sm dropdown-content bg-base-100 rounded-box z-1 mt-3 w-52 p-2 shadow">
                        <li>
                            <a className="justify-between">
                                Profile
                                <span className="badge">New</span>
                            </a>
                        </li>
                        <li><a>Settings</a></li>
                        <li><a>Logout</a></li>
                    </ul>
                </div>
            </div>

        </div>
    );
}