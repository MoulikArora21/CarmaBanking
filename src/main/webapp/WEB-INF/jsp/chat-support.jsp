<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat Support - CARMA Banking</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background: #f8f9fa; color: #1a202c; height: 100vh; display: flex; flex-direction: column; }
        .header { background: white; border-bottom: 1px solid #e2e8f0; box-shadow: 0 1px 3px rgba(0,0,0,0.05); flex-shrink: 0; }
        .header-content { max-width: 1400px; margin: 0 auto; padding: 0 24px; display: flex; align-items: center; justify-content: space-between; height: 72px; }
        .logo { font-size: 24px; font-weight: 700; color: #2d3748; text-decoration: none; letter-spacing: -0.5px; }
        .logo span { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .header-actions { display: flex; align-items: center; gap: 16px; }
        .user-info { display: flex; align-items: center; gap: 12px; padding: 8px 16px; background: #f7fafc; border-radius: 12px; }
        .user-avatar { width: 40px; height: 40px; border-radius: 50%; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; align-items: center; justify-content: center; color: white; font-weight: 600; font-size: 16px; }
        .btn-logout { padding: 10px 20px; background: white; border: 1px solid #e2e8f0; border-radius: 8px; color: #4a5568; font-size: 14px; font-weight: 500; cursor: pointer; transition: all 0.2s; text-decoration: none; }
        .btn-logout:hover { background: #f7fafc; }
        .container { flex: 1; display: flex; flex-direction: column; max-width: 1400px; width: 100%; margin: 0 auto; padding: 24px; overflow: hidden; }
        .page-header { text-align: center; margin-bottom: 24px; }
        .page-title { font-size: 32px; font-weight: 700; color: #2d3748; margin-bottom: 8px; }
        .page-subtitle { color: #718096; font-size: 16px; }
        .chat-container { flex: 1; background: white; border-radius: 16px; box-shadow: 0 2px 8px rgba(0,0,0,0.06); overflow: hidden; display: flex; flex-direction: column; min-height: 0; border: 1px solid #e2e8f0; }
        .chat-header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 16px 24px; display: flex; align-items: center; justify-content: space-between; }
        .chat-header h2 { font-size: 20px; margin: 0; font-weight: 600; }
        .chat-status { display: flex; align-items: center; gap: 8px; font-size: 14px; }
        .status-dot { width: 10px; height: 10px; background: #48bb78; border-radius: 50%; animation: pulse 2s infinite; }
        @keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.5; } }
        .iframe-container { flex: 1; position: relative; min-height: 0; }
        #chatbot-iframe { width: 100%; height: 100%; border: none; }
        @media (max-width: 768px) { .header-content { padding: 0 16px; } .user-info { display: none; } .container { padding: 16px; } .page-title { font-size: 24px; } }
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
            <h1 class="page-title">Chat Support</h1>
            <p class="page-subtitle">Get instant help from our AI assistant</p>
        </div>

        <div class="chat-container">
            <div class="chat-header">
                <h2>CARMA Support Bot</h2>
                <div class="chat-status">
                    <div class="status-dot"></div>
                    <span>Online</span>
                </div>
            </div>

            <div class="iframe-container">
                <iframe id="chatbot-iframe" src="https://moulikarora.tech" title="CARMA Support Chatbot"></iframe>
            </div>
        </div>
    </div>
</body>
</html>
