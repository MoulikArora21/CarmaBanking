<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - CARMA Banking</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: #f8f9fa;
            color: #1a202c;
        }

        /* Modern Header */
        .header {
            background: white;
            border-bottom: 1px solid #e2e8f0;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }

        .header-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 72px;
        }

        .logo {
            font-size: 24px;
            font-weight: 700;
            color: #2d3748;
            text-decoration: none;
            letter-spacing: -0.5px;
        }

        .logo span {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 8px 16px;
            background: #f7fafc;
            border-radius: 12px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 16px;
        }

        .user-name {
            font-size: 14px;
            font-weight: 500;
            color: #2d3748;
        }

        .btn-logout {
            padding: 10px 20px;
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            color: #4a5568;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-logout:hover {
            background: #f7fafc;
            border-color: #cbd5e0;
        }

        /* Main Layout */
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 32px 24px;
            display: grid;
            grid-template-columns: 280px 1fr;
            gap: 32px;
        }

        /* Sidebar */
        .sidebar {
            background: white;
            border-radius: 16px;
            padding: 24px;
            height: fit-content;
            border: 1px solid #e2e8f0;
        }

        .sidebar-title {
            font-size: 14px;
            font-weight: 600;
            color: #718096;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 16px;
        }

        .nav-menu {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
            border-radius: 10px;
            color: #4a5568;
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
            transition: all 0.2s;
        }

        .nav-item:hover {
            background: #f7fafc;
            color: #667eea;
        }

        .nav-item svg {
            width: 20px;
            height: 20px;
        }

        /* Dashboard Content */
        .dashboard-content {
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        /* Welcome Section */
        .welcome-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 16px;
            padding: 32px;
            color: white;
        }

        .welcome-section h1 {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .welcome-section p {
            font-size: 16px;
            opacity: 0.9;
        }

        /* Balance Card */
        .balance-card {
            background: white;
            border-radius: 16px;
            padding: 32px;
            border: 1px solid #e2e8f0;
        }

        .balance-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .balance-label {
            font-size: 14px;
            color: #718096;
            font-weight: 500;
        }

        .balance-amount {
            font-size: 48px;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 8px;
        }

        .account-number {
            font-size: 14px;
            color: #718096;
            font-family: 'Courier New', monospace;
            letter-spacing: 2px;
        }

        /* Action Buttons */
        .action-buttons {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
            margin-top: 24px;
        }

        .action-btn {
            padding: 14px 24px;
            border-radius: 10px;
            border: none;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            text-align: center;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary {
            background: #f7fafc;
            color: #4a5568;
            border: 1px solid #e2e8f0;
        }

        .btn-secondary:hover {
            background: #edf2f7;
        }

        /* Recent Transactions */
        .transactions-section {
            background: white;
            border-radius: 16px;
            padding: 32px;
            border: 1px solid #e2e8f0;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .section-title {
            font-size: 20px;
            font-weight: 600;
            color: #2d3748;
        }

        .view-all-link {
            color: #667eea;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
        }

        .view-all-link:hover {
            text-decoration: underline;
        }

        .transaction-list {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .transaction-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px;
            background: #f7fafc;
            border-radius: 12px;
            transition: all 0.2s;
        }

        .transaction-item:hover {
            background: #edf2f7;
        }

        .transaction-info {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .transaction-icon {
            width: 44px;
            height: 44px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .icon-received {
            background: #c6f6d5;
            color: #22543d;
        }

        .icon-sent {
            background: #fed7d7;
            color: #742a2a;
        }

        .transaction-details h4 {
            font-size: 15px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 4px;
        }

        .transaction-details p {
            font-size: 13px;
            color: #718096;
        }

        .transaction-amount {
            text-align: right;
        }

        .amount {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 4px;
        }

        .amount.positive {
            color: #38a169;
        }

        .amount.negative {
            color: #e53e3e;
        }

        .transaction-date {
            font-size: 12px;
            color: #a0aec0;
        }

        .empty-state {
            text-align: center;
            padding: 48px 24px;
            color: #a0aec0;
        }

        .empty-state h3 {
            font-size: 18px;
            color: #4a5568;
            margin-bottom: 8px;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .main-container {
                grid-template-columns: 1fr;
            }

            .sidebar {
                display: none;
            }
        }

        @media (max-width: 768px) {
            .header-content {
                padding: 0 16px;
            }

            .user-info {
                display: none;
            }

            .main-container {
                padding: 24px 16px;
            }

            .welcome-section h1 {
                font-size: 24px;
            }

            .balance-amount {
                font-size: 36px;
            }

            .action-buttons {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-content">
            <a href="/homepage" class="logo"><span>CARMA</span> Banking</a>
            <div class="header-actions">
                <div class="user-info">
                    <div class="user-avatar">${username.substring(0,1).toUpperCase()}</div>
                    <span class="user-name">${username}</span>
                </div>
                <a href="/logout" class="btn-logout">Logout</a>
            </div>
        </div>
    </header>

    <!-- Main Container -->
    <div class="main-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-title">Menu</div>
            <nav class="nav-menu">
                <a href="/account-management" class="nav-item">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                    </svg>
                    Account Management
                </a>
                <a href="/cards" class="nav-item">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/>
                    </svg>
                    My Cards
                </a>
                <a href="/investments" class="nav-item">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"/>
                    </svg>
                    Investments
                </a>
                <a href="/chat-support" class="nav-item">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 10h.01M12 10h.01M16 10h.01M9 16H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-5l-5 5v-5z"/>
                    </svg>
                    Support Chat
                </a>
            </nav>
        </aside>

        <!-- Dashboard Content -->
        <main class="dashboard-content">
            <!-- Welcome Section -->
            <section class="welcome-section">
                <h1>Welcome back, ${username}!</h1>
                <p>Here's what's happening with your account today</p>
            </section>

            <!-- Balance Card -->
            <section class="balance-card">
                <div class="balance-header">
                    <span class="balance-label">Available Balance</span>
                </div>
                <div class="balance-amount">EUR ${balance}</div>
                <div class="account-number">ACCT ${account1}-${account2}-${account3}</div>

                <div class="action-buttons">
                    <a href="/recipients" class="action-btn btn-primary">Send Money</a>
                    <a href="/transactions" class="action-btn btn-secondary">View Transactions</a>
                </div>
            </section>

            <!-- Recent Transactions -->
            <section class="transactions-section">
                <div class="section-header">
                    <h2 class="section-title">Recent Transactions</h2>
                    <a href="/transactions" class="view-all-link">View All</a>
                </div>

                <c:choose>
                    <c:when test="${not empty transactions}">
                        <div class="transaction-list">
                            <c:forEach var="transaction" items="${transactions}">
                                <div class="transaction-item">
                                    <div class="transaction-info">
                                        <div class="transaction-icon ${transaction.type == 'Received' ? 'icon-received' : 'icon-sent'}">
                                            <c:choose>
                                                <c:when test="${transaction.type == 'Received'}">+</c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="transaction-details">
                                            <h4>${transaction.type}</h4>
                                            <p>
                                                <c:choose>
                                                    <c:when test="${transaction.type == 'Received'}">
                                                        From ${transaction.sender}
                                                    </c:when>
                                                    <c:otherwise>
                                                        To ${transaction.recipient}
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="transaction-amount">
                                        <div class="amount ${transaction.type == 'Received' ? 'positive' : 'negative'}">
                                            <c:choose>
                                                <c:when test="${transaction.type == 'Received'}">+</c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                            EUR ${transaction.amount}
                                        </div>
                                        <div class="transaction-date">
                                            <fmt:formatDate value="${transaction.date}" pattern="MMM dd, yyyy"/>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <h3>No recent transactions</h3>
                            <p>Your transaction history will appear here</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>
        </main>
    </div>
</body>
</html>
