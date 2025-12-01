<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.File" %>

<%
    request.setCharacterEncoding("UTF-8");

    // category.jsp 에서 넘어온 값
    String idParam  = request.getParameter("id");
    String idxParam = request.getParameter("idx");
    String inputPw  = request.getParameter("passcode");

    int idx = 0;
    try {
        if (idxParam != null) idx = Integer.parseInt(idxParam);
    } catch (Exception e) {
        idx = 0;
    }

    // 리다이렉트할 기본 경로 (우리들의 명언 카테고리)
    String redirectUrl = "category.jsp?type=generated&idx=" + idx;

    if (idParam == null || inputPw == null || inputPw.length() == 0) {
%>
<script>
    alert("잘못된 요청입니다.");
    location.href = "<%= redirectUrl %>";
</script>
<%
        return;
    }

    int id = Integer.parseInt(idParam);

    String dbPw = null;
    String imagePath = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url  = "jdbc:mysql://localhost:3306/quote_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Seoul";
        String user = "quote_user";
        String pwd  = "q1234";

        try (Connection conn = DriverManager.getConnection(url, user, pwd)) {

            // 1) 비밀번호 + 이미지 경로 조회
            String selSql = "SELECT passcode, image_path FROM quote WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(selSql)) {
                ps.setInt(1, id);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        dbPw      = rs.getString("passcode");
                        imagePath = rs.getString("image_path");
                    }
                }
            }

            if (dbPw == null) {
                // 이미 삭제됐거나 없는 id
%>
<script>
    alert("이미 삭제되었거나 존재하지 않는 명언입니다.");
    location.href = "<%= redirectUrl %>";
</script>
<%
                return;
            }

            if (!inputPw.equals(dbPw)) {
                // 비밀번호 불일치
%>
<script>
    alert("비밀번호가 일치하지 않습니다.");
    history.back();      // 입력 폼으로 되돌리기
</script>
<%
                return;
            }

            // 2) 비밀번호 일치 → DB 레코드 삭제
            String delSql = "DELETE FROM quote WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(delSql)) {
                ps.setInt(1, id);
                ps.executeUpdate();
            }

            // 3) (옵션) 실제 이미지 파일도 같이 삭제
            if (imagePath != null && imagePath.trim().length() > 0) {
                // DB에는 "generated_images/파일명" 이런 식으로 들어 있다고 가정
                String real = application.getRealPath("/" + imagePath);
                if (real != null) {
                    File f = new File(real);
                    if (f.exists()) {
                        try { f.delete(); } catch (Exception ex) { /* 무시 */ }
                    }
                }
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
%>
<script>
    alert("삭제 중 오류가 발생했습니다.");
    location.href = "<%= redirectUrl %>";
</script>
<%
        return;
    }
%>

<!-- 여기까지 오면 삭제 성공 -->
<script>
    alert("삭제되었습니다.");
    // 우리들의 명언 카테고리 페이지로 그대로 유지
    location.href = "<%= redirectUrl %>";
</script>
