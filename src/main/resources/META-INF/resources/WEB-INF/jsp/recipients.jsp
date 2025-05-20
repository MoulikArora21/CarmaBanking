<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recipients</title>
    <style>
        /*header*/
        header{
            width:100%;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        header>div{
            display:flex;
            align-items: center;
            justify-content: space-between;
            padding: 50px 10%;
        }
        header>div>div{
            display:flex;
            align-items: center;
            gap:30px;
        }
        #logo-btn, {
            width:fit-content;
            padding:0;
        }
        .back-button{
            width:auto;
            height:50px;
        }
        .log-out-btn{
            width:auto;
            padding:0px 20px;
            height:50px;
        }
        /*header end*/
        button{
            padding: 0px 10px;
            border: none;
            border-radius: 20px;
            font-size: 1em;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            width:150px;
            display: flex;
            justify-content:center;
            gap: 10px;
            align-items: center;
            width:100%;
        }
        /*notification*/
        .notification-btn {
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: #d71414;
            color: white;
            border: none;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            z-index: 1000;
            transition: background-color 0.3s;
        }

        .notification-btn:hover {
            background-color: #9a0000;
        }

        .notification-btn.hidden {
            display: none;
        }
        /* Notification Div */
        .notification {
            background-color: white;
            box-shadow: 0px 0px 10px rgba(255, 0, 0, 0.1);
            border-radius: 10px;
            padding: 20px;
            position: fixed;
            right: -300px; /* Hidden by default */
            top: 80px;
            border: 2px solid #d71414;
            z-index: 999;
            transition: right 0.3s ease-in-out;
            width: 250px;
        }

        .notification.open {
            right: 20px; /* Space from right edge when open */
        }

        .notification p {
            margin: 0 0 15px 0; /* Space below paragraph for close button */
            font-size: 16px;
        }

        .notification span {
            font-weight: bold;
        }

        /* Close Button */
        .close-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 8px 12px;
            cursor: pointer;
            font-size: 14px;
            display: block;
            margin-left: auto;
        }

        .close-btn:hover {
            background-color: #9a0000;
        }
        /*notification end*/
        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction:column;
            justify-content: center;
            align-items:center;
            margin: 0px 0;
            background-color: #ffffff;
        }
        .container {
            background-color: #ffffff;
            border-radius: 15px;
            margin-top:100px;
            padding: 20px;
            width: 80%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
        }
        .recipient {
            display: flex;
            align-items: center;
            background-color: #ccc;
            border-radius: 10px;
            padding: 10px;
            cursor: pointer;
        }
        .recipient .avatar {
            width: 40px;
            height: 40px;
            background-color: #ffffff;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 20px;
            font-weight: bold;
            margin-right: 10px;
        }
        .recipient .info {
            flex-grow: 1;
        }
        .recipient .info p {
            margin: 0;
            font-size: 16px;
            font-weight: bold;
        }
        .recipient .info small {
            display: block;
            font-size: 12px;
        }
        .money-transfer {
            box-sizing: border-box;
            margin: 15px 15px;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease-in-out;
        }
        .money-transfer.open {
            max-height: 200px;
        }
        .amount-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .amount-section input {
            width: 100px;
            padding: 8px;
            border: none;
            border-radius: 5px;
            text-align: center;
            font-size: 16px;
            margin: 0 10px;
        }
        .amount-section button {
            padding: 10px 20px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-size: 1em;
            font-weight: bold;
            background-color: #4CAF50;
            color: white;
            width: 150px;
        }
        .amount-section p {
            margin: 0 10px 0 0;
        }
        .add-recipient {
            text-align: center;
            margin-top: 10px;
        }
        .add-recipient a {
            text-decoration: none;
            font-size: 14px;
            cursor: pointer;
        }
        .add-recipient a:hover {
            text-decoration: underline;
        }
        .add-recipient-form {
            background-color: #ccc;
            border-radius: 10px;
            padding: 10px;
            display: none;
            opacity: 0;
            transition: opacity 0.3s ease-in-out;
        }
        .add-recipient-form.visible {
            display: flex;
            opacity: 1;
            justify-content: center;
        }
        .col-2 {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 0 15px;
        }
        .input-container {
            position: relative;
            margin: 10px 0;
            width: 100%;
            max-width: 220px;
        }
        input {
            padding: 10px 20px 10px 10px;
            font-size: 16px;
            border: none;
            border-radius: 20px;
            background-color: #ffffff;
            width: 200px;
            box-sizing: border-box;
            text-align: center;
        }
        .mandatory-mark {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: red;
            font-size: 20px;
            pointer-events: none;
        }
        form p {
            color: red;
            text-align: center;
        }
        .error {
            color: red;
            text-align: center;
        }
        .message {
            color: green;
            text-align: center;
        }
        button[type="submit"]{
        padding:10px 10px;}
    </style>
    <script>
        function toggleMoneyTransfer(element) {
            const transferSection = element.closest('.open-button').querySelector('.money-transfer');
            transferSection.classList.toggle('open');
            const addForm = document.querySelector('.add-recipient-form');
            const addLink = document.querySelector('.add-recipient a');
            addForm.classList.remove('visible');
            addLink.style.display = 'inline';
        }

        function toggleAddRecipient() {
            const addLink = document.querySelector('.add-recipient a');
            const addForm = document.querySelector('.add-recipient-form');
            addLink.style.display = 'none';
            addForm.classList.add('visible');
        }
    </script>
</head>
<header>
    <div>
        <div>
            <button class="back-button" onclick="history.back()">
                <svg width="30px" height="auto" viewBox="0 -6.5 36 36" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" fill="#000000"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <title>left-arrow</title> <desc>Created with Sketch.</desc> <g id="icons" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"> <g id="ui-gambling-website-lined-icnos-casinoshunter" transform="translate(-342.000000, -159.000000)" fill="white" fill-rule="nonzero"> <g id="square-filled" transform="translate(50.000000, 120.000000)"> <path d="M317.108012,39.2902857 L327.649804,49.7417043 L327.708994,49.7959169 C327.889141,49.9745543 327.986143,50.2044182 328,50.4382227 L328,50.5617773 C327.986143,50.7955818 327.889141,51.0254457 327.708994,51.2040831 L327.6571,51.2479803 L317.108012,61.7097143 C316.717694,62.0967619 316.084865,62.0967619 315.694547,61.7097143 C315.30423,61.3226668 315.30423,60.6951387 315.694547,60.3080911 L324.702666,51.3738496 L292.99947,51.3746291 C292.447478,51.3746291 292,50.9308997 292,50.3835318 C292,49.8361639 292.447478,49.3924345 292.99947,49.3924345 L324.46779,49.3916551 L315.694547,40.6919089 C315.30423,40.3048613 315.30423,39.6773332 315.694547,39.2902857 C316.084865,38.9032381 316.717694,38.9032381 317.108012,39.2902857 Z M327.115357,50.382693 L316.401279,61.0089027 L327.002151,50.5002046 L327.002252,50.4963719 L326.943142,50.442585 L326.882737,50.382693 L327.115357,50.382693 Z" id="left-arrow" transform="translate(310.000000, 50.500000) scale(-1, 1) translate(-310.000000, -50.500000) "> </path> </g> </g> </g> </g></svg>
                <p>Go Back</p>
            </button>
            <div id="logo-btn">
                <a href="/homepage"><svg width="auto" height="50px" viewBox="0 0 250 170" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M8.17307 164.205H125H241.827M36 151.437H54H228.846M125 6.27841V62.8826M125 6.27841L92.5481 22.0018M125 6.27841L157.452 22.0018M125 62.8826H92.5481M125 62.8826H157.452M60.0961 37.7252L66.5865 34.5805L92.5481 22.0018M60.0961 37.7252L8.17307 62.8826H60.0961M60.0961 37.7252V62.8826M60.0961 62.8826H92.5481M92.5481 22.0018V62.8826M157.452 22.0018L176.923 31.4358L189.904 37.7252M157.452 22.0018V62.8826M157.452 62.8826H176.923H189.904M189.904 37.7252L241.827 62.8826H189.904M189.904 37.7252V62.8826" stroke="url(#paint0_linear_5_6)" stroke-width="9" stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M95.3769 136.4L94.982 145.14H77.4871V135.654L82.6461 135.867L80.4826 120.304L69.499 120.944L67.7515 134.801L72.5777 135.334L72.0122 145.14H55.3805L54.6043 134.588L59.7633 134.801L68.8333 77.8807L64.5895 78.0939V69.3889H86.0577L84.976 77.028L80.8155 77.2412L90.2183 135.867L95.3769 136.4ZM79.3177 111.99L74.8244 79.2664L70.6639 111.99H79.3177ZM134.61 133.948L134.279 145.14H118.814L118.135 135.867H121.297L115.639 110.924H109.981L109.814 135.867L114.807 135.547V145.14H98.5822L97.8323 135.867H102.742L102.7 107.353L102.658 78.8401L97.9154 79.0532L99.0385 69.3889C102.145 69.2113 102.45 69.4245 105.529 69.3889C108.635 69.3179 115.375 69.3889 118.51 69.3889C120.978 69.3889 122.81 69.7442 125 70.6324C127.191 71.4852 128.828 73.5105 128.828 73.5105C128.828 73.5105 131.754 77.4189 132.697 80.0125C133.64 82.6063 134.111 85.6264 134.111 89.0729C134.111 91.3469 133.862 93.603 133.363 95.8415C132.863 98.0799 132.128 100.159 131.157 102.077C130.187 103.96 128.994 105.595 127.579 106.98C126.165 108.366 124.543 109.325 122.712 109.858L128.786 134.161L134.61 133.948ZM126.456 89.4993C126.456 87.6872 126.206 86.0883 125.707 84.7026C125.236 83.3169 124.57 82.1444 123.71 81.1851C122.85 80.2258 121.838 79.5152 120.673 79.0532C119.508 78.5558 118.246 78.3071 116.887 78.3071H113.809H110.23L110.064 101.864H112.061C113.892 101.864 115.667 101.775 117.387 101.597C119.134 101.384 120.673 100.869 122.004 100.052C123.335 99.2347 124.403 98.0089 125.208 96.3745C126.04 94.7046 126.456 92.4128 126.456 89.4993ZM193.066 69.3889V79.4796L187.657 79.1598L186.825 135.547H191.069V145.234H173.424L174.427 135.547H179.503L179.669 84.9158L169.185 139.917L161.03 140.237L152.875 85.0224L152.293 134.694H157.202L157.604 145.14H138.064V134.481L144.804 134.694L145.22 80.7587L137.897 80.2257L137.981 69.3889H157.452L165.274 123.609L176.923 69.3889H193.066ZM235.337 136.4L235.5 151C235.5 151 234.424 145.234 228.846 145.234C223.268 145.234 217.447 145.234 217.447 145.234V135.654L222.605 135.867L220.442 120.304L209.458 120.944L207.711 134.801L212.537 135.334L211.961 145.234H194.873L194.564 134.588L199.723 134.801L208.792 77.8807L204.548 78.0939L202.885 69.3889H226.5L224.935 77.028L220.775 77.2412L230.177 135.867L235.337 136.4ZM219.277 111.99L214.784 79.2664L210.623 111.99H219.277Z" fill="url(#paint1_linear_5_6)"/>
        <path d="M54.5 69.5L55.0238 95.8236L48.013 95.5116C47.8354 94.2987 47.5988 93.0338 47.303 91.7168C47.0367 90.3999 46.6818 89.1177 46.238 87.87C45.8239 86.6224 45.321 85.4441 44.7294 84.3352C44.1378 83.1915 43.4427 82.2038 42.6439 81.3721C41.8452 80.5057 40.9429 79.8299 39.9372 79.3447C38.9314 78.8249 37.8074 78.565 36.5649 78.565C34.7013 78.565 33.0743 79.0329 31.684 79.9685C30.3232 80.9042 29.1547 82.1518 28.1786 83.7113C27.2024 85.2709 26.3889 87.0556 25.7381 89.0657C25.1168 91.0411 24.6288 93.0684 24.2738 95.1477C23.9188 97.2271 23.6674 99.2891 23.5194 101.334C23.4011 103.344 23.342 105.146 23.342 106.74C23.342 108.23 23.4011 109.98 23.5194 111.99C23.6378 113.966 23.8596 116.01 24.185 118.125C24.54 120.238 25.0133 122.335 25.605 124.415C26.1966 126.459 26.9509 128.296 27.8679 129.925C28.8146 131.519 29.9386 132.819 31.2402 133.824C32.5419 134.829 34.08 135.331 35.855 135.331C38.0144 135.331 39.8189 134.777 41.2684 133.668C42.7475 132.559 43.9455 131.138 44.8625 129.405C45.7795 127.638 46.4451 125.679 46.8593 123.531C47.303 121.348 47.5988 119.182 47.7467 117.033H54.7575C54.7575 120.602 54.373 124.068 53.6039 127.43C52.8643 130.791 51.7106 133.772 50.1428 136.371C48.575 138.97 46.5782 141.067 44.1525 142.661C41.7564 144.22 38.9018 145 35.5887 145C33.0447 145 30.7669 144.394 28.7554 143.181C26.7438 141.968 24.969 140.356 23.4307 138.346C21.9221 136.301 20.6353 133.979 19.5703 131.38C18.5054 128.746 17.6328 126.026 16.9524 123.219C16.272 120.412 15.7691 117.622 15.4437 114.85C15.1479 112.042 15 109.478 15 107.156C15 104.522 15.1331 101.75 15.3994 98.8386C15.6952 95.9275 16.1537 93.0684 16.7749 90.2613C17.4257 87.4195 18.2688 84.7163 19.3041 82.1518C20.369 79.5874 21.6854 77.3347 23.2533 75.394C24.8211 73.4533 26.6699 71.9111 28.7997 70.7674C30.9297 69.5891 33.3701 69 36.1212 69C38.9018 69 41.2388 69.7624 43.132 71.2873C45.0252 72.8121 46.6818 74.9261 48.1017 77.6293L48 69.5H54.5Z" fill="url(#paint2_linear_5_6)"/>
        <path d="M18.9999 135.5C24.9999 148 32.7104 146.922 36.4999 147V156H14.4999C5.99976 156 3.49988 159 3.49988 159C3.49988 159 12.0611 148.584 21.4999 149C21.0447 146.401 19.859 146.84 18.9999 135.5Z" fill="#1C6318"/>
        <defs>
        <linearGradient id="paint0_linear_5_6" x1="125" y1="6.27841" x2="125" y2="172.693" gradientUnits="userSpaceOnUse">
        <stop/>
        <stop offset="1" stop-color="#20721C"/>
        </linearGradient>
        <linearGradient id="paint1_linear_5_6" x1="125" y1="71.4057" x2="125" y2="151.804" gradientUnits="userSpaceOnUse">
        <stop/>
        <stop offset="1" stop-color="#20721C"/>
        </linearGradient>
        <linearGradient id="paint2_linear_5_6" x1="37.8961" y1="68.7519" x2="37.8961" y2="144.752" gradientUnits="userSpaceOnUse">
        <stop/>
        <stop offset="1" stop-color="#20721C"/>
        </linearGradient>
        </defs>
                </svg></a>
            </div>
        </div>
        <a href = "/logout"><button class="log-out-btn">Logout</button></a>
    </div>
</header>
<body>
    <!-- Notification Button -->
    <button class="notification-btn" id="notificationBtn" onclick="openNotification()">
        <svg width="30px" height="auto" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path fill-rule="evenodd" clip-rule="evenodd" d="M6.31317 12.463C6.20006 9.29213 8.60976 6.6252 11.701 6.5C14.7923 6.6252 17.202 9.29213 17.0889 12.463C17.0889 13.78 18.4841 15.063 18.525 16.383C18.525 16.4017 18.525 16.4203 18.525 16.439C18.5552 17.2847 17.9124 17.9959 17.0879 18.029H13.9757C13.9786 18.677 13.7404 19.3018 13.3098 19.776C12.8957 20.2372 12.3123 20.4996 11.701 20.4996C11.0897 20.4996 10.5064 20.2372 10.0923 19.776C9.66161 19.3018 9.42346 18.677 9.42635 18.029H6.31317C5.48869 17.9959 4.84583 17.2847 4.87602 16.439C4.87602 16.4203 4.87602 16.4017 4.87602 16.383C4.91795 15.067 6.31317 13.781 6.31317 12.463Z" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path> <path d="M9.42633 17.279C9.01212 17.279 8.67633 17.6148 8.67633 18.029C8.67633 18.4432 9.01212 18.779 9.42633 18.779V17.279ZM13.9757 18.779C14.3899 18.779 14.7257 18.4432 14.7257 18.029C14.7257 17.6148 14.3899 17.279 13.9757 17.279V18.779ZM12.676 5.25C13.0902 5.25 13.426 4.91421 13.426 4.5C13.426 4.08579 13.0902 3.75 12.676 3.75V5.25ZM10.726 3.75C10.3118 3.75 9.97601 4.08579 9.97601 4.5C9.97601 4.91421 10.3118 5.25 10.726 5.25V3.75ZM9.42633 18.779H13.9757V17.279H9.42633V18.779ZM12.676 3.75H10.726V5.25H12.676V3.75Z" fill="#ffffff"></path> </g></svg>
    </button>

    <!-- Notification Div -->
    <div class="notification" id="notificationDiv">
        <p><span>12312321</span> EUR were sent to blahblahblah</p>
        <button class="close-btn" onclick="closeNotification()">Close</button>
    </div>
    <script> /*for notification button*/
        function openNotification() {
            const notification = document.getElementById('notificationDiv');
            const button = document.getElementById('notificationBtn');
            notification.classList.add('open');
            button.classList.add('hidden');
        }

        function closeNotification() {
            const notification = document.getElementById('notificationDiv');
            const button = document.getElementById('notificationBtn');
            notification.classList.remove('open');
            button.classList.remove('hidden');
        }
    </script>
    <div class="container">
        <h2>MONEY TRANSFER</h2>
        <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
        <% if (request.getAttribute("message") != null) { %>
            <p class="message"><%= request.getAttribute("message") %></p>
        <% } %>
        <c:forEach var="recipient" items="${recipients}">
            <div class="open-button">
                <div class="recipient" onclick="toggleMoneyTransfer(this)">
                    <div class="avatar">${recipient.username.charAt(0)}</div>
                    <div class="info">
                        <p>${recipient.username.toUpperCase()}</p>
                        <small>@${recipient.username}</small>
                    </div>
                </div>
                <div class="money-transfer">
                    <form action="/sendMoney" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <input type="hidden" name="recipientUsername" value="${recipient.username}">
                        <div class="amount-section">
                            <input type="number" name="amount" value="0" min="0.01" step="0.01" required>
                            <p>EUR</p>
                            <button type="submit">SEND</button>
                        </div>
                    </form>
                </div>
            </div>
        </c:forEach>
        <div class="add-recipient">
            <a onclick="toggleAddRecipient()">ADD RECIPIENTS +</a>
            <div class="add-recipient-form">
                <div class="col-2">
                    <form action="/addRecipient" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <div class="input-container">
                            <input type="text" name="recipientUsername" placeholder="Username" required>
                            <span class="mandatory-mark">*</span>
                        </div>
                        <p>* Mandatory</p>
                        <button type="submit">Add using username</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>