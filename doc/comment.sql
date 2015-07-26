--变量前有_标识

--用户
----注册,
insert into user (uid, uname, password, issu)
  values (_phonenum, _uname, _password, 0);
--站内信
----发送
insert into mail (fromuid, touid, issend,
   issrecv, time, content, attachment, isfromdel, istodel)
  values (_fromuid, _touid, 1,
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
----新建公告
insert into post (uid, title, starttime, endtime, content)
  values (_uid, _title, _starttime, _endtime, _content,);
------发送公告通知，请在本地下载全部用户使用循环逐条发送
insert into mail (fromuid, touid, issend,
    issrecv, time, content, isfromdel, istodel)
  values (_fromuid, _touid, 1,
    0, _time, _content, 0, 0);
----显示公告
select * from post order by endtime desc;

--新闻
----新闻类别
------新建新闻类别
insert into newstype (typename)
  values (_typename);
------获取新闻类别
select * from newstype
  where typename = _typename;
----新闻正文
------发布新闻
insert into news (typeid, uid, title, content, comment)
  values (_typeid, _uid, _title, _content, _comment);
------显示全部新闻
select * from news order by newsid desc;
------显示某一类别新闻
select * from news
  where typeid = _typeid
  order by newsid desc;
------修改新闻
update news set title = _title, content = _connect
  where newsid = _newsid;
------删除新闻
delete from comment
  where newsid = _newsid;

delete from news
  where newsid = _newsid;
----评论
------发布评论
insert into comment (newsid, uid, content)
  values (_newsid, _uid, _content);
------删除评论
delete from comment
  where commentid = _commentid;

--文档
----新建文档
insert into doc (uid, title, content, altertime)
  values (_uid, title, content, _altertime);
----编辑文档
update doc set title = _title, content = _connect, altertime = _altertime
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
------新建联系人分组
insert into contactgroup (groupname)
  values (_groupname);
----联系人信息
------新建联系人分组信息
insert into contact (uid, groupid)
  values (_uid, _groupid);
------转移联系人分组
update contact set groupid = _groupid
  where uid = _uid;
------查询所有联系人信息
select uname, uid from contact, users
  where contact.uid = users.uid;
------查询某一分组联系人信息
select uname, uid from contact, users
  where contact.uid = users.id and groupid = _groupid;
------按姓名查找联系人信息
select uname, uid from contact, users
  where contact.uid = users.uid and uname like "%_uname%";
------删除联系人信息
delete from contact
  where uid = _uid;
