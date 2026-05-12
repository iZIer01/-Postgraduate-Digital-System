import SupervisorLayout from '@/Layouts/SupervisorLayout';
import { Head, usePage } from '@inertiajs/react';

function SearchIcon() {
    return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
            <circle cx="11" cy="11" r="6.5" />
            <path d="m16 16 4.5 4.5" />
        </svg>
    );
}

function BellIcon() {
    return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
            <path d="M18 8a6 6 0 1 0-12 0c0 7-3 8-3 8h18s-3-1-3-8" />
            <path d="M13.73 21a2 2 0 0 1-3.46 0" />
        </svg>
    );
}

function UserIcon() {
    return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
            <path d="M12 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8Z" />
            <path d="M5 21a7 7 0 0 1 14 0" />
        </svg>
    );
}

function UsersStatIcon() {
    return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
            <path d="M16 21v-2a4 4 0 0 0-4-4H7a4 4 0 0 0-4 4v2" />
            <path d="M9.5 11a4 4 0 1 0 0-8 4 4 0 0 0 0 8Z" />
            <path d="M20 21v-2a4 4 0 0 0-3-3.87" />
            <path d="M16.5 3.13a4 4 0 0 1 0 7.75" />
        </svg>
    );
}

function ClockStatIcon() {
    return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
            <circle cx="12" cy="12" r="8" />
            <path d="M12 8v5l3 2" />
        </svg>
    );
}

function CheckStatIcon() {
    return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
            <circle cx="12" cy="12" r="8" />
            <path d="m8.5 12 2.5 2.5 4.5-5" />
        </svg>
    );
}

function AlertStatIcon() {
    return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
            <circle cx="12" cy="12" r="8" />
            <path d="M12 8v4.5" />
            <path d="M12 16h.01" />
        </svg>
    );
}

function EyeIcon() {
    return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
            <path d="M2 12s3.5-6 10-6 10 6 10 6-3.5 6-10 6S2 12 2 12Z" />
            <circle cx="12" cy="12" r="2.5" />
        </svg>
    );
}

function TrendIcon() {
    return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
            <path d="M4 16 10 10l4 4 6-7" />
            <path d="M16 7h4v4" />
        </svg>
    );
}

function DocumentIcon() {
    return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
            <path d="M8 3h6l5 5v13a1 1 0 0 1-1 1H8a3 3 0 0 1-3-3V6a3 3 0 0 1 3-3Z" />
            <path d="M14 3v5h5" />
            <path d="M9 14h6" />
            <path d="M9 18h4" />
        </svg>
    );
}

export default function Dashboard() {
    const user = usePage().props.auth.user;

    const stats = [
        {
            label: 'Total Students',
            value: '12',
            tone: 'dashboard-stat-icon-red',
            icon: <UsersStatIcon />,
        },
        {
            label: 'Pending Reviews',
            value: '5',
            tone: 'dashboard-stat-icon-amber',
            icon: <ClockStatIcon />,
        },
        {
            label: 'Approved This Month',
            value: '8',
            tone: 'dashboard-stat-icon-green',
            icon: <CheckStatIcon />,
        },
        {
            label: 'Needs Attention',
            value: '3',
            tone: 'dashboard-stat-icon-alert',
            icon: <AlertStatIcon />,
        },
    ];

    const students = [
        {
            name: 'Ali Hassan',
            studentId: 'MS-CS-2024-001',
            program: 'MS Computer Science',
            researchArea: ['Machine Learning', 'Healthcare'],
            currentStage: 'Proposal Review',
            status: { label: 'Needs Attention', tone: 'dashboard-badge-warning' },
            pending: '2',
            lastActivity: '2 days ago',
        },
        {
            name: 'Fatima Noor',
            studentId: 'MS-CS-2024-001',
            program: 'MS Computer Science',
            researchArea: ['Blockchain', 'Security'],
            currentStage: 'Thesis Writing',
            status: { label: 'On Track', tone: 'dashboard-badge-success' },
            pending: null,
            lastActivity: '1 week ago',
        },
    ];

    return (
        <SupervisorLayout>
            <Head title="Dashboard" />

            <div className="dashboard-page">
                {/* Top Bar */}
                <section className="dashboard-topbar">
                    <div className="dashboard-search-wrapper">
                        <span className="dashboard-search-icon">
                            <SearchIcon />
                        </span>
                        <input
                            type="search"
                            placeholder="Search submissions, students, reports..."
                            className="dashboard-search-input"
                        />
                    </div>

                    <div className="dashboard-topbar-actions">
                        <button className="dashboard-notification-button" type="button">
                            <span className="dashboard-notification-dot" />
                            <BellIcon />
                        </button>

                        <div className="dashboard-user-card">
                            <div className="dashboard-user-info">
                                <span className="dashboard-user-name">
                                    {user?.name ?? 'Dr. Ahmed Khan'}
                                </span>
                                <span className="dashboard-user-role">
                                    Research Supervisor
                                </span>
                            </div>
                            <div className="dashboard-user-avatar">
                                <UserIcon />
                            </div>
                        </div>
                    </div>
                </section>

                {/* Page Header */}
                <section className="dashboard-page-header">
                    <h1 className="dashboard-page-title">Supervisor Dashboard</h1>
                    <p className="dashboard-page-subtitle">
                        Manage and review your assigned postgraduate students
                    </p>
                </section>

                {/* Stat Cards */}
                <section className="dashboard-stat-grid">
                    {stats.map((stat) => (
                        <article className="dashboard-stat-card" key={stat.label}>
                            <div>
                                <p className="dashboard-stat-label">{stat.label}</p>
                                <p className="dashboard-stat-value">{stat.value}</p>
                            </div>
                            <div className={`dashboard-stat-icon ${stat.tone}`}>
                                {stat.icon}
                            </div>
                        </article>
                    ))}
                </section>

                {/* Content Grid */}
                <section className="dashboard-content-grid">
                    {/* Students Table */}
                    <div className="dashboard-card dashboard-card-large">
                        <div className="dashboard-card-top">
                            <div>
                                <h2 className="dashboard-card-title">My Students</h2>
                                <p className="dashboard-card-subtitle">
                                    {students.length} students assigned
                                </p>
                            </div>
                            <button
                                className="dashboard-button dashboard-button-secondary"
                                type="button"
                            >
                                Export Report
                            </button>
                        </div>

                        <div className="dashboard-table-shell">
                            <table className="dashboard-table">
                                <thead>
                                    <tr>
                                        <th>Student</th>
                                        <th>Program</th>
                                        <th>Research Area</th>
                                        <th>Current Stage</th>
                                        <th>Status</th>
                                        <th>Pending</th>
                                        <th>Last Activity</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {students.map((student) => (
                                        <tr key={student.studentId + student.name}>
                                            {/* Student cell with avatar */}
                                            <td>
                                                <div className="dashboard-student-cell">
                                                    <div className="dashboard-student-avatar">
                                                        <UserIcon />
                                                    </div>
                                                    <div className="dashboard-student-info">
                                                        <span className="dashboard-student-name">
                                                            {student.name}
                                                        </span>
                                                        <span className="dashboard-student-id">
                                                            {student.studentId}
                                                        </span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>{student.program}</td>
                                            <td>
                                                <div className="dashboard-multi-line">
                                                    {student.researchArea.map((line) => (
                                                        <span key={line}>{line}</span>
                                                    ))}
                                                </div>
                                            </td>
                                            <td>{student.currentStage}</td>
                                            <td>
                                                <span
                                                    className={`dashboard-badge ${student.status.tone}`}
                                                >
                                                    {student.status.label}
                                                </span>
                                            </td>
                                            <td>
                                                {student.pending ? (
                                                    <span className="dashboard-pending-count">
                                                        {student.pending}
                                                    </span>
                                                ) : (
                                                    <span className="dashboard-muted-dash">-</span>
                                                )}
                                            </td>
                                            <td className="dashboard-last-activity">
                                                {student.lastActivity}
                                            </td>
                                            <td>
                                                <div className="dashboard-table-actions">
                                                    <button
                                                        type="button"
                                                        className="dashboard-action-button dashboard-action-button-primary"
                                                        aria-label="View details"
                                                    >
                                                        <EyeIcon />
                                                    </button>
                                                    <button
                                                        type="button"
                                                        className="dashboard-action-button"
                                                        aria-label="View analytics"
                                                    >
                                                        <TrendIcon />
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>

                    {/* Pending Reviews Panel */}
                    <div className="dashboard-card dashboard-panel">
                        <div className="dashboard-card-top">
                            <div>
                                <h2 className="dashboard-card-title">Pending Reviews</h2>
                                <p className="dashboard-card-subtitle">
                                    0 submissions awaiting review
                                </p>
                            </div>
                            <span className="dashboard-pill">Action Required</span>
                        </div>

                        <div className="dashboard-empty-state">
                            <div className="dashboard-empty-icon">
                                <DocumentIcon />
                            </div>
                            <p className="dashboard-empty-text">No pending submissions</p>
                        </div>
                    </div>
                </section>
            </div>
        </SupervisorLayout>
    );
}