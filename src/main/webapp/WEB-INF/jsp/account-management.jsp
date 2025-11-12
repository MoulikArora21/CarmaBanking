<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account management</title>
    <style>
        /*header*/
        header{
            width:100%;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
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
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            background-color: #ffffff;
            flex-direction: column;
        }
        .container {
            margin-top:100px;
            background-color: #ffffff;
            border-radius: 15px;
            padding: 20px;
            width: 80%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .container>div{
            margin-bottom:20px;
            background-color: #333;
            border-radius: 15px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
        }
        .button{
            text-align: center;
            background-color: #333;
            border-radius: 10px;
            padding: 10px;
            color:white;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .button .arrow {
            margin-right: 10px;
            font-size: 12px;
        }
        .open{
            background-color: #ccc;
            border-radius: 0 0 10px 10px;
            padding: 10px;
            display: none;
        }
        .personal-details .open.visible {
            display: flex;
            flex-direction: row;
            flex-wrap: wrap;
        }
        .personal-details .open .col{
            width:50%;
        }
        .personal-details .open .icon-row {
            width: 100%;
            background-color: #ccc;
            padding: 10px;
            display: flex;
            justify-content: end;
            gap: 10px;
        }
        .reports .row{
            display:flex;
        }
        .reports .row p{
            width:50%;
        }
        .reports form div:last-child{
            display:flex;
            flex-direction: column;
            align-items: center;
        }
        .generate-btn{
            background-color: #4CAF50;
            padding: 10px 20px;
            border: none;
            border-radius: 20px;
            font-size: 1em;
            cursor: pointer;
            color:white;
            margin-top: 20px;
            width:200px;
        }
    </style>
</head>
<header>
    <div>
        <div>
            <button class="back-button" onclick="history.back()">
                <svg width="30px" height="auto" viewBox="0 -6.5 36 36" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" fill="#000000"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <title>left-arrow</title> <desc>Created with Sketch.</desc> <g id="icons" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"> <g id="ui-gambling-website-lined-icnos-casinoshunter" transform="translate(-342.000000, -159.000000)" fill="white" fill-rule="nonzero"> <g id="square-filled" transform="translate(50.000000, 120.000000)"> <path d="M317.108012,39.2902857 L327.649804,49.7417043 L327.708994,49.7959169 C327.889141,49.9745543 327.986143,50.2044182 328,50.4382227 L328,50.5617773 C327.986143,50.7955818 327.889141,51.0254457 327.708994,51.2040831 L327.6571,51.2479803 L317.108012,61.7097143 C316.717694,62.0967619 316.084865,62.0967619 315.694547,61.7097143 C315.30423,61.3226668 315.30423,60.6951387 315.694547,60.3080911 L324.702666,51.3738496 L292.99947,51.3746291 C292.447478,51.3746291 292,50.9308997 292,50.3835318 C292,49.8361639 292.447478,49.3924345 292.99947,49.3924345 L324.46779,49.3916551 L315.694547,40.6919089 C315.30423,40.3048613 315.30423,39.6773332 315.694547,39.2902857 C316.084865,38.9032381 316.717694,38.9032381 317.108012,39.2902857 Z M327.115357,50.382693 L316.401279,61.0089027 L327.002151,50.5002046 L327.002252,50.4963719 L326.943142,50.442585 L326.882737,50.382693 L327.115357,50.382693 Z" id="left-arrow" transform="translate(310.000000, 50.500000) scale(-1, 1) translate(-310.000000, -50.500000) "> </path> </g> </g> </g> </g></svg>
                <p>Go Back</p>
            </button>
            <div id="logo-btn">
                <a href="KARMA-main-page.html"><svg width="auto" height="50px" viewBox="0 0 250 170" fill="none" xmlns="http://www.w3.org/2000/svg">
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
        <button class="log-out-btn">Logout</button>
    </div>
</header>
<body>
    <div class="container">
        <h2>Account management</h2>
        <div class="personal-details">
            <div class="button">
                <span class="arrow">▶</span>
                <p>Personal details</p>
            </div>
            <div class="open">
                <div class="col">
                    <p>Full Name: <span>$name</span></p>
                    <p>Date of Birth: <span>$birth</span></p>
                    <p>Phone number: <span>$phone</span></p>
                </div>
                <div class="col">
                    <p>Address: <span>$address</span></p>
                    <p>Personal ID: <span>$id</span></p>
                    <p>Email: <span>$email</span></p>
                </div>
                <div class="icon-row">
                    <svg width="20px" height="auto" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">

<g id="SVGRepo_bgCarrier" stroke-width="0"/>

<g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"/>

<g id="SVGRepo_iconCarrier"> <path d="M2.99902 3L20.999 21M9.8433 9.91364C9.32066 10.4536 8.99902 11.1892 8.99902 12C8.99902 13.6569 10.3422 15 11.999 15C12.8215 15 13.5667 14.669 14.1086 14.133M6.49902 6.64715C4.59972 7.90034 3.15305 9.78394 2.45703 12C3.73128 16.0571 7.52159 19 11.9992 19C13.9881 19 15.8414 18.4194 17.3988 17.4184M10.999 5.04939C11.328 5.01673 11.6617 5 11.9992 5C16.4769 5 20.2672 7.94291 21.5414 12C21.2607 12.894 20.8577 13.7338 20.3522 14.5" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/> </g>

                    </svg>
                    <svg width="20px" height="auto" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">

                <g id="SVGRepo_bgCarrier" stroke-width="0"/>

                <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"/>

                <g id="SVGRepo_iconCarrier"> <path d="M21.2799 6.40005L11.7399 15.94C10.7899 16.89 7.96987 17.33 7.33987 16.7C6.70987 16.07 7.13987 13.25 8.08987 12.3L17.6399 2.75002C17.8754 2.49308 18.1605 2.28654 18.4781 2.14284C18.7956 1.99914 19.139 1.92124 19.4875 1.9139C19.8359 1.90657 20.1823 1.96991 20.5056 2.10012C20.8289 2.23033 21.1225 2.42473 21.3686 2.67153C21.6147 2.91833 21.8083 3.21243 21.9376 3.53609C22.0669 3.85976 22.1294 4.20626 22.1211 4.55471C22.1128 4.90316 22.0339 5.24635 21.8894 5.5635C21.7448 5.88065 21.5375 6.16524 21.2799 6.40005V6.40005Z" stroke="black" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/> <path d="M11 4H6C4.93913 4 3.92178 4.42142 3.17163 5.17157C2.42149 5.92172 2 6.93913 2 8V18C2 19.0609 2.42149 20.0783 3.17163 20.8284C3.92178 21.5786 4.93913 22 6 22H17C19.21 22 20 20.2 20 18V13" stroke="black" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/> </g>

                    </svg>
                </div>
            </div>
        </div>
        <div class="reports">
            <div class="button">
                <span class="arrow">▶</span>
                <p>Reports</p>
            </div>
            <div class="open">
                <p>Statement: <span>$statement</span></p>
                <form>
                    <div class="row">
                        <p>Start Date: <input type="date" class="date-picker" id="yearPicker"></p>
                        <p>End date: <input type="date" class="date-picker" id="yearPicker"></p>
                    </div>
                    <div>
                        <button class="generate-btn">Generate</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="terms">
            <div class="button">
                <p>Terms and Conditions</p>
            </div>
        </div>
        <div class="delete-account">
            <div class="button">
                <p>Delete Account</p>
            </div>
        </div>
    </div>
    <script>
        // Get all elements with class 'button'
        const buttons = document.querySelectorAll('.button');

        // Add click event listener to each button
        buttons.forEach(button => {
            button.addEventListener('click', () => {
                // Find the sibling .open element and the arrow
                const openSection = button.nextElementSibling;
                const arrow = button.querySelector('.arrow');
                // Check if it's the personal-details or reports section
                const isPersonalDetails = button.parentElement.classList.contains('personal-details');
                // Toggle display
                if (openSection.style.display === 'none' || openSection.style.display === '') {
                    openSection.style.display = isPersonalDetails ? 'flex' : 'block';
                    if (isPersonalDetails) openSection.classList.add('visible');
                    arrow.textContent = '▼';
                } else {
                    openSection.style.display = 'none';
                    if (isPersonalDetails) openSection.classList.remove('visible');
                    arrow.textContent = '▶';
                }
            });
        });
    </script>
</body>
</html>