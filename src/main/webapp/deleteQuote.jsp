<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.File" %>

<%
    // UTF-8 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // category.jsp에서 넘어온 파라미터 받기
    String idParam  = request.getParameter("id");      // 명언 ID
    String idxParam = request.getParameter("idx");     // 카테고리 인덱스
    String inputPw  = request.getParameter("passcode"); // 입력 비밀번호

    // idx 파싱 (예외처리)
    int idx = 0;
    try {
        if (idxParam != null) idx = Integer.parseInt(idxParam);
    } catch (Exception e) {
        idx = 0; // 기본값
    }

    // 리다이렉트 기본 경로 (우리들의 명언 카테고리)
    String redirectUrl = "category.jsp?type=generated&idx=" + idx;

    // 필수 파라미터 검증
    if (idParam == null || inputPw == null || inputPw.length() == 0) {
%>
<script>
    alert("잘못된 요청입니다.");
    location.href = "<%= redirectUrl %>";
</script>
<%
        return;
    }

    int id = Integer.parseInt(idParam); // ID 숫자 변환

    String dbPw = null;      // DB 저장 비밀번호
    String imagePath = null; // 이미지 파일 경로

    try {
        // 1. MySQL JDBC 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // 2. DB 연결 정보
        String url  = "jdbc:mysql://localhost:3306/quote_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Seoul";
        String user = "quote_user";
        String pwd  = "q1234";

        // 3. DB 연결 및 삭제 작업
        try (Connection conn = DriverManager.getConnection(url, user, pwd)) {

            // 3-1) ID로 비밀번호 + 이미지 경로 조회
            String selSql = "SELECT passcode, image_path FROM quote WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(selSql)) {
                ps.setInt(1, id);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        dbPw = rs.getString("passcode");
                        imagePath = rs.getString("image_path");
                    }
                }
            }

            // 3-2) 해당 ID가 존재하지 않음
            if (dbPw == null) {
%>
<script>
    alert("이미 삭제되었거나 존재하지 않는 명언입니다.");
    location.href = "<%= redirectUrl %>";
</script>
<%
                return;
            }

            // 3-3) 비밀번호 불일치
            if (!inputPw.equals(dbPw)) {
%>
<script>
    alert("비밀번호가 일치하지 않습니다.");
    history.back(); // 입력 폼으로 복귀
</script>
<%
                return;
            }

            // 3-4) 비밀번호 일치 → DB 레코드 삭제
            String delSql = "DELETE FROM quote WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(delSql)) {
                ps.setInt(1, id);
                int deletedRows = ps.executeUpdate(); // 삭제된 행 수
                // System.out.println("삭제된 행: " + deletedRows);
            }

            // 3-5) 실제 이미지 파일 삭제 (옵션)
            if (imagePath != null && imagePath.trim().length() > 0) {
                String realPath = application.getRealPath("/" + imagePath); // 실제 파일 경로
                if (realPath != null) {
                    File imageFile = new File(realPath);
                    if (imageFile.exists()) {
                        try {
                            imageFile.delete(); // 물리적 파일 삭제
                        } catch (Exception ex) {
                            // 삭제 실패해도 무시 (로그만 남김)
                            // System.out.println("이미지 삭제 실패: " + realPath);
                        }
                    }
                }
            }
        } // 자동 Connection close (try-with-resources)

    } catch (ClassNotFoundException e) {
        // JDBC 드라이버 누락
%>
<script>
    alert("DB 드라이버 오류");
    location.href = "<%= redirectUrl %>";
</script>
<%
        e.printStackTrace();
        return;
    } catch (SQLException e) {
        // DB 연결/쿼리 오류
%>
<script>
    alert("DB 오류: " + e.getMessage());
    location.href = "<%= redirectUrl %>";
</script>
<%
        e.printStackTrace();
        return;
    } catch (Exception e) {
        // 기타 오류
%>
<script>
    alert("삭제 중 오류가 발생했습니다.");
    location.href = "<%= redirectUrl %>";
</script>
<%
        e.printStackTrace();
        return;
    }
%>

<!-- 4. 삭제 성공 -->
<script>
    alert("명언이 삭제되었습니다.");
    location.href = "<%= redirectUrl %>";
</script>
