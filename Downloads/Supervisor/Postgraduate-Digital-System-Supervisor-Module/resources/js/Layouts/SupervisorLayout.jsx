import { Link } from '@inertiajs/react';
import { route } from 'ziggy-js';

function DashboardIcon() {
    return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
            <path d="M4 13.5h6.5V20H4z" />
            <path d="M13.5 4H20v7.5h-6.5z" />
            <path d="M13.5 13.5H20V20h-6.5z" />
            <path d="M4 4h6.5v7.5H4z" />
        </svg>
    );
}

function SubmissionsIcon() {
    return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
            <path d="M8 7h8" />
            <path d="M8 12h8" />
            <path d="M8 17h5" />
            <path d="M6 3h12a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2Z" />
        </svg>
    );
}

function ReportsIcon() {
    return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
            <path d="M5 18V9" />
            <path d="M12 18V5" />
            <path d="M19 18v-6" />
            <path d="M4 20h16" />
        </svg>
    );
}

function NotificationsIcon() {
    return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
            <path d="M18 8a6 6 0 1 0-12 0c0 7-3 8-3 8h18s-3-1-3-8" />
            <path d="M13.73 21a2 2 0 0 1-3.46 0" />
        </svg>
    );
}

function ProfileIcon() {
    return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
            <path d="M12 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8Z" />
            <path d="M5 21a7 7 0 0 1 14 0" />
        </svg>
    );
}

function ChevronUpIcon() {
    return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
            <path d="m7 14 5-5 5 5" />
        </svg>
    );
}

function LogoutIcon() {
    return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
            <path d="M15 3h3a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-3" />
            <path d="M10 17 15 12 10 7" />
            <path d="M15 12H4" />
        </svg>
    );
}

export default function SupervisorLayout({ children }) {
    const navigation = [
        {
            label: 'Dashboard',
            href: route('dashboard'),
            icon: <DashboardIcon />,
            active: route().current('dashboard'),
        },
        { label: 'Submissions', href: '#', icon: <SubmissionsIcon />, active: false },
        { label: 'Reports', href: '#', icon: <ReportsIcon />, active: false },
        { label: 'Notifications', href: '#', icon: <NotificationsIcon />, active: false },
        {
            label: 'Profile',
            href: route('profile.edit'),
            icon: <ProfileIcon />,
            active: route().current('profile.edit'),
        },
    ];

    return (
        <div className="dashboard-shell">
            <aside className="dashboard-sidebar">
                <div>
                    {/* Brand */}
                    <div className="dashboard-brand">
                        <div className="dashboard-brand-icon">N</div>
                        <div>
                            <div className="dashboard-brand-title">NUST</div>
                            <div className="dashboard-brand-subtitle">PG Management</div>
                        </div>
                    </div>

                    {/* Nav */}
                    <nav className="dashboard-sidebar-nav">
                        {navigation.map((item) => {
                            const className = `dashboard-sidebar-link${item.active ? ' active' : ''}`;

                            const content = (
                                <>
                                    <span className="dashboard-sidebar-link-icon">
                                        {item.icon}
                                    </span>
                                    <span>{item.label}</span>
                                </>
                            );

                            if (item.href === '#') {
                                return (
                                    <a key={item.label} href={item.href} className={className}>
                                        {content}
                                    </a>
                                );
                            }

                            return (
                                <Link key={item.label} href={item.href} className={className}>
                                    {content}
                                </Link>
                            );
                        })}
                    </nav>
                </div>

                <div className="dashboard-sidebar-bottom">
                    <Link
                        href={route('logout')}
                        method="post"
                        as="button"
                        className="dashboard-sidebar-link dashboard-sidebar-logout"
                    >
                        <span className="dashboard-sidebar-link-icon">
                            <LogoutIcon />
                        </span>
                        <span>Logout</span>
                    </Link>

                    {/* Role Panel */}
                    <div className="dashboard-role-panel">
                        <div className="dashboard-role-row">
                            <div>
                                <div className="dashboard-role-label">CURRENT ROLE</div>
                                <div className="dashboard-role-value">Supervisor</div>
                            </div>
                            <span className="dashboard-role-chevron" aria-hidden="true">
                                <ChevronUpIcon />
                            </span>
                        </div>
                    </div>
                </div>
            </aside>

            <main className="dashboard-main">{children}</main>
        </div>
    );
}