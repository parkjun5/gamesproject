


--이전 테이블 삭제
drop sequence puestbook_seq;
drop table puestbook;


drop sequence preply_seq;
drop table preply;

DROP TABLE MAINBOARD;
drop sequence boardno_seq;

drop table puser;
drop sequence puser_seq;


--댓글 테이블 생성

create table preply(
	replyno number primary key
	, writer varchar2(30) not null
     , savedfilename varchar2(300)
	, regdate date default sysdate
	, replytext varchar2(1000) not null
	, boardno number references mainboard(boardno) on delete cascade
);


create sequence preply_seq;

select * from puser;
create table  puser
	(
	useremail varchar2(50) primary key
	, userpwd varchar2(20) not null
	, username varchar2(30) not null
	, userno varchar2(15) not null
	, userkey varchar2(80)
	, originalfilename varchar2(300)
	, savedfilename varchar2(300)
	);
create sequence puser_seq;

select * from mainboard;
create table mainboard
(
	boardno number primary key
	, writer varchar2(30) not null
	, title varchar2(200) not null
	, content LONG not null 
	, regdate date default sysdate
	, hitcount number default 0
);

create sequence boardno_seq;

create table puestbook
(
	seqno number primary key  -- 시퀀스 번호,
	,guestname varchar2(30) not null -- 작성자 
	, savedfilename varchar2(300)  --저장된 사진
	,regdate date default sysdate -- 글쓴날짜
	,text varchar2(2000) not null -- 글내용
);

create sequence puestbook_seq;
commit;