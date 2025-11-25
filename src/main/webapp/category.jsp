<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FilenameFilter" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    String ctx  = request.getContextPath();
    String type = request.getParameter("type");
    if (type == null) type = "love";

    boolean isGenerated = "generated".equals(type);

    String displayName;         // 화면에 보여줄 이름
    String folderName = null;   // 일반 카테고리용 폴더(한글)

    // ---- 1. 카테고리 이름/폴더 결정 ----
    if (isGenerated) {
        displayName = "우리들의 명언";
    } else {
        switch (type) {
            case "motivation":
                folderName  = "동기부여";
                displayName = "동기부여";
                break;
            case "life":
                folderName  = "삶";
                displayName = "삶";
                break;
            case "philosophy":
                folderName  = "철학";
                displayName = "철학";
                break;
            case "love":
            default:
                folderName  = "사랑";
                displayName = "사랑";
                type        = "love";
                break;
        }
    }

    // ---- 2. 이 카테고리에 속한 이미지 목록 만들기 ----
    List<String> imgList = new ArrayList<String>();
    List<Integer> idList = new ArrayList<Integer>();   // ★ 우리들의 명언에서 쓸 id 목록
    int currentId = -1;                                // ★ 현재 이미지의 quote.id

    if (isGenerated) {
        // DB에서 id, image_path 읽어오기 (가장 최근 것이 먼저)
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url  = "jdbc:mysql://localhost:3306/quote_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Seoul";
            String user = "quote_user";
            String pwd  = "q1234";

            // ★ id도 같이 가져와야 나중에 삭제 가능
            String sql = "SELECT id, image_path FROM quote ORDER BY created_at DESC";

            try (Connection conn = DriverManager.getConnection(url, user, pwd);
                 PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String img = rs.getString("image_path");
                    if (img == null) continue;
                    img = img.trim();
                    if (img.length() == 0) continue;

                    if (!img.startsWith("http") && !img.startsWith(ctx)) {
                        if (!img.startsWith("/")) img = "/" + img;
                        img = ctx + img;
                    }
                    idList.add(id);     // ★ id 저장
                    imgList.add(img);   // 이미지 경로 저장
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        // 일반 카테고리: /resources/사랑, /resources/철학 ... 폴더에서 읽기
        String dirPath = application.getRealPath("/resources/" + folderName);
        File imgDir = new File(dirPath);

        File[] imgFiles = imgDir.listFiles(new FilenameFilter() {
            public boolean accept(File dir, String name) {
                String lower = name.toLowerCase();
                return lower.endsWith(".jpg") || lower.endsWith(".jpeg")
                        || lower.endsWith(".png") || lower.endsWith(".gif");
            }
        });

        if (imgFiles != null && imgFiles.length > 0) {
            Arrays.sort(imgFiles, new Comparator<File>() {
                public int compare(File f1, File f2) {
                    return f1.getName().compareToIgnoreCase(f2.getName());
                }
            });

            for (File f : imgFiles) {
                String fileName = f.getName();
                String urlPath  = ctx + "/resources/" + folderName + "/" + fileName;
                imgList.add(urlPath);
            }
        }
    }

    // ---- 3. 인덱스 계산 (idx, prevIdx, nextIdx) ----
    int total = imgList.size();
    int idx   = 0;

    try {
        String idxParam = request.getParameter("idx");
        if (idxParam != null) {
            idx = Integer.parseInt(idxParam);
        }
    } catch (Exception e) {
        idx = 0;
    }

    if (total > 0) {
        if (idx < 0)      idx = 0;
        if (idx >= total) idx = 0;
    } else {
        idx = 0;
    }

    int prevIdx = 0;
    int nextIdx = 0;
    String imgUrl = null;

    if (total > 0) {
        prevIdx = (idx - 1 + total) % total;
        nextIdx = (idx + 1) % total;
        imgUrl  = imgList.get(idx);

        if (isGenerated) {              // ★ 현재 이미지에 대응하는 DB id 세팅
            currentId = idList.get(idx);
        }
    }

    // ---- 4. (선택) 삭제용 파일명 추출 – 지금은 안 써도 됨 ----
    String fileNameForDelete = null;
    if (imgUrl != null) {
        int slash = imgUrl.lastIndexOf('/');
        if (slash != -1 && slash < imgUrl.length() - 1) {
            fileNameForDelete = imgUrl.substring(slash + 1);
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>TheQuoteBox - <%=displayName%> 카테고리</title>
  <style>
body {
  margin: 0;
  padding: 0;
  font-family: Arial, sans-serif;
  background: #ffffff;
  color: #000000;
}

.header {
  border: 3px solid #000000;
  padding: 0 32px;
  font-size: 32px;
  font-weight: bold;
  height: 90px;
  box-sizing: border-box;
  display: flex;
  align-items: center;
  background-color: #000000;
  color: #ffffff;
  justify-content: space-between;
}

.logo-link {
  display: flex;
  align-items: center;
  height: 100%;
}

.logo-image {
  height: 80px;
  width: auto;
  display: block;
}

.menu {
  display: flex;
  gap: 2vw;
}

.menu a {
  color: #ffffff;
  font-size: 1.3vw;
  font-weight: bold;
  text-decoration: none;
}

.menu a:hover {
  text-decoration: underline;
}

.container {
  border: 3px solid #000000;
  padding: 3vw;
  min-height: 70vh;
  box-sizing: border-box;
}

/* 중앙 이미지 뷰어 (모든 카테고리 공통) */
.viewer {
  max-width: 1100px;
  margin: 0 auto;
  text-align: center;
}

.category-title {
  font-size: 28px;
  font-weight: bold;
  margin-bottom: 20px;
}

.image-wrapper {
  position: relative;
  display: inline-block;
  background: #000;
  padding: 20px;
  border-radius: 8px;
}

.main-img {
  max-width: 100%;
  height: auto;
  display: block;
  border-radius: 4px;
}

/* 버튼 스타일 공통 */
.nav-btn {
  display: inline-block;
  margin: 20px 10px 0;
  font-size: 18px;
  padding: 8px 16px;
  border-radius: 4px;
  border: 1px solid #000;
  background: #000;
  color: #fff;
  text-decoration: none;
  cursor: pointer;
}

.nav-btn:hover {
  background: #333;
}

/* 삭제 버튼 전용 색상 */
.delete-btn {
  background: #b00000;
  border-color: #b00000;
}
.delete-btn:hover {
  background: #e00000;
}

/* 비밀번호 입력칸 */
.pass-input {
  width: 70px;
  padding: 4px;
  text-align: center;
}

.counter {
  margin-top: 10px;
  font-size: 14px;
}

.footer {
  border: 3px solid #000000;
  padding: 10px;
  text-align: center;
  font-size: 14px;
  background-color: #000000;
  color: #ffffff;
}

a {
  text-decoration: none;
}
  </style>
</head>
<body>
<div class="header">
  <a href="main.jsp" class="logo-link">
    <img src="resources/logo.png" alt="TheQuoteBox" class="logo-image">
  </a>
  <div class="menu">
    <a href="todayQuote.jsp">오늘의 명언</a>
    <a href="quote.jsp">명언 만들기</a>
  </div>
</div>

<div class="container">
  <div class="viewer">
    <div class="category-title"><%=displayName%> 카테고리</div>

    <% if (total == 0) { %>
      <% if (isGenerated) { %>
        <p>아직 생성된 명언이 없습니다.</p>
      <% } else { %>
        <p>이 카테고리에 등록된 이미지가 없습니다.</p>
      <% } %>
    <% } else { %>
      <div class="image-wrapper">
        <img src="<%=imgUrl%>" alt="<%=displayName%>" class="main-img">
      </div>

      <div class="counter">
        <%= (idx + 1) %> / <%= total %>
      </div>

      <div>
        <!-- 이전 버튼 -->
        <button class="nav-btn" type="button"
                onclick="location.replace('category.jsp?type=<%=type%>&idx=<%=prevIdx%>')">
          ◀ 이전
        </button>

        <% if (isGenerated) { %>
          <!-- 우리들의 명언일 때만: 다운로드 + 삭제 폼 -->
          <a class="nav-btn" href="<%= imgUrl %>" download="quote_image.png">
            이미지 다운로드
          </a>

          <form action="deleteQuote.jsp" method="post" style="display:inline-block;">
            <input type="hidden" name="id"  value="<%= currentId %>">
            <input type="hidden" name="idx" value="<%= idx %>">

            비밀번호:
            <input type="password"
                   name="passcode"
                   maxlength="4"
                   inputmode="numeric"
                   required
                   class="pass-input"
                   placeholder="1234"><!-- ★ pattern 제거 -->

            <button type="submit" class="nav-btn delete-btn">삭제</button>
          </form>
        <% } %>

        <!-- 다음 버튼 -->
        <button class="nav-btn" type="button"
                onclick="location.replace('category.jsp?type=<%=type%>&idx=<%=nextIdx%>')">
          다음 ▶
        </button>
      </div>
    <% } %>
  </div>
</div>

<div class="footer">
  Made by 김규환 김민서 이민태
</div>
</body>
</html>
