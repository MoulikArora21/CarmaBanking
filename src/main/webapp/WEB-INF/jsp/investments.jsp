<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Investments - CARMA Banking</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background: #f8f9fa; color: #1a202c; }
        .header { background: white; border-bottom: 1px solid #e2e8f0; position: sticky; top: 0; z-index: 100; box-shadow: 0 1px 3px rgba(0,0,0,0.05); }
        .header-content { max-width: 1400px; margin: 0 auto; padding: 0 24px; display: flex; align-items: center; justify-content: space-between; height: 72px; }
        .logo { font-size: 24px; font-weight: 700; color: #2d3748; text-decoration: none; letter-spacing: -0.5px; }
        .logo span { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .header-actions { display: flex; align-items: center; gap: 16px; }
        .user-info { display: flex; align-items: center; gap: 12px; padding: 8px 16px; background: #f7fafc; border-radius: 12px; }
        .user-avatar { width: 40px; height: 40px; border-radius: 50%; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; align-items: center; justify-content: center; color: white; font-weight: 600; font-size: 16px; }
        .btn-logout { padding: 10px 20px; background: white; border: 1px solid #e2e8f0; border-radius: 8px; color: #4a5568; font-size: 14px; font-weight: 500; cursor: pointer; transition: all 0.2s; text-decoration: none; }
        .btn-logout:hover { background: #f7fafc; }
        .container { max-width: 1400px; margin: 0 auto; padding: 32px 24px; }
        .page-header { margin-bottom: 32px; }
        .page-title { font-size: 32px; font-weight: 700; color: #2d3748; margin-bottom: 8px; }
        .page-subtitle { color: #718096; font-size: 16px; }
        .portfolio-summary { background: white; border-radius: 16px; padding: 32px; margin-bottom: 32px; border: 1px solid #e2e8f0; }
        .portfolio-summary h2 { font-size: 20px; font-weight: 600; color: #2d3748; margin-bottom: 24px; }
        .summary-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; }
        .summary-card { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 24px; border-radius: 12px; transition: transform 0.2s; }
        .summary-card:hover { transform: translateY(-4px); }
        .summary-card h3 { font-size: 14px; opacity: 0.95; margin-bottom: 12px; font-weight: 500; }
        .summary-card .value { font-size: 28px; font-weight: 700; margin-bottom: 8px; }
        .summary-card .change { font-size: 14px; opacity: 0.9; }
        .investments-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap: 24px; margin-bottom: 32px; }
        .investment-card { background: white; border-radius: 16px; padding: 28px; border: 1px solid #e2e8f0; transition: all 0.2s; cursor: pointer; }
        .investment-card:hover { transform: translateY(-4px); box-shadow: 0 8px 20px rgba(0,0,0,0.08); }
        .investment-header { display: flex; align-items: center; margin-bottom: 24px; }
        .investment-icon { width: 56px; height: 56px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 18px; font-weight: 700; margin-right: 16px; color: white; }
        .icon-stocks { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .icon-crypto { background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); }
        .icon-bonds { background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); }
        .icon-funds { background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%); }
        .investment-info h3 { font-size: 18px; color: #2d3748; margin-bottom: 4px; font-weight: 600; }
        .investment-info p { color: #718096; font-size: 14px; }
        .investment-stats { display: flex; justify-content: space-between; margin-top: 20px; }
        .stat { text-align: center; }
        .stat-label { font-size: 12px; color: #a0aec0; margin-bottom: 6px; }
        .stat-value { font-size: 18px; font-weight: 700; color: #2d3748; }
        .positive { color: #38a169; }
        .negative { color: #e53e3e; }
        .action-buttons { display: flex; gap: 16px; justify-content: center; }
        .action-btn { padding: 12px 32px; border: none; border-radius: 8px; font-size: 15px; font-weight: 600; cursor: pointer; transition: all 0.2s; }
        .btn-primary { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4); }
        .btn-secondary { background: white; color: #667eea; border: 1px solid #e2e8f0; }
        .btn-secondary:hover { background: #f7fafc; }
        @media (max-width: 768px) { .header-content { padding: 0 16px; } .user-info { display: none; } .container { padding: 24px 16px; } .page-title { font-size: 24px; } .investments-grid { grid-template-columns: 1fr; } .action-buttons { flex-direction: column; } .action-btn { width: 100%; } }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-content">
            <a href="/homepage" class="logo"><span>CARMA</span> Banking</a>
            <div class="header-actions">
                <div class="user-info">
                    <div class="user-avatar">${username.substring(0,1).toUpperCase()}</div>
                    <span>${username}</span>
                </div>
                <a href="/logout" class="btn-logout">Logout</a>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="page-header">
            <h1 class="page-title">Investment Portfolio</h1>
            <p class="page-subtitle">Manage and track your investments</p>
        </div>

        <div class="portfolio-summary">
            <h2>Portfolio Overview</h2>
            <div class="summary-grid">
                <div class="summary-card">
                    <h3>Total Portfolio Value</h3>
                    <div class="value">EUR ${balance != null ? balance : '0.00'}</div>
                    <div class="change positive">+12.5% this month</div>
                </div>
                <div class="summary-card">
                    <h3>Total Invested</h3>
                    <div class="value">EUR 45,230</div>
                    <div class="change positive">+5.2% ROI</div>
                </div>
                <div class="summary-card">
                    <h3>Monthly Returns</h3>
                    <div class="value">EUR 2,150</div>
                    <div class="change positive">+8.3% vs last month</div>
                </div>
            </div>
        </div>

        <div class="investments-grid">
            <div class="investment-card">
                <div class="investment-header">
                    <div class="investment-icon icon-stocks">ST</div>
                    <div class="investment-info">
                        <h3>Stocks</h3>
                        <p>Diversified portfolio</p>
                    </div>
                </div>
                <div class="investment-stats">
                    <div class="stat">
                        <div class="stat-label">Holdings</div>
                        <div class="stat-value">12</div>
                    </div>
                    <div class="stat">
                        <div class="stat-label">Value</div>
                        <div class="stat-value">EUR 25,450</div>
                    </div>
                    <div class="stat">
                        <div class="stat-label">Return</div>
                        <div class="stat-value positive">+15.2%</div>
                    </div>
                </div>
            </div>

            <div class="investment-card">
                <div class="investment-header">
                    <div class="investment-icon icon-crypto">CR</div>
                    <div class="investment-info">
                        <h3>Cryptocurrency</h3>
                        <p>Digital assets</p>
                    </div>
                </div>
                <div class="investment-stats">
                    <div class="stat">
                        <div class="stat-label">Holdings</div>
                        <div class="stat-value">5</div>
                    </div>
                    <div class="stat">
                        <div class="stat-label">Value</div>
                        <div class="stat-value">EUR 12,340</div>
                    </div>
                    <div class="stat">
                        <div class="stat-label">Return</div>
                        <div class="stat-value positive">+28.4%</div>
                    </div>
                </div>
            </div>

            <div class="investment-card">
                <div class="investment-header">
                    <div class="investment-icon icon-bonds">BO</div>
                    <div class="investment-info">
                        <h3>Bonds</h3>
                        <p>Fixed income securities</p>
                    </div>
                </div>
                <div class="investment-stats">
                    <div class="stat">
                        <div class="stat-label">Holdings</div>
                        <div class="stat-value">8</div>
                    </div>
                    <div class="stat">
                        <div class="stat-label">Value</div>
                        <div class="stat-value">EUR 15,890</div>
                    </div>
                    <div class="stat">
                        <div class="stat-label">Return</div>
                        <div class="stat-value positive">+4.1%</div>
                    </div>
                </div>
            </div>

            <div class="investment-card">
                <div class="investment-header">
                    <div class="investment-icon icon-funds">MF</div>
                    <div class="investment-info">
                        <h3>Mutual Funds</h3>
                        <p>Managed portfolios</p>
                    </div>
                </div>
                <div class="investment-stats">
                    <div class="stat">
                        <div class="stat-label">Holdings</div>
                        <div class="stat-value">6</div>
                    </div>
                    <div class="stat">
                        <div class="stat-label">Value</div>
                        <div class="stat-value">EUR 18,670</div>
                    </div>
                    <div class="stat">
                        <div class="stat-label">Return</div>
                        <div class="stat-value positive">+9.8%</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="action-buttons">
            <button class="action-btn btn-primary" onclick="alert('Investment feature coming soon!')">New Investment</button>
            <button class="action-btn btn-secondary" onclick="window.location.href='/homepage'">Back to Dashboard</button>
        </div>
    </div>
</body>
</html>
