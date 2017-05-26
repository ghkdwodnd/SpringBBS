create table tbl_attach(
	bno int references tbl_board(bno),
	fileName varchar(256) primary key,
	regdate timestamp default now()
)