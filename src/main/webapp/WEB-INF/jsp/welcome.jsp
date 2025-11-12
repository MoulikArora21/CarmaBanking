<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.ZoneId" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Maiden+Orange&display=swap" rel="stylesheet">
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
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        h2{
            margin-top: 100px;
            text-align: center;
            position:absolute;
            top:120px;
            font-size:80px;
            font-family: "Maiden Orange", serif;
	        font-weight: 400;
	        font-style: normal;
        }
        .container{
            margin-top:120px;
            width:80%;
            display:flex;
            flex-direction: row;
            padding: 50px;
            border-radius: 10px;
        }
        .col-1{
            display:flex;
            flex-direction: column;
            height:fit-content;
            gap:10px;
            border-radius: 20px 0 0 20px;
            margin-right:20px
        }
        .col-1 div{
           background-color: #4CAF50;
           padding:20px;
           border-radius: 20px;
           width:fit-content;
           cursor: pointer;
        }
        .col-2{
            background-color:#ccc;
            border-radius: 10px;
            text-align: center;
            flex-grow: 1;
            display:flex;
            flex-direction: column;
            align-items: center;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .col-2 div{
            margin:20px;
            background-color: #ffffff;
            border-radius: 10px;
            width:80%;
        }
        .send-btn a{
            color:white;
            text-decoration:none;
        }
        .buttons{
            display:flex;
            gap:20px;
            justify-content:center;
            width:440px;
            background-color: #ccc !important;
        }
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
        .balance{
            display:flex;
            flex-direction: column;
            align-items: center;
        }
        .acc-balance{
            background-color: #333 !important;
            color:white;
            width:400px;
            border-radius: 10px;
            padding:5px;
        }
        .account-number{
            background-color: #333 !important;
            color:white;
            width:400px;
            border-radius: 10px;
            padding:5px;
        }
        .history{
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 0 20px;
            box-sizing: border-box;
        }
        .history .row{
            display: flex;
            justify-content:space-between;
            width:100%;
            margin:0;
            border-top: 1px solid #333;
            border-radius: 0;
        }
        .history a{
            color:unset;
            text-decoration: none;
        }
        .history a:hover{
            text-decoration: underline;
        }
    </style>
</head>
<header>
    <div>
        <div>
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
        <div class="col-1">
            <div class="profile">
                <a href = "/account-management"><svg width="30px" height="auto" viewBox="0 0 20 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" fill="#000000">

                <g id="SVGRepo_bgCarrier" stroke-width="0"/>

                <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"/>

                <g id="SVGRepo_iconCarrier"> <title>profile_round [#ffffff]</title> <desc>Created with Sketch.</desc> <defs> </defs> <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"> <g id="Dribbble-Light-Preview" transform="translate(-140.000000, -2159.000000)" fill="#ffffff"> <g id="icons" transform="translate(56.000000, 160.000000)"> <path d="M100.562548,2016.99998 L87.4381713,2016.99998 C86.7317804,2016.99998 86.2101535,2016.30298 86.4765813,2015.66198 C87.7127655,2012.69798 90.6169306,2010.99998 93.9998492,2010.99998 C97.3837885,2010.99998 100.287954,2012.69798 101.524138,2015.66198 C101.790566,2016.30298 101.268939,2016.99998 100.562548,2016.99998 M89.9166645,2004.99998 C89.9166645,2002.79398 91.7489936,2000.99998 93.9998492,2000.99998 C96.2517256,2000.99998 98.0830339,2002.79398 98.0830339,2004.99998 C98.0830339,2007.20598 96.2517256,2008.99998 93.9998492,2008.99998 C91.7489936,2008.99998 89.9166645,2007.20598 89.9166645,2004.99998 M103.955674,2016.63598 C103.213556,2013.27698 100.892265,2010.79798 97.837022,2009.67298 C99.4560048,2008.39598 100.400241,2006.33098 100.053171,2004.06998 C99.6509769,2001.44698 97.4235996,1999.34798 94.7348224,1999.04198 C91.0232075,1998.61898 87.8750721,2001.44898 87.8750721,2004.99998 C87.8750721,2006.88998 88.7692896,2008.57398 90.1636971,2009.67298 C87.1074334,2010.79798 84.7871636,2013.27698 84.044024,2016.63598 C83.7745338,2017.85698 84.7789973,2018.99998 86.0539717,2018.99998 L101.945727,2018.99998 C103.221722,2018.99998 104.226185,2017.85698 103.955674,2016.63598" id="profile_round-[#ffffff]"> </path> </g> </g> </g> </g>

                </svg></a>
            </div>
            <div class="cards">
                <svg width="30px" height="auto" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">

                <g id="SVGRepo_bgCarrier" stroke-width="0"/>

                <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"/>

                <g id="SVGRepo_iconCarrier"> <path d="M2 12.6101H19" stroke="#ffffff" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"/> <path d="M19 10.28V17.43C18.97 20.28 18.19 21 15.22 21H5.78003C2.76003 21 2 20.2501 2 17.2701V10.28C2 7.58005 2.63 6.71005 5 6.57005C5.24 6.56005 5.50003 6.55005 5.78003 6.55005H15.22C18.24 6.55005 19 7.30005 19 10.28Z" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/> <path d="M22 6.73V13.72C22 16.42 21.37 17.29 19 17.43V10.28C19 7.3 18.24 6.55 15.22 6.55H5.78003C5.50003 6.55 5.24 6.56 5 6.57C5.03 3.72 5.81003 3 8.78003 3H18.22C21.24 3 22 3.75 22 6.73Z" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/> <path d="M5.25 17.8101H6.96997" stroke="#ffffff" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"/> <path d="M9.10986 17.8101H12.5499" stroke="#ffffff" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"/> </g>

                </svg>
            </div>
            <div class="stocks">
                <svg width="30px" height="auto" fill="#ffffff" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 94.667 94.667" xml:space="preserve" stroke="#ffffff">

                <g id="SVGRepo_bgCarrier" stroke-width="0"/>

                <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"/>

                <g id="SVGRepo_iconCarrier"> <g> <g> <path d="M82.413,9.146h9.346V83.33h-9.346V9.146z M63.803,11.831l-1.294,0.402c-1.62,0.512-3.524-0.201-4.179-1.558 c-0.314-0.657-0.329-1.383-0.041-2.047c0.334-0.768,1.044-1.369,1.945-1.65l14.591-4.545l1.776,13.001 c0.1,0.662-0.086,1.338-0.525,1.898c-0.537,0.688-1.4,1.134-2.368,1.226c-0.116,0.012-0.246,0.018-0.371,0.018 c-1.651,0-3.053-1.052-3.261-2.444l-0.225-1.967C52.988,37.514,14.157,62.539,12.472,63.617c-0.572,0.366-1.256,0.561-1.98,0.561 c-0.976,0-1.894-0.36-2.517-0.991c-0.573-0.577-0.841-1.313-0.758-2.069c0.087-0.785,0.558-1.507,1.294-1.975 C8.906,58.889,47.367,34.026,63.803,11.831z M74.859,25.623v57.705h-9.344V25.623H74.859z M58.518,42.77v40.56h-9.347V42.77 H58.518z M41.617,60.583v22.744h-9.345V60.583H41.617z M23.75,69.494v13.834h-9.344V69.494H23.75z M94.666,92.234H0V85.3h94.667 L94.666,92.234L94.666,92.234z"/> </g> </g> </g>

                </svg>
            </div>
            <div class="help"> 
                <svg width="30px" height="auto" version="1.1" id="_x32_" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 512 512" xml:space="preserve" fill="#000000">
                <g id="SVGRepo_bgCarrier" stroke-width="0"/>
                <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"/>
                <g id="SVGRepo_iconCarrier"> <style type="text/css"> .st0{fill:#ffffff;} </style> <g> <path class="st0" d="M396.138,85.295c-13.172-25.037-33.795-45.898-59.342-61.03C311.26,9.2,280.435,0.001,246.98,0.001 c-41.238-0.102-75.5,10.642-101.359,25.521c-25.962,14.826-37.156,32.088-37.156,32.088c-4.363,3.786-6.824,9.294-6.721,15.056 c0.118,5.77,2.775,11.186,7.273,14.784l35.933,28.78c7.324,5.864,17.806,5.644,24.875-0.518c0,0,4.414-7.978,18.247-15.88 c13.91-7.85,31.945-14.173,58.908-14.258c23.517-0.051,44.022,8.725,58.016,20.717c6.952,5.941,12.145,12.594,15.328,18.68 c3.208,6.136,4.379,11.5,4.363,15.574c-0.068,13.766-2.742,22.77-6.603,30.442c-2.945,5.729-6.789,10.813-11.738,15.744 c-7.384,7.384-17.398,14.207-28.634,20.479c-11.245,6.348-23.365,11.932-35.612,18.68c-13.978,7.74-28.77,18.858-39.701,35.544 c-5.449,8.249-9.71,17.686-12.416,27.641c-2.742,9.964-3.98,20.412-3.98,31.071c0,11.372,0,20.708,0,20.708 c0,10.719,8.69,19.41,19.41,19.41h46.762c10.719,0,19.41-8.691,19.41-19.41c0,0,0-9.336,0-20.708c0-4.107,0.467-6.755,0.917-8.436 c0.773-2.512,1.206-3.14,2.47-4.668c1.29-1.452,3.895-3.674,8.698-6.331c7.019-3.946,18.298-9.276,31.07-16.176 c19.121-10.456,42.367-24.646,61.972-48.062c9.752-11.686,18.374-25.758,24.323-41.968c6.001-16.21,9.242-34.431,9.226-53.96 C410.243,120.761,404.879,101.971,396.138,85.295z"/> <path class="st0" d="M228.809,406.44c-29.152,0-52.788,23.644-52.788,52.788c0,29.136,23.637,52.772,52.788,52.772 c29.136,0,52.763-23.636,52.763-52.772C281.572,430.084,257.945,406.44,228.809,406.44z"/> </g> </g>
                </svg>
            </div>
        </div>
        <div class="col-2">
                <h2>Hello ${username}</h2>
            <div class="balance">
                <p>Balance
                <svg width="15px" height="auto" viewBox="0 0 24 24" fill="none"       xmlns="http://www.w3.org/2000/svg">

                <g id="SVGRepo_bgCarrier" stroke-width="0"/>

                <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"/>

                <g id="SVGRepo_iconCarrier"> <path d="M2.99902 3L20.999 21M9.8433 9.91364C9.32066 10.4536 8.99902 11.1892 8.99902 12C8.99902 13.6569 10.3422 15 11.999 15C12.8215 15 13.5667 14.669 14.1086 14.133M6.49902 6.64715C4.59972 7.90034 3.15305 9.78394 2.45703 12C3.73128 16.0571 7.52159 19 11.9992 19C13.9881 19 15.8414 18.4194 17.3988 17.4184M10.999 5.04939C11.328 5.01673 11.6617 5 11.9992 5C16.4769 5 20.2672 7.94291 21.5414 12C21.2607 12.894 20.8577 13.7338 20.3522 14.5" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/> </g>

                </svg></p>
                <div class="acc-balance">${balance}</div>
                <p>EUR
                <svg height="auto" width="15px" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" 
    viewBox="0 0 512 512" xml:space="preserve">
<circle style="fill:#0052B4;" cx="256" cy="256" r="256"/>
<g>
    <polygon style="fill:#FFDA44;" points="256.001,100.174 264.29,125.683 291.11,125.683 269.411,141.448 277.7,166.957 
        256.001,151.191 234.301,166.957 242.59,141.448 220.891,125.683 247.712,125.683 	"/>
    <polygon style="fill:#FFDA44;" points="145.814,145.814 169.714,157.99 188.679,139.026 184.482,165.516 208.381,177.693 
        181.89,181.889 177.694,208.381 165.517,184.482 139.027,188.679 157.992,169.714 	"/>
    <polygon style="fill:#FFDA44;" points="100.175,256 125.684,247.711 125.684,220.89 141.448,242.59 166.958,234.301 151.191,256 
        166.958,277.699 141.448,269.411 125.684,291.11 125.684,264.289 	"/>
    <polygon style="fill:#FFDA44;" points="145.814,366.186 157.991,342.286 139.027,323.321 165.518,327.519 177.693,303.62 
        181.89,330.111 208.38,334.307 184.484,346.484 188.679,372.974 169.714,354.009 	"/>
    <polygon style="fill:#FFDA44;" points="256.001,411.826 247.711,386.317 220.891,386.317 242.591,370.552 234.301,345.045 
        256.001,360.809 277.7,345.045 269.411,370.552 291.11,386.317 264.289,386.317 	"/>
    <polygon style="fill:#FFDA44;" points="366.187,366.186 342.288,354.01 323.322,372.975 327.519,346.483 303.622,334.307 
        330.112,330.111 334.308,303.62 346.484,327.519 372.974,323.321 354.009,342.288 	"/>
    <polygon style="fill:#FFDA44;" points="411.826,256 386.317,264.289 386.317,291.11 370.552,269.41 345.045,277.699 360.81,256 
        345.045,234.301 370.553,242.59 386.317,220.89 386.317,247.712 	"/>
    <polygon style="fill:#FFDA44;" points="366.187,145.814 354.01,169.714 372.975,188.679 346.483,184.481 334.308,208.38 
        330.112,181.889 303.622,177.692 327.519,165.516 323.322,139.027 342.289,157.991 	"/>
</g>
                </svg>
                </p>
                <div class="account-number">${account1} ${account2} ${account3}</div>
            </div>
            <div class="buttons">
                <button class="send-btn" >
                    <a href="/recipients"><p>Send</p></a>
                    <svg width="40px" height="auto" viewBox="0 0 55 58" fill="none" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
    <rect width="54.1333" height="58" fill="url(#pattern0_15_20)"/>
    <defs>
    <pattern id="pattern0_15_20" patternContentUnits="objectBoundingBox" width="1" height="1">
    <use xlink:href="#image0_15_20" transform="matrix(0.00712666 0 0 0.00665155 -3.02875 -0.822222)"/>
    </pattern>
    <image id="image0_15_20" width="566" height="441" preserveAspectRatio="none" xlink:href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAjYAAAG5CAYAAACduH6lAAAAAXNSR0IArs4c6QAAIABJREFUeAHt3flzF3We+HH3uzsz6ngrouIBiKKcwXDIBPAjAUII4Qh+JITDcIXLQMIRQGH2IwMEUAkVjBhFYxiQqk+NsngweEyldse15oeUFjPFjha76w9WTU3t/LD/wfKtV8ammqaPd3e/+/gkT6qo7k8f7369H+93+nz3u6+7jn8IIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAII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QAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEOgDAv8f4YwL+oZO0BkAAAAASUVORK5CYII="/>
    </defs>
                    </svg>
                </button>
                <button class="receive">
                    <p>Receive</p>
                    <svg width="40px" height="auto" viewBox="0 0 67 73" fill="none" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <rect width="66.9554" height="73" fill="url(#pattern0_15_23)"/>
                    <defs>
                    <pattern id="pattern0_15_23" patternContentUnits="objectBoundingBox" width="1" height="1">
                    <use xlink:href="#image0_15_23" transform="matrix(0.00694444 0 0 0.00636943 -1.90278 -0.789809)"/>
                    </pattern>
                    <image id="image0_15_23" width="566" height="441" preserveAspectRatio="none" xlink:href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAjYAAAG5CAYAAACduH6lAAAAAXNSR0IArs4c6QAAIABJREFUeAHt3flzF3We+HH3uzsz6ngrouIBiKKcwXDIBPAjAUII4Qh+JITDcIXLQMIRQGH2IwMEUAkVjBhFYxiQqk+NsngweEyldse15oeUFjPFjha76w9WTU3t/LD/wfKtV8ammqaPd3e/+/gkT6qo7k8f7369H+93+nz3u6+7jn8IIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggggAACCCCAAAII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QAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEOgDAv8f4YwL+oZO0BkAAAAASUVORK5CYII="/>
                    </defs>
                    </svg>
                </button>
            </div>
<div class="history">
            <a href="/transactions"><h3>History</h3></a>
            <c:choose>
                <c:when test="${empty transactions}">
                    <p>No recent transactions.</p>
                </c:when>
                <c:otherwise>
                    <c:forEach var="transaction" items="${transactions}">
                        <%-- Convert LocalDateTime to Date for fmt:formatDate --%>
                        <c:set var="transactionDate" value="${transaction.date}"/>
                        <% 
                            LocalDateTime localDateTime = (LocalDateTime) pageContext.getAttribute("transactionDate");
                            Date date = Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
                            pageContext.setAttribute("dateAsDate", date);
                        %>
                        <div class="row">
                            <p class="${transaction.type == 'Debit' ? 'negative' : ''}">
                                <fmt:formatNumber value="${transaction.amount}" minFractionDigits="2" maxFractionDigits="2" var="formattedAmount"/>
                                <c:out value="${transaction.type == 'Debit' ? '-' : '+'}${formattedAmount} ${transaction.currency}"/>
                            </p>
                            <p>
                                <c:out value="${transaction.senderUsername == username ? transaction.recipientUsername : transaction.senderUsername}"/>
                            </p>
                            <p>
                                <c:choose>
                                    <c:when test="${transaction.date.toLocalDate() == today}">
                                        Today, <fmt:formatDate value="${dateAsDate}" pattern="HH:mm"/>
                                    </c:when>
                                    <c:when test="${transaction.date.toLocalDate() == yesterday}">
                                        Yesterday, <fmt:formatDate value="${dateAsDate}" pattern="HH:mm"/>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatDate value="${dateAsDate}" pattern="MMM dd, HH:mm"/>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
</body>
</html>