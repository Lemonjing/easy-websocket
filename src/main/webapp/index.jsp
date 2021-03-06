<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Test websocket server</title>
</head>
<body>
<h1 style="text-align:center"><font size="16px">Welcome | websocket-based chat server</font></h1><br/>
<div style="text-align:center">
    <input id="text" style="width:200px;" type="text"/>
    <button onclick="send()">发送</button>
    <button onclick="closeSocket()">退出聊天</button>
    <div id="message"></div>
</div>

<div style="position: fixed; bottom: 0; text-align: center">
<strong>Author:hztaoran</strong><br/>
<strong>Github:https://github.com/Lemonjing</strong></br>
<strong>2016-7-3 All Rights Reserved.</strong><br/><br/>
</div>

</body>

<script type="text/javascript">
    var websocket = null;

    // 判断当前浏览器是否支持WebSocket
    if ('WebSocket' in window) {
        websocket = new WebSocket("ws://localhost:8080/websocket");
    } else {
        alert('Not Support WebSocket');
    }

    // 连接发生错误的回调方法
    websocket.onerror = function(event) {
        onError(event);
    }

    // 连接成功建立的回调方法
    websocket.onopen = function(event) {
        onOpen(event);
    }

    // 接收到消息的回调方法
    websocket.onmessage = function(event) {
        onMessage(event);
    }

    // 连接关闭的回调方法
    websocket.onclose = function(event) {
        alert('connection closed');
    }

    // 监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
    window.onbeforeunload = function() {
        websocket.close();
    }

    function onError(event) {
        alert(event.data);
    }

    function onOpen(event) {
        document.getElementById('message').innerHTML = 'Tip: Connection established';
    }

    function onMessage(event) {
        document.getElementById('message').innerHTML += '<br/>' + event.data;
    }

    // 关闭连接
    function closeSocket() {
        websocket.close();
    }

    // 发送消息
    function send() {
        var message = document.getElementById('text').value;
        websocket.send(message);
    }

</script>

</html>
