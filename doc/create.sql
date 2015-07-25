/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 10                       */
/* Created on:     2015/7/25 13:46:05                           */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_COMMENT_REFERENCE_NEWS') then
    alter table "comment"
       delete foreign key FK_COMMENT_REFERENCE_NEWS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_COMMENT_REFERENCE_USERS') then
    alter table "comment"
       delete foreign key FK_COMMENT_REFERENCE_USERS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_CONTACT_REFERENCE_CONTACTG') then
    alter table contact
       delete foreign key FK_CONTACT_REFERENCE_CONTACTG
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_CONTACT_REFERENCE_USERS') then
    alter table contact
       delete foreign key FK_CONTACT_REFERENCE_USERS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DOC_REFERENCE_USERS') then
    alter table doc
       delete foreign key FK_DOC_REFERENCE_USERS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_EXAMPLE_REFERENCE_FLOW') then
    alter table example
       delete foreign key FK_EXAMPLE_REFERENCE_FLOW
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_EXAMPLE_REFERENCE_USERS') then
    alter table example
       delete foreign key FK_EXAMPLE_REFERENCE_USERS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MAIL_REFERENCE_USERS_FROMUSER') then
    alter table mail
       delete foreign key FK_MAIL_REFERENCE_USERS_FROMUSER
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MAIL_REFERENCE_USERS_TOUSER') then
    alter table mail
       delete foreign key FK_MAIL_REFERENCE_USERS_TOUSER
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_NEWS_REFERENCE_NEWSTYPE') then
    alter table news
       delete foreign key FK_NEWS_REFERENCE_NEWSTYPE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_NEWS_REFERENCE_USERS') then
    alter table news
       delete foreign key FK_NEWS_REFERENCE_USERS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_POST_REFERENCE_USERS') then
    alter table post
       delete foreign key FK_POST_REFERENCE_USERS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_STEP_REFERENCE_FLOW') then
    alter table step
       delete foreign key FK_STEP_REFERENCE_FLOW
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_STEP_REFERENCE_USERS') then
    alter table step
       delete foreign key FK_STEP_REFERENCE_USERS
end if;

if exists(
   select 1 from sys.systable 
   where table_name='comment'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table "comment"
end if;

if exists(
   select 1 from sys.systable 
   where table_name='contact'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table contact
end if;

if exists(
   select 1 from sys.systable 
   where table_name='contactgroup'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table contactgroup
end if;

if exists(
   select 1 from sys.systable 
   where table_name='doc'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table doc
end if;

if exists(
   select 1 from sys.systable 
   where table_name='example'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table example
end if;

if exists(
   select 1 from sys.systable 
   where table_name='flow'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table flow
end if;

if exists(
   select 1 from sys.systable 
   where table_name='mail'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table mail
end if;

if exists(
   select 1 from sys.systable 
   where table_name='news'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table news
end if;

if exists(
   select 1 from sys.systable 
   where table_name='newstype'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table newstype
end if;

if exists(
   select 1 from sys.systable 
   where table_name='post'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table post
end if;

if exists(
   select 1 from sys.systable 
   where table_name='step'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table step
end if;

if exists(
   select 1 from sys.systable 
   where table_name='users'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table users
end if;

/*==============================================================*/
/* Table: "comment"                                             */
/*==============================================================*/
create table "comment" 
(
   newsid               int                            null,
   uid                  char(20)                       null,
   commentid            int                            not null,
   content              text                           null,
   constraint PK_COMMENT primary key clustered (commentid)
);

/*==============================================================*/
/* Table: contact                                               */
/*==============================================================*/
create table contact 
(
   uid                  char(20)                       not null,
   groupid              int                            not null,
   constraint PK_CONTACT primary key clustered (uid, groupid)
);

/*==============================================================*/
/* Table: contactgroup                                          */
/*==============================================================*/
create table contactgroup 
(
   groupid              int                            not null,
   groupname            varchar(10)                    null,
   constraint PK_CONTACTGROUP primary key clustered (groupid)
);

/*==============================================================*/
/* Table: doc                                                   */
/*==============================================================*/
create table doc 
(
   uid                  char(20)                       not null,
   docid                int                            not null,
   title                varchar(10)                    null,
   content              text                           null,
   attachment           varchar                        null,
   altername            datetime                       null,
   constraint PK_DOC primary key clustered (docid)
);

/*==============================================================*/
/* Table: example                                               */
/*==============================================================*/
create table example 
(
   flowid               int                            null,
   uid                  char(20)                       null,
   exampleid            int                            not null,
   currentstep          int                            null,
   constraint PK_EXAMPLE primary key clustered (exampleid)
);

/*==============================================================*/
/* Table: flow                                                  */
/*==============================================================*/
create table flow 
(
   flowid               int                            not null,
   flowname             varchar(30)                    null,
   constraint PK_FLOW primary key clustered (flowid)
);

/*==============================================================*/
/* Table: mail                                                  */
/*==============================================================*/
create table mail 
(
   mailid               int                            not null,
   fromuid              char(20)                       null,
   touid                char(20)                       null,
   issend               bit                            null,
   isrecv               bit                            null,
   "time"               datetime                       null,
   content              text                           null,
   attachment           varchar                        null,
   isfromdel            bit                            null,
   istodel              bit                            null,
   constraint PK_MAIL primary key clustered (mailid)
);

/*==============================================================*/
/* Table: news                                                  */
/*==============================================================*/
create table news 
(
   newsid               int                            not null,
   typeid               int                            null,
   uid                  char(20)                       null,
   title                varchar(50)                    null,
   image                varchar                        null,
   content              text                           null,
   "comment"            bit                            null,
   constraint PK_NEWS primary key clustered (newsid)
);

/*==============================================================*/
/* Table: newstype                                              */
/*==============================================================*/
create table newstype 
(
   typeid               int                            not null,
   typename             varchar(5)                     null,
   constraint PK_NEWSTYPE primary key clustered (typeid)
);

/*==============================================================*/
/* Table: post                                                  */
/*==============================================================*/
create table post 
(
   postid               int                            not null,
   uid                  char(20)                       null,
   title                varchar(50)                    null,
   range                varchar(20)                    null,
   starttime            datetime                       null,
   endtime              datetime                       null,
   contemt              text                           null,
   attachment           varchar                        null,
   constraint PK_POST primary key clustered (postid)
);

/*==============================================================*/
/* Table: step                                                  */
/*==============================================================*/
create table step 
(
   stepid               int                            not null,
   flowid               int                            null,
   responuid            char(20)                       null,
   stepname             varchar(20)                    null,
   stepnum              int                            null,
   content              text                           null,
   constraint PK_STEP primary key clustered (stepid)
);

/*==============================================================*/
/* Table: users                                                 */
/*==============================================================*/
create table users 
(
   uid                  char(20)                       not null,
   uname                varchar(10)                    null,
   password             varchar(16)                    null,
   issu                 bit                            null,
   phonenum             varchar(11)                    null,
   email                varchar(30)                    null,
   constraint PK_USERS primary key clustered (uid)
);

alter table "comment"
   add constraint FK_COMMENT_REFERENCE_NEWS foreign key (newsid)
      references news (newsid)
      on update restrict
      on delete restrict;

alter table "comment"
   add constraint FK_COMMENT_REFERENCE_USERS foreign key (uid)
      references users (uid)
      on update restrict
      on delete restrict;

alter table contact
   add constraint FK_CONTACT_REFERENCE_CONTACTG foreign key (groupid)
      references contactgroup (groupid)
      on update restrict
      on delete restrict;

alter table contact
   add constraint FK_CONTACT_REFERENCE_USERS foreign key (uid)
      references users (uid)
      on update restrict
      on delete restrict;

alter table doc
   add constraint FK_DOC_REFERENCE_USERS foreign key (uid)
      references users (uid)
      on update restrict
      on delete restrict;

alter table example
   add constraint FK_EXAMPLE_REFERENCE_FLOW foreign key (flowid)
      references flow (flowid)
      on update restrict
      on delete restrict;

alter table example
   add constraint FK_EXAMPLE_REFERENCE_USERS foreign key (uid)
      references users (uid)
      on update restrict
      on delete restrict;

alter table mail
   add constraint FK_MAIL_REFERENCE_USERS_FROMUSER foreign key (fromuid)
      references users (uid)
      on update restrict
      on delete restrict;

alter table mail
   add constraint FK_MAIL_REFERENCE_USERS_TOUSER foreign key (touid)
      references users (uid)
      on update restrict
      on delete restrict;

alter table news
   add constraint FK_NEWS_REFERENCE_NEWSTYPE foreign key (typeid)
      references newstype (typeid)
      on update restrict
      on delete restrict;

alter table news
   add constraint FK_NEWS_REFERENCE_USERS foreign key (uid)
      references users (uid)
      on update restrict
      on delete restrict;

alter table post
   add constraint FK_POST_REFERENCE_USERS foreign key (uid)
      references users (uid)
      on update restrict
      on delete restrict;

alter table step
   add constraint FK_STEP_REFERENCE_FLOW foreign key (flowid)
      references flow (flowid)
      on update restrict
      on delete restrict;

alter table step
   add constraint FK_STEP_REFERENCE_USERS foreign key (responuid)
      references users (uid)
      on update restrict
      on delete restrict;

