<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Private Chat</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs/lib/stomp.min.js"></script>
<style>
    .chat-container {
        height: 70vh;
        overflow-y: auto;
        padding: 10px;
        background-color: #f1f1f1;
    }
    .message {
        margin: 10px 0;
        padding: 10px;
        border-radius: 10px;
        max-width: 60%; /* 말풍선의 최대 너비를 설정 */
        word-wrap: break-word; /* 단어가 너무 길 경우 줄바꿈 처리 */
        clear: both; /* 이전 플로트 요소에 영향을 받지 않도록 설정 */
    }
    .message.received {
        background-color: #e9ecef;
        text-align: left;
        float: left; /* 수신자 메시지를 왼쪽에 정렬 */
    }
    .message.sent {
        background-color: #007bff;
        color: white;
        text-align: right;
        float: right; /* 발신자 메시지를 오른쪽에 정렬 */
    }
    .timestamp {
        font-size: 0.75rem;
        color: #ffffff; /* 발신자 메시지의 시간 색상을 흰색으로 설정 */
        display: block;
        margin-top: 5px;
    }
    .timestamp.received {
        color: #6c757d; /* 수신자 메시지의 시간 색상 설정 */
    }
    .date-header {
        text-align: center;
        font-size: 1rem;
        font-weight: bold;
        margin-bottom: 15px;
        color: #000000; /* 날짜 색상을 검정색으로 설정 */
    }
</style>
<script type="text/javascript">
    $(document).ready(function() {
        var socket = new SockJS('/ws');
        var stompClient = Stomp.over(socket);

        stompClient.connect({}, function(frame) {
            console.log('Connected: ' + frame);

            // 오늘 날짜 표시
            var today = new Date();
            var dateString = today.toLocaleDateString('ko-KR', { year: 'numeric', month: 'long', day: 'numeric' });
            $('#show').append('<div class="date-header">' + dateString + '</div>');

            // 메시지 구독
            stompClient.subscribe('/topic/greetings', function(greeting){
                var obj = JSON.parse(greeting.body);
                var curName = document.getElementById('curName').value;
                var receivedName = obj.name;
                var targetName = obj.targetName;
                var time = new Date(obj.time).toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' });

                if (curName == targetName) {
                    addMessage(receivedName, obj.msg, time, 'received');
                }
            });
        });

        $('#sendButton').click(function() {
            sendName();
        });

        $('#msg').keypress(function(e) {
            if (e.which == 13) { // 엔터 키
                sendName();
                return false; // 엔터 키의 기본 동작 방지 (줄 바꿈)
            }
        });

        function sendName() {
            var msg = document.getElementById('msg').value.trim();

            if (msg === "") {
                alert("메시지를 입력하세요.");
                return;
            }

            var name = document.getElementById('curName').value; 
            var targetName = document.getElementById('name').value; 
            var time = new Date().toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' });
            addMessage(name, msg, time, 'sent');
            stompClient.send("/app/hello", {}, JSON.stringify({'name': name, 'targetName': targetName, 'msg': msg, 'time': new Date().getTime()}));
            document.getElementById('msg').value = ''; // 메시지 입력 후 필드 초기화
        }



        function addMessage(sender, message, time, type) {
            var timeClass = type === 'sent' ? 'timestamp' : 'timestamp received';
            var messageContainer = $('<div>').addClass('message ' + type)
                                             .html(sender + ': ' + message + '<span class="' + timeClass + '">' + time + '</span>');
            $('#show').append(messageContainer);
            $('.chat-container').scrollTop($('.chat-container')[0].scrollHeight); // 스크롤바 하단으로
        }
    });
</script>
</head>
<body>
<div class="container mt-5">
    <div class="card">
        <div class="card-header">
            <h3>개인 채팅</h3>
        </div>
        <div class="card-body">
            <div class="mb-3">
                <label for="curName" class="form-label">발신자</label>
                <input type="text" id="curName" class="form-control" value="${userNickname}" readonly>
            </div>
            <div class="mb-3">
                <label for="name" class="form-label">수신자</label>
                <input type="text" id="name" class="form-control" placeholder="수신자 닉네임을 입력하세요. (영어: 대소문자 구분해야함)">
            </div>
            <div class="chat-container" id="show">
                <!-- 채팅 메시지들이 이곳에 표시됩니다 -->
            </div>
            <div class="mt-3">
                <input type="text" id="msg" class="form-control" placeholder="메시지를 입력하세요">
            </div>
            <button type="button" id="sendButton" class="btn btn-primary mt-2">전송</button>
        </div>
    </div>
</div>
</body>
</html>
