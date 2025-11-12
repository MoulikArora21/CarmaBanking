<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTP Verification</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
        }
        .container {
            width: 400px;
            text-align: center;
            background-color: #fff;
            padding: 50px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .otp-input {
            display: block;
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 20px;
            background-color: #e0e0e0;
            text-align: center;
            font-size: 1em;
            box-sizing: border-box;
        }
        .timer {
            color: #CCC;
            margin-bottom: 20px;
        }
        .buttons {
            display: flex;
            justify-content: space-between;
        }
        button {
            padding: 10px 20px;
            border: none;
            border-radius: 20px;
            font-size: 1em;
            cursor: pointer;
            width: 120px;
        }
        .exit-btn {
            background-color: #333;
            color: #fff;
        }
        .resend-btn {
            background-color: #CCC;
            color: #fff;
        }
        .resend-btn.enabled {
            background-color: #4CAF50;
            color: #fff;
        }
        .verify-btn {
            background-color: #4CAF50;
            color: white;
        }
        .verify-btn:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }
        .resend-btn:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }
        .error {
            color: red;
        }
        .message {
            color: green;
        }
    </style>
</head>
<body>
    <div class="container">
        <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
        <% if (request.getAttribute("message") != null) { %>
            <p class="message"><%= request.getAttribute("message") %></p>
        <% } %>
        <p>An OTP has been sent to your registered phone <span id="phone-number">${phoneNumber}</span>
        and registered email <span id="email-address">${email}</span></p>
        <form action="/otpverify" method="post" id="otp-form" novalidate>
            <input type="hidden" name="username" value="${username}">
            <input type="text" class="otp-input" name="otp" placeholder="OTP" required>
            <div class="timer">OTP Valid for: <span id="timer">5:00</span> min</div>
            <div class="buttons">
                <a href="/login"><button type="button" class="exit-btn">Exit</button></a>
                <button type="submit" form="resend-form" class="resend-btn" id="resend-btn" disabled>Resend</button>
                <button type="submit" form="otp-form" class="verify-btn" id="verify-btn">Verify</button>
            </div>
        </form>
        <form action="/otpresend" method="post" id="resend-form" novalidate>
            <input type="hidden" name="username" value="${username}">
        </form>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            function startTimer(minutes) {
                const timerElement = document.getElementById('timer');
                const verifyButton = document.getElementById('verify-btn');
                const resendButton = document.getElementById('resend-btn');

                if (!timerElement || !verifyButton || !resendButton) {
                    console.error('Timer elements not found:', {
                        timerElement: !!timerElement,
                        verifyButton: !!verifyButton,
                        resendButton: !!resendButton
                    });
                    return;
                }

                let seconds = minutes * 60;
                console.log('Starting timer with', seconds, 'seconds');

                const interval = setInterval(() => {
                    try {
                        if (seconds <= 0) {
                            clearInterval(interval);
                            timerElement.textContent = '0:00';
                            verifyButton.disabled = true;
                            resendButton.disabled = false;
                            resendButton.classList.add('enabled');
                            console.log('Timer expired');
                            return;
                        }
                        seconds--;
                        const min = Math.floor(seconds / 60);
                        const sec = seconds % 60;
                        timerElement.textContent = min + ':' + (sec < 10 ? '0' : '') + sec;
                        console.log('Timer tick:', min + ':' + (sec < 10 ? '0' : '') + sec);
                    } catch (error) {
                        console.error('Timer error:', error);
                        clearInterval(interval);
                    }
                }, 1000);
            }

            const resendForm = document.getElementById('resend-form');
            if (resendForm) {
                resendForm.addEventListener('submit', function(event) {
                    console.log('Resend form submitted with username:', document.querySelector('#resend-form input[name="username"]').value);
                    console.log('Form action:', this.action);
                    document.querySelector('.otp-input').value = '';
                    startTimer(5);
                    document.getElementById('verify-btn').disabled = false;
                    document.getElementById('resend-btn').disabled = true;
                    document.getElementById('resend-btn').classList.remove('enabled');
                });
            } else {
                console.error('Resend form not found');
            }

            const otpForm = document.getElementById('otp-form');
            if (otpForm) {
                otpForm.addEventListener('submit', function(event) {
                    const username = document.querySelector('#otp-form input[name="username"]').value;
                    const otp = document.querySelector('.otp-input').value;
                    console.log('Verify form submitted with username:', username, 'and OTP:', otp);
                    console.log('Form action:', this.action);
                });
            } else {
                console.error('OTP form not found');
            }

            startTimer(5);
        });
    </script>
</body>
</html>