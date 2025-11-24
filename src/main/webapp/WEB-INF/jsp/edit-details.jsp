<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Details - CARMA Banking</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background: #f8f9fa; color: #1a202c; min-height: 100vh; }

        /* Header */
        .header { background: white; border-bottom: 1px solid #e2e8f0; box-shadow: 0 1px 3px rgba(0,0,0,0.05); position: sticky; top: 0; z-index: 100; }
        .header-content { max-width: 1400px; margin: 0 auto; padding: 0 24px; display: flex; align-items: center; justify-content: space-between; height: 72px; }
        .logo-link { display: flex; align-items: center; text-decoration: none; transition: opacity 0.2s; }
        .logo-link:hover { opacity: 0.8; }
        .header-actions { display: flex; align-items: center; gap: 16px; }
        .notification-container { position: relative; }
        .notification-bell { width: 40px; height: 40px; background: #f7fafc; border: 1px solid #e2e8f0; border-radius: 50%; display: flex; align-items: center; justify-content: center; cursor: pointer; transition: all 0.2s; }
        .notification-bell:hover { background: #edf2f7; border-color: #667eea; }
        .user-info { display: flex; align-items: center; gap: 12px; padding: 8px 16px; background: #f7fafc; border-radius: 12px; cursor: pointer; }
        .user-avatar { width: 40px; height: 40px; border-radius: 50%; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; align-items: center; justify-content: center; color: white; font-weight: 600; font-size: 16px; }
        .user-container { position: relative; }
        .user-dropdown { position: absolute; top: 100%; right: 0; background: white; border-radius: 8px; box-shadow: 0 4px 16px rgba(0,0,0,0.12); border: 1px solid #e2e8f0; display: none; min-width: 180px; z-index: 1000; }
        .user-dropdown.open { display: block; }
        .dropdown-item { display: block; padding: 12px 16px; color: #4a5568; text-decoration: none; transition: background 0.2s; }
        .menu-toggle:hover { background: #edf2f7; border-color: #667eea; }
        .menu-toggle { display: flex; cursor: pointer; width: 40px; height: 40px; background: #f7fafc; border: 1px solid #e2e8f0; border-radius: 50%; align-items: center; justify-content: center; transition: all 0.2s; }

        /* Notification Dropdown */
        .notification-dropdown { position: absolute; top: 50px; right: 0; width: 320px; background: white; border-radius: 12px; box-shadow: 0 4px 16px rgba(0,0,0,0.12); border: 1px solid #e2e8f0; display: none; z-index: 1000; }
        .notification-dropdown.open { display: block; }
        .notification-header { padding: 16px 20px; border-bottom: 1px solid #e2e8f0; font-weight: 600; font-size: 15px; color: #2d3748; }
        .notification-list { max-height: 400px; overflow-y: auto; }
        .notification-item { padding: 16px 20px; border-bottom: 1px solid #f7fafc; transition: background 0.2s; }
        .notification-item:hover { background: #f7fafc; }
        .notification-item:last-child { border-bottom: none; }
        .notification-text { font-size: 14px; color: #4a5568; line-height: 1.5; text-align: center; padding: 24px 0; }

        /* Menu Sidebar */
        .menu-sidebar { position: fixed; top: 0; right: -300px; width: 300px; height: 100vh; background: white; box-shadow: -4px 0 16px rgba(0,0,0,0.12); transition: right 0.3s; z-index: 1001; }
        .menu-sidebar.open { right: 0; }
        .menu-sidebar-header { padding: 16px 24px; border-bottom: 1px solid #e2e8f0; display: flex; justify-content: space-between; align-items: center; }
        .menu-sidebar-header h3 { margin: 0; font-size: 18px; font-weight: 600; color: #2d3748; }
        .close-btn { background: none; border: none; font-size: 24px; cursor: pointer; color: #4a5568; }
        .menu-sidebar-content { padding: 16px 0; }
        .menu-item { display: block; padding: 12px 24px; color: #4a5568; text-decoration: none; transition: background 0.2s; }
        .menu-item:hover { background: #f7fafc; }

        /* Container */
        .container { max-width: 800px; margin: 0 auto; padding: 32px 24px; }
        .page-header { text-align: center; margin-bottom: 32px; }
        .page-title { font-size: 32px; font-weight: 700; color: #2d3748; margin-bottom: 8px; }
        .page-subtitle { color: #718096; font-size: 16px; }

        /* Form */
        .form-card { background: white; border-radius: 16px; padding: 32px; box-shadow: 0 2px 8px rgba(0,0,0,0.06); border: 1px solid #e2e8f0; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 24px; }
        .form-group { display: flex; flex-direction: column; gap: 8px; }
        .form-group label { font-size: 14px; font-weight: 500; color: #4a5568; }
        .form-group input { padding: 12px 16px; border: 1px solid #e2e8f0; border-radius: 8px; font-size: 14px; font-family: 'Inter', sans-serif; transition: all 0.2s; }
        .form-group input:focus { outline: none; border-color: #667eea; box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1); }
        .error { color: #e53e3e; font-size: 12px; margin-top: 4px; }
        .success-message { background: #c6f6d5; border: 1px solid #9ae6b4; color: #22543d; padding: 12px; border-radius: 8px; margin-bottom: 20px; }
        
        .btn-group { display: flex; gap: 12px; justify-content: flex-end; padding-top: 20px; border-top: 1px solid #e2e8f0; }
        .btn { padding: 12px 24px; border: none; border-radius: 8px; font-size: 14px; font-weight: 600; cursor: pointer; transition: all 0.2s; }
        .btn-primary { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; }
        .btn-primary:hover { transform: translateY(-1px); box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4); }
        .btn-secondary { background: #f7fafc; color: #4a5568; border: 1px solid #e2e8f0; }
        .btn-secondary:hover { background: #edf2f7; }

        @media (max-width: 768px) {
            .form-grid { grid-template-columns: 1fr; }
            .container { padding: 24px 16px; }
            .user-info { display: none; }
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-content">
            <a href="/homepage" class="logo-link">
                <svg height="50px" viewBox="0 0 250 170" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M8.17307 164.205H125H241.827M36 151.437H54H228.846M125 6.27841V62.8826M125 6.27841L92.5481 22.0018M125 6.27841L157.452 22.0018M125 62.8826H92.5481M125 62.8826H157.452M60.0961 37.7252L66.5865 34.5805L92.5481 22.0018M60.0961 37.7252L8.17307 62.8826H60.0961M60.0961 37.7252V62.8826M60.0961 62.8826H92.5481M92.5481 22.0018V62.8826M157.452 22.0018L176.923 31.4358L189.904 37.7252M157.452 22.0018V62.8826M157.452 62.8826H176.923H189.904M189.904 37.7252L241.827 62.8826H189.904M189.904 37.7252V62.8826" stroke="url(#paint0_linear_purple)" stroke-width="9" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M95.3769 136.4L94.982 145.14H77.4871V135.654L82.6461 135.867L80.4826 120.304L69.499 120.944L67.7515 134.801L72.5777 135.334L72.0122 145.14H55.3805L54.6043 134.588L59.7633 134.801L68.8333 77.8807L64.5895 78.0939V69.3889H86.0577L84.976 77.028L80.8155 77.2412L90.2183 135.867L95.3769 136.4ZM79.3177 111.99L74.8244 79.2664L70.6639 111.99H79.3177ZM134.61 133.948L134.279 145.14H118.814L118.135 135.867H121.297L115.639 110.924H109.981L109.814 135.867L114.807 135.547V145.14H98.5822L97.8323 135.867H102.742L102.7 107.353L102.658 78.8401L97.9154 79.0532L99.0385 69.3889C102.145 69.2113 102.45 69.4245 105.529 69.3889C108.635 69.3179 115.375 69.3889 118.51 69.3889C120.978 69.3889 122.81 69.7442 125 70.6324C127.191 71.4852 128.828 73.5105 128.828 73.5105C128.828 73.5105 131.754 77.4189 132.697 80.0125C133.64 82.6063 134.111 85.6264 134.111 89.0729C134.111 91.3469 133.862 93.603 133.363 95.8415C132.863 98.0799 132.128 100.159 131.157 102.077C130.187 103.96 128.994 105.595 127.579 106.98C126.165 108.366 124.543 109.325 122.712 109.858L128.786 134.161L134.61 133.948ZM126.456 89.4993C126.456 87.6872 126.206 86.0883 125.707 84.7026C125.236 83.3169 124.57 82.1444 123.71 81.1851C122.85 80.2258 121.838 79.5152 120.673 79.0532C119.508 78.5558 118.246 78.3071 116.887 78.3071H113.809H110.23L110.064 101.864H112.061C113.892 101.864 115.667 101.775 117.387 101.597C119.134 101.384 120.673 100.869 122.004 100.052C123.335 99.2347 124.403 98.0089 125.208 96.3745C126.04 94.7046 126.456 92.4128 126.456 89.4993ZM193.066 69.3889V79.4796L187.657 79.1598L186.825 135.547H191.069V145.234H173.424L174.427 135.547H179.503L179.669 84.9158L169.185 139.917L161.03 140.237L152.875 85.0224L152.293 134.694H157.202L157.604 145.14H138.064V134.481L144.804 134.694L145.22 80.7587L137.897 80.2257L137.981 69.3889H157.452L165.274 123.609L176.923 69.3889H193.066ZM235.337 136.4L235.5 151C235.5 151 234.424 145.234 228.846 145.234C223.268 145.234 217.447 145.234 217.447 145.234V135.654L222.605 135.867L220.442 120.304L209.458 120.944L207.711 134.801L212.537 135.334L211.961 145.234H194.873L194.564 134.588L199.723 134.801L208.792 77.8807L204.548 78.0939L202.885 69.3889H226.5L224.935 77.028L220.775 77.2412L230.177 135.867L235.337 136.4ZM219.277 111.99L214.784 79.2664L210.623 111.99H219.277Z" fill="url(#paint1_linear_purple)"/>
                    <path d="M54.5 69.5L55.0238 95.8236L48.013 95.5116C47.8354 94.2987 47.5988 93.0338 47.303 91.7168C47.0367 90.3999 46.6818 89.1177 46.238 87.87C45.8239 86.6224 45.321 85.4441 44.7294 84.3352C44.1378 83.1915 43.4427 82.2038 42.6439 81.3721C41.8452 80.5057 40.9429 79.8299 39.9372 79.3447C38.9314 78.8249 37.8074 78.565 36.5649 78.565C34.7013 78.565 33.0743 79.0329 31.684 79.9685C30.3232 80.9042 29.1547 82.1518 28.1786 83.7113C27.2024 85.2709 26.3889 87.0556 25.7381 89.0657C25.1168 91.0411 24.6288 93.0684 24.2738 95.1477C23.9188 97.2271 23.6674 99.2891 23.5194 101.334C23.4011 103.344 23.342 105.146 23.342 106.74C23.342 108.23 23.4011 109.98 23.5194 111.99C23.6378 113.966 23.8596 116.01 24.185 118.125C24.54 120.238 25.0133 122.335 25.605 124.415C26.1966 126.459 26.9509 128.296 27.8679 129.925C28.8146 131.519 29.9386 132.819 31.2402 133.824C32.5419 134.829 34.08 135.331 35.855 135.331C38.0144 135.331 39.8189 134.777 41.2684 133.668C42.7475 132.559 43.9455 131.138 44.8625 129.405C45.7795 127.638 46.4451 125.679 46.8593 123.531C47.303 121.348 47.5988 119.182 47.7467 117.033H54.7575C54.7575 120.602 54.373 124.068 53.6039 127.43C52.8643 130.791 51.7106 133.772 50.1428 136.371C48.575 138.97 46.5782 141.067 44.1525 142.661C41.7564 144.22 38.9018 145 35.5887 145C33.0447 145 30.7669 144.394 28.7554 143.181C26.7438 141.968 24.969 140.356 23.4307 138.346C21.9221 136.301 20.6353 133.979 19.5703 131.38C18.5054 128.746 17.6328 126.026 16.9524 123.219C16.272 120.412 15.7691 117.622 15.4437 114.85C15.1479 112.042 15 109.478 15 107.156C15 104.522 15.1331 101.75 15.3994 98.8386C15.6952 95.9275 16.1537 93.0684 16.7749 90.2613C17.4257 87.4195 18.2688 84.7163 19.3041 82.1518C20.369 79.5874 21.6854 77.3347 23.2533 75.394C24.8211 73.4533 26.6699 71.9111 28.7997 70.7674C30.9297 69.5891 33.3701 69 36.1212 69C38.9018 69 41.2388 69.7624 43.132 71.2873C45.0252 72.8121 46.6818 74.9261 48.1017 77.6293L48 69.5H54.5Z" fill="url(#paint2_linear_purple)"/>
                    <path d="M18.9999 135.5C24.9999 148 32.7104 146.922 36.4999 147V156H14.4999C5.99976 156 3.49988 159 3.49988 159C3.49988 159 12.0611 148.584 21.4999 149C21.0447 146.401 19.859 146.84 18.9999 135.5Z" fill="#764ba2"/>
                    <defs>
                        <linearGradient id="paint0_linear_purple" x1="125" y1="6.27841" x2="125" y2="172.693" gradientUnits="userSpaceOnUse">
                            <stop stop-color="#667eea"/>
                            <stop offset="1" stop-color="#764ba2"/>
                        </linearGradient>
                        <linearGradient id="paint1_linear_purple" x1="125" y1="71.4057" x2="125" y2="151.804" gradientUnits="userSpaceOnUse">
                            <stop stop-color="#667eea"/>
                            <stop offset="1" stop-color="#764ba2"/>
                        </linearGradient>
                        <linearGradient id="paint2_linear_purple" x1="37.8961" y1="68.7519" x2="37.8961" y2="144.752" gradientUnits="userSpaceOnUse">
                            <stop stop-color="#667eea"/>
                            <stop offset="1" stop-color="#764ba2"/>
                        </linearGradient>
                    </defs>
                </svg>
            </a>
            <div class="header-actions">
                <div class="notification-container">
                    <div class="notification-bell" onclick="toggleNotifications()">
                        <i class="ri-notification-line"></i>
                    </div>
                    <div class="notification-dropdown" id="notificationDropdown">
                        <div class="notification-header">Notifications</div>
                        <div class="notification-list">
                            <div class="notification-item">
                                <div class="notification-text">No new notifications</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="user-container">
                    <div class="user-info" onclick="toggleUserDropdown()">
                        <div class="user-avatar">${username.substring(0,1).toUpperCase()}</div>
                        <span class="user-name">${username}</span>
                        <i class="ri-arrow-down-s-line"></i>
                    </div>
                    <div class="user-dropdown" id="userDropdown">
                        <a href="/account-management" class="dropdown-item">Account Management</a>
                        <a href="/logout" class="dropdown-item">Logout</a>
                    </div>
                </div>
                <div class="menu-toggle" onclick="toggleMenuSidebar()">
                    <i class="ri-menu-line" style="font-size: 20px; color: #4a5568;"></i>
                </div>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="page-header">
            <h1 class="page-title">Edit Your Details</h1>
            <p class="page-subtitle">Update your personal information</p>
        </div>

        <div class="form-card">
            <c:if test="${not empty errorMessage}">
                <div class="error" style="background: #fed7d7; border: 1px solid #fc8181; padding: 12px; border-radius: 8px; margin-bottom: 20px;">${errorMessage}</div>
            </c:if>

            <form method="post" action="/edit-details">
                <div class="form-grid">
                    <div class="form-group">
                        <label>First Name *</label>
                        <input type="text" name="name" value="${user.name}" autocomplete="off" required/>
                    </div>
                    <div class="form-group">
                        <label>Surname *</label>
                        <input type="text" name="surname" value="${user.surname}" autocomplete="off" required/>
                    </div>
                    <div class="form-group">
                        <label>Email *</label>
                        <input type="email" name="email" value="${user.email}" autocomplete="off" required/>
                    </div>
                    <div class="form-group">
                        <label>Phone Number *</label>
                        <input type="text" name="phone_number" value="${user.phone_number}" autocomplete="off" required/>
                    </div>
                    <div class="form-group">
                        <label>Country *</label>
                        <input type="text" name="country" value="${user.country}" autocomplete="off" required/>
                    </div>
                    <div class="form-group">
                        <label>Address</label>
                        <input type="text" name="address" value="${user.address}" autocomplete="off"/>
                    </div>
                    <div class="form-group">
                        <label>Personal ID</label>
                        <input type="text" name="personalid" value="${user.personalid}" autocomplete="off"/>
                    </div>
                    <div class="form-group">
                        <label>New Password (leave blank to keep current)</label>
                        <input type="password" name="newPassword" autocomplete="off"/>
                    </div>
                </div>
                
                <div class="btn-group">
                    <button type="button" class="btn btn-secondary" onclick="window.location.href='/account-management'">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Menu Sidebar -->
    <div class="menu-sidebar" id="menuSidebar">
        <div class="menu-sidebar-header">
            <h3>Menu</h3>
            <button onclick="toggleMenuSidebar()" class="close-btn">&times;</button>
        </div>
        <div class="menu-sidebar-content">
            <a href="/cards" class="menu-item">My Cards</a>
            <a href="/investments" class="menu-item">Investments</a>
            <a href="/chat-support" class="menu-item">Support Chat</a>
        </div>
    </div>

    <script>
        function toggleNotifications() {
            const dropdown = document.getElementById('notificationDropdown');
            dropdown.classList.toggle('open');
        }

        function toggleUserDropdown() {
            const dropdown = document.getElementById('userDropdown');
            dropdown.classList.toggle('open');
        }

        function toggleMenuSidebar() {
            const sidebar = document.getElementById('menuSidebar');
            sidebar.classList.toggle('open');
        }
        
        document.addEventListener('click', function(event) {
            const notificationContainer = document.querySelector('.notification-container');
            const userContainer = document.querySelector('.user-container');
            const menuToggle = document.querySelector('.menu-toggle');
            const menuSidebar = document.querySelector('.menu-sidebar');

            if (!notificationContainer.contains(event.target)) {
                document.getElementById('notificationDropdown').classList.remove('open');
            }
            if (!userContainer.contains(event.target)) {
                document.getElementById('userDropdown').classList.remove('open');
            }
            if (!menuToggle.contains(event.target) && !menuSidebar.contains(event.target)) {
                document.getElementById('menuSidebar').classList.remove('open');
            }
        });
    </script>
</body>
</html>
