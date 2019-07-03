CREATE TABLE member
(
	id long NOT NULL,
	userId varchar(50) UNIQUE NOT NULL,
	userPass varchar(200) NOT NULL,
	regDate timestamp NOT NULL,
	primary key(id)
);