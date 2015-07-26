/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2015/7/26 11:57:56                           */
/*==============================================================*/


drop table if exists comment;

drop table if exists contact;

drop table if exists contactgroup;

drop table if exists doc;

drop table if exists mail;

drop table if exists news;

drop table if exists newstype;

drop table if exists post;

drop table if exists users;

/*==============================================================*/
/* Table: comment                                               */
/*==============================================================*/
create table comment
(
   newsid               int,
   uid                  char(20),
   commentid            int not null auto_increment,
   content              longtext,
   primary key (commentid)
);

/*==============================================================*/
/* Table: contact                                               */
/*==============================================================*/
create table contact
(
   uid                  char(20) not null,
   groupid              int not null,
   primary key (uid, groupid)
);

/*==============================================================*/
/* Table: contactgroup                                          */
/*==============================================================*/
create table contactgroup
(
   groupid              int not null auto_increment,
   groupname            varchar(10),
   primary key (groupid)
);

/*==============================================================*/
/* Table: doc                                                   */
/*==============================================================*/
create table doc
(
   uid                  char(20) not null,
   docid                int not null auto_increment,
   title                varchar(10),
   content              longtext,
   altertime            datetime,
   primary key (docid)
);

/*==============================================================*/
/* Table: mail                                                  */
/*==============================================================*/
create table mail
(
   mailid               int not null auto_increment,
   fromuid              char(20),
   touid                char(20),
   issend               bool,
   isrecv               bool,
   time                 datetime,
   content              longtext,
   isfromdel            bool,
   istodel              bool,
   primary key (mailid)
);

/*==============================================================*/
/* Table: news                                                  */
/*==============================================================*/
create table news
(
   newsid               int not null auto_increment,
   typeid               int,
   uid                  char(20),
   title                varchar(50),
   content              longtext,
   primary key (newsid)
);

/*==============================================================*/
/* Table: newstype                                              */
/*==============================================================*/
create table newstype
(
   typeid               int not null auto_increment,
   typename             varchar(5),
   primary key (typeid)
);

/*==============================================================*/
/* Table: post                                                  */
/*==============================================================*/
create table post
(
   postid               int not null auto_increment,
   uid                  char(20),
   title                varchar(50),
   starttime            datetime,
   endtime              datetime,
   contemt              longtext,
   primary key (postid)
);

/*==============================================================*/
/* Table: users                                                 */
/*==============================================================*/
create table users
(
   uid                  char(20) not null,
   uname                varchar(10),
   password             varchar(16),
   issu                 bool,
   primary key (uid)
);

alter table comment add constraint FK_Reference_6 foreign key (newsid)
      references news (newsid) on delete restrict on update restrict;

alter table comment add constraint FK_Reference_7 foreign key (uid)
      references users (uid) on delete restrict on update restrict;

alter table contact add constraint FK_Reference_10 foreign key (groupid)
      references contactgroup (groupid) on delete restrict on update restrict;

alter table contact add constraint FK_Reference_9 foreign key (uid)
      references users (uid) on delete restrict on update restrict;

alter table doc add constraint FK_Reference_8 foreign key (uid)
      references users (uid) on delete restrict on update restrict;

alter table mail add constraint FK_MAIL_REFERENCE_USERS_FROMUSER foreign key (fromuid)
      references users (uid) on delete restrict on update restrict;

alter table mail add constraint FK_MAIL_REFERENCE_USERS_TOUSER foreign key (touid)
      references users (uid) on delete restrict on update restrict;

alter table news add constraint FK_Reference_4 foreign key (typeid)
      references newstype (typeid) on delete restrict on update restrict;

alter table news add constraint FK_Reference_5 foreign key (uid)
      references users (uid) on delete restrict on update restrict;

alter table post add constraint FK_Reference_3 foreign key (uid)
      references users (uid) on delete restrict on update restrict;

