<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Form</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Maiden+Orange&display=swap" rel="stylesheet">
    <style>
        .maiden-orange-regular{
        font-family: "Maiden Orange", serif;
        font-weight: 400;
        font-style: normal;
        }
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
        }
        .container {
            text-align: center;
            display:flex;
            flex-direction: column;
        }
        .container>div{
            display: flex;
            justify-content: end;
            width:250px;
            height:0;
            position:relative;
            top:-57px;
        }
        h1 {
            font-size: 100px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        input[type="text"], input[type="password"]{
            display: block;
            width: 250px;
            padding: 10px;
            margin-top: 10px;
            border: 1px solid #ccc;
            border-radius: 20px;
            background-color: #e0e0e0;
            text-align: center;
            font-size: 1em;
            box-sizing: border-box;
        }
        button {
            padding: 10px 20px;
            border: none;
            border-radius: 20px;
            font-size: 1em;
            cursor: pointer;
            height:fit-content;
        }
        .register-btn, input[type="submit"]{
            background-color: #4CAF50;
            color: white;
            width:120px;
            display:flex;
            margin:10px 0px;
            justify-content: center;
            flex-direction: row;
        }
        .register-btn a{
        text-decoration:none;
        color:white;}
        input[type="submit"]{
            padding: 10px 20px;
            border: none;
            border-radius: 20px;
            font-size: 1em;
            cursor: pointer;
        }
        .forgot-btn {
            background-color: #333;
            color: white;
            width: 250px;
            display: block;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="maiden-orange-regular">CARMA</h1>
        <form method = "post" action="login-process">
        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Login" class="login-btn">
            
        </form>
        <div>
            <button class="register-btn"> <a href = "/registration">Register</a></button>
        </div>
        <button class="forgot-btn">Forgot Password</button>
        <pre>${errorMessage}</pre>
    </div>
</body>
</html>
