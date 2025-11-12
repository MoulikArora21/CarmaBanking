<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Form</title>
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
        form > p {
            color: red;
        }
        form {
            display: flex;
            gap: 10px;
            flex-direction: column;
            align-items: center;
        }
        .buttons {
            display: flex;
            justify-content: space-between;
            width: 100%;
            margin-top: 10px;
        }
        button, input[type="submit"] {
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
        .register-btn {
            background-color: #4CAF50;
            color: white;
        }
        .input-container {
            position: relative;
            display: inline-block;
            margin-bottom: 10px;
        }
        input {
            padding: 10px 20px 10px 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 20px;
            background-color: #e0e0e0;
            width: 200px;
            box-sizing: border-box;
            text-align: center;
        }
        .phone-container {
            display: flex;
            align-items: center;
            position: relative;
        }
        .phone-prefix {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 16px;
            color: #333;
            pointer-events: none;
        }
        .phone-input {
            padding-left: 50px;
            text-align: left;
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
        .columns {
            display: flex;
            flex-direction: row;
            gap: 10px;
        }
        .error {
            color: red;
            font-size: 12px;
            display: block;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Registration Form</h2>
        <form:form method="post" action="/registration" modelAttribute="user" cssClass="form">
            <form:errors path="*" cssClass="error" element="div"/> <!-- Global errors (e.g., PasswordMatch) -->
            <div class="columns">
                <div class="col-1">
                    <div class="input-container">
                        <form:input path="name" cssClass="name-input" placeholder="Name"/>
                        <span class="mandatory-mark">*</span>
                        <form:errors path="name" cssClass="error"/>
                    </div>
                    <div class="input-container">
                        <form:input path="country" cssClass="country-input" placeholder="Country" list="country-list"/>
                        <span class="mandatory-mark">*</span>
                        <form:errors path="country" cssClass="error"/>
                        <datalist id="country-list">
                            <option value="Latvia">
                        </datalist>
                    </div>
                    <div class="input-container phone-container">
                        <span class="phone-prefix" id="phone-prefix"></span>
                        <form:input path="phone_number" cssClass="phone-input" placeholder="Phone number"/>
                        <span class="mandatory-mark">*</span>
                        <form:errors path="phone_number" cssClass="error"/>
                    </div>
                    <div class="input-container">
                        <form:input path="username" cssClass="username-input" placeholder="Username"/>
                        <span class="mandatory-mark">*</span>
                        <form:errors path="username" cssClass="error"/>
                    </div>
                    <div class="input-container">
                        <form:password path="password" cssClass="password-input" placeholder="Password"/>
                        <span class="mandatory-mark">*</span>
                        <form:errors path="password" cssClass="error"/>
                    </div>
                </div>
                <div class="col-2">
                    <div class="input-container">
                        <form:input path="surname" cssClass="surname-input" placeholder="Surname"/>
                        <span class="mandatory-mark">*</span>
                        <form:errors path="surname" cssClass="error"/>
                    </div>
                    <div class="input-container">
                        <form:input path="address" cssClass="address-input" placeholder="Address (optional)"/>
                        <form:errors path="address" cssClass="error"/>
                    </div>
                    <div class="input-container">
                        <form:input path="email" cssClass="email-input" placeholder="Email"/>
                        <span class="mandatory-mark">*</span>
                        <form:errors path="email" cssClass="error"/>
                    </div>
                    <div class="input-container">
                        <form:input path="personalid" cssClass="id-input" placeholder="Personal ID (optional)"/>
                        <form:errors path="personalid" cssClass="error"/>
                    </div>
                    <div class="input-container">
                        <form:password path="confirm_password" cssClass="confirm-input" placeholder="Confirm password"/>
                        <span class="mandatory-mark">*</span>
                        <form:errors path="confirm_password" cssClass="error"/>
                    </div>
                </div>
            </div>
            <p>* Mandatory</p>
            <div class="buttons">
                <button type="button" class="exit-btn" onclick="window.location.href='/login'">Exit</button>
                <input type="submit" value="Register" class="register-btn"/>
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
                    phoneInput.style.paddingLeft = '50px';
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