<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration - CARMA Banking</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .logo-container {
            text-align: center;
            margin-bottom: 40px;
            background: white;
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            display: inline-block;
        }

        .logo-link {
            display: inline-block;
            text-decoration: none;
            transition: opacity 0.2s;
        }

        .logo-link:hover {
            opacity: 0.8;
        }

        .container {
            background: white;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.12);
            width: 100%;
            max-width: 600px;
            text-align: center;
        }

        h2 {
            font-size: 28px;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 8px;
        }

        .subtitle {
            color: #718096;
            margin-bottom: 32px;
            font-size: 16px;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
            align-items: center;
        }

        .columns {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            width: 100%;
        }

        .input-container {
            position: relative;
            width: 100%;
        }

        input {
            width: 100%;
            padding: 14px 20px;
            font-size: 16px;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            background: #f7fafc;
            transition: all 0.2s;
            box-sizing: border-box;
        }

        input:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .phone-container {
            display: flex;
            align-items: center;
        }

        .phone-prefix {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 16px;
            color: #4a5568;
            pointer-events: none;
            z-index: 1;
        }

        .phone-input {
            padding-left: 60px;
        }

        .mandatory-mark {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #e53e3e;
            font-size: 18px;
            font-weight: 600;
            pointer-events: none;
        }

        .error {
            color: #e53e3e;
            font-size: 11px;
            margin-top: 4px;
            display: block;
            text-align: left;
            line-height: 1.4;
            padding: 6px 8px;
            background: #fff5f5;
            border-left: 3px solid #e53e3e;
            border-radius: 4px;
        }

        .mandatory-note {
            font-size: 14px;
            color: #718096;
            margin-bottom: 24px;
        }

        .buttons {
            display: flex;
            justify-content: space-between;
            width: 100%;
            gap: 12px;
        }

        button, input[type="submit"] {
            padding: 14px 24px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            flex: 1;
        }

        .exit-btn {
            background: #f7fafc;
            color: #4a5568;
            border: 1px solid #e2e8f0;
        }

        .exit-btn:hover {
            background: #edf2f7;
        }

        .register-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .register-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(102, 126, 234, 0.3);
        }

        @media (max-width: 768px) {
            .columns {
                grid-template-columns: 1fr;
            }

            .container {
                padding: 24px 16px;
                max-width: 100%;
                margin: 16px;
            }

            .logo-container {
                margin-bottom: 24px;
            }

            h2 {
                font-size: 24px;
            }

            .subtitle {
                font-size: 14px;
            }

            input {
                font-size: 15px;
                padding: 12px 16px;
            }

            .phone-input {
                padding-left: 55px !important;
            }

            .error {
                font-size: 10px;
                padding: 4px 6px;
            }
        }
    </style>
</head>
<body>
    <div class="logo-container">
        <a href="/" class="logo-link">
            <svg height="60px" viewBox="0 0 250 170" fill="none" xmlns="http://www.w3.org/2000/svg">
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
    </div>

    <div class="container">
        <h2>Create Your Account</h2>
        <p class="subtitle">Join CARMA Banking for secure and convenient banking</p>
        <form:form method="post" action="/registration" modelAttribute="user" cssClass="form">
            <div class="columns">
                <div class="input-container">
                    <form:input path="name" cssClass="name-input" placeholder="Name" autocomplete="off"/>
                    <span class="mandatory-mark">*</span>
                    <form:errors path="name" cssClass="error"/>
                </div>
                <div class="input-container">
                    <form:input path="surname" cssClass="surname-input" placeholder="Surname" autocomplete="off"/>
                    <span class="mandatory-mark">*</span>
                    <form:errors path="surname" cssClass="error"/>
                </div>
                <div class="input-container">
                    <form:input path="country" cssClass="country-input" placeholder="Country" list="country-list" autocomplete="off"/>
                    <span class="mandatory-mark">*</span>
                    <form:errors path="country" cssClass="error"/>
                    <datalist id="country-list">
                        <option value="Latvia">
                    </datalist>
                </div>
                <div class="input-container">
                    <form:input path="address" cssClass="address-input" placeholder="Address (optional)" autocomplete="off"/>
                    <form:errors path="address" cssClass="error"/>
                </div>
                <div class="input-container phone-container">
                    <span class="phone-prefix" id="phone-prefix"></span>
                    <form:input path="phoneNumber" cssClass="phone-input" placeholder="Phone number" autocomplete="off"/>
                    <span class="mandatory-mark">*</span>
                    <form:errors path="phoneNumber" cssClass="error"/>
                </div>
                <div class="input-container">
                    <form:input path="email" cssClass="email-input" placeholder="Email" autocomplete="off"/>
                    <span class="mandatory-mark">*</span>
                    <form:errors path="email" cssClass="error"/>
                </div>
                <div class="input-container">
                    <form:input path="username" cssClass="username-input" placeholder="Username" autocomplete="off"/>
                    <span class="mandatory-mark">*</span>
                    <form:errors path="username" cssClass="error"/>
                </div>
                <div class="input-container">
                    <form:input path="personalId" cssClass="id-input" placeholder="Personal ID (optional)" autocomplete="off"/>
                    <form:errors path="personalId" cssClass="error"/>
                </div>
                <div class="input-container">
                    <form:password path="password" cssClass="password-input" placeholder="Password" autocomplete="off"/>
                    <span class="mandatory-mark">*</span>
                    <form:errors path="password" cssClass="error"/>
                </div>
                <div class="input-container">
                    <form:password path="confirmPassword" cssClass="confirm-input" placeholder="Confirm password" autocomplete="off"/>
                    <span class="mandatory-mark">*</span>
                    <form:errors path="confirmPassword" cssClass="error"/>
                </div>
            </div>
            <p class="mandatory-note">* Mandatory fields</p>
            <div class="buttons">
                <button type="button" class="exit-btn" onclick="window.location.href='/login'">Back to Login</button>
                <input type="submit" value="Create Account" class="register-btn"/>
            </div>
        </form:form>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const countryInput = document.querySelector('.country-input');
            const phoneInput = document.querySelector('.phone-input');
            const phonePrefix = document.querySelector('#phone-prefix');

            countryInput.addEventListener('input', function() {
                const selectedCountry = countryInput.value.trim();
                if (selectedCountry === 'Latvia') {
                    phonePrefix.textContent = '+371';
                    phoneInput.style.paddingLeft = '60px';
                    phoneInput.placeholder = 'Enter number';
                } else {
                    phonePrefix.textContent = '';
                    phoneInput.style.paddingLeft = '20px';
                    phoneInput.placeholder = 'Phone number';
                }
            });

            countryInput.addEventListener('change', function() {
                if (!countryInput.value) {
                    phonePrefix.textContent = '';
                    phoneInput.style.paddingLeft = '20px';
                    phoneInput.placeholder = 'Phone number';
                }
            });

            document.querySelector('form').addEventListener('submit', function() {
                if (countryInput.value.trim() === 'Latvia' && phoneInput.value) {
                    phoneInput.value = '+371' + phoneInput.value.replace(/^\+371/, '');
                }
            });
        });
    </script>
</body>
</html>