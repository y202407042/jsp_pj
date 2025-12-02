package com.example.jsp_pj.dto;

public class QuoteDTO {
    private int id;
    private String content;
    private String author;
    private String category;

    public QuoteDTO() {}
    // 모든 필드를 초기화하는 생성자
    public QuoteDTO(int id, String content, String author, String category) {
        this.id = id;
        this.content = content;
        this.author = author;
        this.category = category;
    }
    // ID, 명언 내용, 작성자, 카테고리 반환 및 설정
    public int getId() { return id; }
    public String getContent() { return content; }
    public String getAuthor() { return author; }
    public String getCategory() { return category; }

    public void setId(int id) { this.id = id; }
    public void setContent(String content) { this.content = content; }
    public void setAuthor(String author) { this.author = author; }
    public void setCategory(String category) { this.category = category; }
}
