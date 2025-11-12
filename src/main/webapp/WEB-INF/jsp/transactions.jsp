<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transactions - CARMA Banking</title>
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
        .transactions-card { background: white; border-radius: 16px; padding: 32px; border: 1px solid #e2e8f0; }
        .filter-bar { display: flex; gap: 12px; margin-bottom: 24px; flex-wrap: wrap; }
        .filter-btn { padding: 10px 20px; border-radius: 8px; border: 1px solid #e2e8f0; background: white; color: #4a5568; font-size: 14px; font-weight: 500; cursor: pointer; transition: all 0.2s; }
        .filter-btn.active { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border-color: transparent; }
        .transaction-list { display: flex; flex-direction: column; gap: 12px; }
        .transaction-item { display: flex; justify-content: space-between; align-items: center; padding: 20px; background: #f7fafc; border-radius: 12px; transition: all 0.2s; }
        .transaction-item:hover { background: #edf2f7; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .transaction-info { display: flex; align-items: center; gap: 16px; }
        .transaction-icon { width: 48px; height: 48px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 24px; font-weight: 700; }
        .icon-received { background: #c6f6d5; color: #22543d; }
        .icon-sent { background: #fed7d7; color: #742a2a; }
        .transaction-details h4 { font-size: 16px; font-weight: 600; color: #2d3748; margin-bottom: 4px; }
        .transaction-details p { font-size: 14px; color: #718096; }
        .transaction-amount { text-align: right; }
        .amount { font-size: 18px; font-weight: 700; margin-bottom: 4px; }
        .amount.positive { color: #38a169; }
        .amount.negative { color: #e53e3e; }
        .transaction-date { font-size: 13px; color: #a0aec0; }
        .empty-state { text-align: center; padding: 64px 24px; color: #a0aec0; }
        .empty-state h3 { font-size: 20px; color: #4a5568; margin-bottom: 8px; }
        @media (max-width: 768px) { .header-content { padding: 0 16px; } .user-info { display: none; } .container { padding: 24px 16px; } .page-title { font-size: 24px; } }
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
            <h1 class="page-title">Transaction History</h1>
            <p class="page-subtitle">View all your account transactions</p>
        </div>
        <div class="transactions-card">
            <div class="filter-bar">
                <button class="filter-btn active">All</button>
                <button class="filter-btn">Received</button>
                <button class="filter-btn">Sent</button>
            </div>
            <c:choose>
                <c:when test="${not empty alltransactions}">
                    <div class="transaction-list">
                        <c:forEach var="transaction" items="${alltransactions}">
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
                                                <c:when test="${transaction.type == 'Received'}">From ${transaction.sender}</c:when>
                                                <c:otherwise>To ${transaction.recipient}</c:otherwise>
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
                                    <div class="transaction-date"><fmt:formatDate value="${transaction.date}" pattern="MMM dd, yyyy"/></div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <h3>No transactions yet</h3>
                        <p>Your transaction history will appear here</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
