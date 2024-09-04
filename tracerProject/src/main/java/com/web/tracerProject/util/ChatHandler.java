package com.web.tracerProject.util;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.web.tracerProject.vo.Chatting;

@Component
public class ChatHandler extends TextWebSocketHandler {

	private final Map<String, WebSocketSession> users = new ConcurrentHashMap<>();
	private final Map<WebSocketSession, String> userNicknames = new ConcurrentHashMap<>();
	private final AtomicInteger guestCounter = new AtomicInteger(1); // 게스트 카운터

	@Autowired

	private ObjectMapper objectMapper = new ObjectMapper();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	    String nickname = (String) session.getAttributes().get("nickname");

	    if (nickname == null || nickname.isEmpty()) {
	        nickname = "Guest" + guestCounter.getAndIncrement();
	    }

	    userNicknames.put(session, nickname);
	    users.put(session.getId(), session);
	    System.out.println(nickname + "님 접속하셨습니다. 현재 접속자 수: " + users.size());
	    
	    // 닉네임을 모든 클라이언트에게 브로드캐스트하기 전에 사용자 목록을 보냅니다.
	    sendUserList();

	    // 입장 메시지 전송
	    sendJoinMessage(session, nickname);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	    String payload = message.getPayload();
	    System.out.println("Received message payload: " + payload);
	    Map<String, String> messageMap = objectMapper.readValue(payload, Map.class);

	    String email = messageMap.get("email");
	    String nickname = messageMap.get("nickname"); 
	    String content = messageMap.get("content");
	    String chatType = messageMap.get("chatType");
	    String chatName = messageMap.get("chatName"); 

	    Chatting chatMessage = new Chatting();
	    chatMessage.setChid(UUID.randomUUID().toString());
	    chatMessage.setEmail(email);
	    chatMessage.setNickname(nickname);
	    chatMessage.setSent_date(new Date());
	    chatMessage.setContent(content);

	    for (WebSocketSession userSession : users.values()) {
	        if (userSession.isOpen()) {
	            String sessionNickname = userNicknames.get(userSession); 
	            if ("group".equals(chatType)) {
	                userSession.sendMessage(new TextMessage(payload));
	            } else if (sessionNickname.equals(chatName)) {
	                userSession.sendMessage(new TextMessage(payload));
	            }
	        }
	    }
	}


	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
	    System.out.println(session.getId() + " 에러 발생: " + exception.getMessage());
	    // 예외 발생 시 세션 종료
	    if (session.isOpen()) {
	        session.close(CloseStatus.SERVER_ERROR);
	    }
	}


	private void sendUserList() throws Exception {
	    List<String> userList = new ArrayList<>(userNicknames.values());
	    String userListMessage = "USER_LIST" + objectMapper.writeValueAsString(userList);
	    
	    // 모든 접속자에게 사용자 목록을 브로드캐스트
	    for (WebSocketSession userSession : users.values()) {
	        userSession.sendMessage(new TextMessage(userListMessage));
	    }
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) 
			throws Exception {
		String nickname = userNicknames.get(session);
		users.remove(session.getId());
		userNicknames.remove(session);
		System.out.println(nickname + "님 접속 종료");

		String leaveMessage = String.format("{\"nickname\":\"%s\", "
				+ "\"content\":\"%s님이 퇴장하셨습니다\", \"chatType\":\"system\", "
				+ "\"chatName\":\"all\"}", nickname,
				nickname);
		for (WebSocketSession userSession : users.values()) {
			userSession.sendMessage(new TextMessage(leaveMessage));
		}
		sendUserList();
	}

	private void sendJoinMessage(WebSocketSession session, String nickname) 
			throws Exception {
		String joinMessage = String.format("{\"nickname\":\"%s\", "
				+ "\"content\":\"%s님이 입장하셨습니다!\", \"chatType\":\"system\", " 
				+ "\"chatName\":\"all\"}", nickname,
				nickname);
		for (WebSocketSession userSession : users.values()) {
			if (!userSession.getId().equals(session.getId())) {
				userSession.sendMessage(new TextMessage(joinMessage));
			}
		}
	}
}
