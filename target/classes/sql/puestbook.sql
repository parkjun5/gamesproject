create table puestbook
(
	seqno number primary key  -- 시퀀스 번호,
	,guestname varchar2(30) not null -- 작성자 
	, savedfilename varchar2(300)  --저장된 사진
	,regdate date default sysdate -- 글쓴날짜
	,text varchar2(2000) not null -- 글내용
);
select * from guestbook;
create sequence puestbook_seq;
commit;