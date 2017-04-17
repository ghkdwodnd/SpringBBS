package yjc.wdb.bbs.bean;

import java.sql.Date;

public class BoardReply {
//	create table tbl_reply(
//			rno int auto_increment primary key,
//			bno int references tbl_board(bno),
//			replyText varchar(1000) not null,
//			replyer varchar(50) not null,
//			regdate timestamp default now(),
//			updateDate timestamp default now()
//		)
	private int rno;
	private int bno;
	private String replyText;
	private String replyer;
	private Date regDate;
	private Date updateDate;
	
	@Override
	public String toString(){
		return "(rno:"+rno+", bno:"+bno+", replyText:"+replyText + ",replyer:"+replyer+")";
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getReplyText() {
		return replyText;
	}
	public void setReplyText(String replyText) {
		this.replyText = replyText;
	}
	public String getReplyer() {
		return replyer;
	}
	public void setReplyer(String replyer) {
		this.replyer = replyer;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
}
