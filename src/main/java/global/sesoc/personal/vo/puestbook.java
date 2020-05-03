package global.sesoc.personal.vo;

import lombok.Data;

@Data
public class puestbook {
	
	private int seqno;
	private String guestname;
	private String savedfilename;
	private String regdate;
	private String text;
}
