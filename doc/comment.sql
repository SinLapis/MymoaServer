--变量前有_标识

--用户
----注册,
insert into user (uid, uname, password, issu, phonenum, email)
  values (_phonenum, _uname, _password, 0, _phonenum, _email);
--站内信
----新建建立id序列
CREATE SEQUENCE mailid_sequence increment by 1
  start with 1 nomaxvalue NOCYCLE;
----发送
insert into mail (mailid, fromuid, touid, issend,
   issrecv, time, content, attachment, isfromdel, istodel)
  values (mailid_sequence.NEXTVAL, _fromuid, _touid, 1,
   0, _time, _content, _attachment, 0, 0);
----接收未查看
select * from mail
  where touid = _touid and isrecv = 0
  order by time desc;

update mail set issrecv = 1
  where touid = _touid and isrecv = 0;
----接收已查看
select * from mail
  where touid = _touid and isrecv = 1 and istodel = 0
  order by time desc;
----查看已发送
select * from mail
  where touid = _touid and isrecv = 1
  order by time desc;
----删除已接收
update mail set istodel = 1
    where touid = _touid and mailid = _mailid;

delete from mail
  where isfromdel = 1 and istodel = 1;
----删除已发送
update mail set isfromdel = 1
    where fromuid = _fromuid and mailid = _mailid;

delete from mail
  where isfromdel = 1 and istodel = 1;
----根据发件人/收件人查询
select * from mail
  where touid = _touid and fromuid = _fromuid
  order by time desc;
----根据起止时间查询
select * from mail
  where time >= _starttime and time <= _endtime
  order by time desc;

--公告
----新建建立id序列
CREATE SEQUENCE postid_sequence increment by 1
  start with 1 nomaxvalue NOCYCLE;
----新建公告
insert into post (postid, uid, title, range, starttime,
    endtime, content, attachment)
  values (postid_sequence.NEXTVAL, _uid, _title, _range, _starttime
    _endtime, _content, _attachment);
------发送公告通知，请在本地下载全部用户使用循环逐条发送
insert into mail (mailid, fromuid, touid, issend,
    issrecv, time, content, attachment, isfromdel, istodel)
  values (mailid_sequence.NEXTVAL, _fromuid, _touid, 1,
    0, _time, _content, _attachment, 0, 0);
----显示公告
select * from post order by endtime desc;

--新闻
----新闻类别
------新建建立id序列
CREATE SEQUENCE newstypeid_sequence increment by 1
  start with 1 nomaxvalue NOCYCLE;
------新建新闻类别
insert into newstype (typei d, typename)
  values (newstypeid_sequence, _typename);
------获取新闻类别
select * from newstype
  where typename = _typename;
----新闻正文
------新建建立id序列
CREATE SEQUENCE newsid_sequence increment by 1
  start with 1 nomaxvalue NOCYCLE;
------发布新闻
insert into news (newsid, typeid, uid, title,
   image, content, comment)
  values (newsid_sequence.NEXTVAL, _typeid, _uid, _title,
   _image, _content, _comment);
------显示全部新闻
select * from news order by newsid desc;
------显示某一类别新闻
select * from news
  where typeid = _typeid
  order by newsid desc;
------修改新闻
update news set title = _title, image = _image,
   content = _connect, comment = _comment
  where newsid = _newsid;
------删除新闻
delete from comment
  where newsid = _newsid;

delete from news
  where newsid = _newsid;
----评论
------新建建立id序列
CREATE SEQUENCE commentid_sequence increment by 1
  start with 1 nomaxvalue NOCYCLE;
------发布评论
insert into comment (commentid, newsid, uid, content)
  values (commentid_sequence.NEXTVAL, _newsid, _uid, _content);
------删除评论
delete from comment
  where commentid = _commentid;

--文档
----新建建立id序列
CREATE SEQUENCE docid_sequence increment by 1
  start with 1 nomaxvalue NOCYCLE;
----新建文档
insert into doc (docid, uid, title, content,
   attachment, altername)
  values (docid_sequence.NEXTVAL, _uid, title, content,
   _attachment, _altername);
----编辑文档
update doc set title = _title, content = _connect,
   attachment = _attachment, altername = _altername
  where docid = _docid;
----删除文档
delete from doc where docid = _docid;
----显示全部文档
select * from doc order by docid desc;
----按标题查询文档
select * from doc
  where title like "%_title%";

--通讯录
----联系人分组
------新建建立id序列
CREATE SEQUENCE groupid_sequence increment by 1
  start with 1 nomaxvalue NOCYCLE;
------新建联系人分组
insert into contactgroup (groupid, groupname)
  values (groupid_sequence.NEXTVAL, _groupname);
----联系人信息
------新建联系人分组信息
insert into contact (uid, groupid)
  values (_uid, _groupid);
------转移联系人分组
update contact set groupid = _groupid
  where uid = _uid;
------查询所有联系人信息
select uname, phonenum, email from contact, users
  where contact.uid = users.uid;
------查询某一分组联系人信息
select uname, phonenum, email from contact, users
  where contact.uid = users.id and groupid = _groupid;
------按姓名查找联系人信息
select uname, phonenum, email from contact, users
  where contact.uid = users.uid and uname like "%_uname%";
------删除联系人信息
delete from contact
  where uid = _uid;
