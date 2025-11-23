<%-- quote.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>

<%
    // preset_backgrounds 폴더의 실제 경로
    String presetPath = application.getRealPath("/preset_backgrounds");
    File presetDir = new File(presetPath);

    // 폴더 안의 파일 목록
    File[] backgroundFiles = presetDir.listFiles();

    // 컨텍스트 경로 (예: /jspkgh)
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>명언 이미지 생성</title>
    <style>
        body {
            font-family: "Malgun Gothic", sans-serif;
            margin: 30px;
        }
        h1 {
            margin-bottom: 10px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            max-width: 900px;
        }
        td {
            padding: 10px;
            vertical-align: top;
        }
        .bg-choice {
            width: 100px;
            height: 75px;
            object-fit: cover;
            border: 2px solid #ccc;
            cursor: pointer;
            margin-right: 6px;
            margin-bottom: 6px;
        }
        input[type="radio"]:checked + img {
            border-color: #007bff;
        }
        textarea {
            width: 100%;
            box-sizing: border-box;
        }
        input[type="text"] {
            width: 100%;
            box-sizing: border-box;
        }
    </style>
</head>
<body>

<h1>명언 이미지 생성기</h1>
<p>사진과 텍스트를 입력하여 이미지를 만들어보세요.</p>

<form name="quote" action="<%=ctx%>/processImage.jsp" method="post"
      enctype="multipart/form-data">

    <table border="1">
        <tr>
            <%-- 왼쪽: 명언 내용 입력 --%>
            <td style="width: 65%;">
                <h3>① 명언 내용</h3>
                <label for="quoteText">이미지 중앙에 들어갈 문장입니다.</label><br>
                <textarea name="quoteText" id="quoteText" rows="5"
                          placeholder="예)\n산을 움직이려 하는 이는\n작은 돌을 들어내는 일로 시작한다."></textarea>
            </td>

            <%-- 오른쪽: 화자 입력 --%>
            <td style="width: 35%;">
                <h3>② 화자</h3>
                <label for="speaker">이미지 오른쪽 아래에 작게 표시됩니다.</label><br>
                <input type="text" name="speaker" id="speaker"
                       placeholder="예) 춘추 시대의 유학자 &lt;공자&gt;">
                <br><br>
                <small>※ 내용과 화자는 따로 입력됩니다.</small>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <h3>③ 배경 사진 선택</h3>
                <p>왼쪽에 들어갈 인물 사진을 선택하세요.</p>

                <%-- preset_backgrounds 폴더의 이미지 파일을 동적으로 라디오 + 썸네일로 출력 --%>
                <%
                    if (backgroundFiles != null && backgroundFiles.length > 0) {
                        boolean isFirst = true; // 첫 번째 항목 체크용
                        for (File file : backgroundFiles) {
                            if (!file.isFile()) continue; // 폴더는 스킵

                            String lowerName = file.getName().toLowerCase();

                            // 이미지 파일만 사용
                            if (!(lowerName.endsWith(".jpg") || lowerName.endsWith(".jpeg")
                                  || lowerName.endsWith(".png") || lowerName.endsWith(".gif"))) {
                                continue;
                            }

                            String originalName = file.getName();
                %>
                            <label>
                                <%-- name="preset" : processImage.jsp 에서 multi.getParameter("preset") 로 받음 --%>
                                <input type="radio" name="preset"
                                       value="<%= originalName %>" <%= (isFirst ? "checked" : "") %>>
                                <img src="<%=ctx%>/preset_backgrounds/<%= originalName %>" class="bg-choice">
                            </label>
                <%
                            isFirst = false;
                        }
                    } else {
                %>
                        배경 이미지 폴더(<code>/preset_backgrounds</code>)를 찾을 수 없거나 이미지가 없습니다.
                <%
                    }
                %>
            </td>
        </tr>

        <tr>
            <td colspan="2" style="text-align: center;">
                <input type="submit" value="이미지 생성하기">
            </td>
        </tr>
    </table>
</form>

</body>
</html>
